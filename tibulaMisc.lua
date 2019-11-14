-- Copyright (C) 2007-2019 by Ubaldo Porcheddu <ubaldo@eja.it>
--
-- Nocturne no.20


function tibulaReset()    --reset global variables
 tibula['ejaSqlLimit']=0;
 tibula['ejaSqlOrder']="";
 tibula['ejaSqlQuery64']="";
 tibula['ejaValues']={};
 tibula['ejaId']=0;
end


function tibulaModuleLua(step,web)	--load lua script from ejaModule 
 tibulaModuleLuaStep=step
 local script=tibulaSqlRun('SELECT lua FROM ejaModules WHERE ejaId=%d;',tibula['ejaModuleId'])
 if ejaString(script) ~= '' then
   local func,err=loadstring(script,tibula['ejaModuleName'])(web)
   if func then 
    func()
   else
    ejaError('[tibula] %s',err)
   end
 end
end


function tibulaSessionRead(ownerId)      --return the ejaSessions array for $ownerId
 if ejaNumber(ownerId) > 0 then
  for k,v in pairs(tibulaSqlMatrix('SELECT name,sub,value FROM ejaSessions WHERE ejaOwner=%d ORDER BY ejaId ASC;',ownerId)) do
   if ejaString(v['sub']) ~= "" then 
    if not tibula[v['name']] then tibula[v['name']]={}; end
    tibula[v['name']][v['sub']]=v['value'];
   else
    tibula[v['name']]=v['value'];
   end
  end
 end
end


function tibulaSessionWrite(ownerId,values)	--write the ejaSession array 
 if ejaNumber(ownerId) > 0 then  
  tibulaSqlRun('SET @ejaOwner=%d;',ownerId);
  tibulaSqlRun('DELETE FROM ejaSessions WHERE ejaOwner=%d;',ownerId);
  for k,v in pairs(values) do
   if type(v) == "table" then
    for kk,vv in pairs(v) do
     if type(vv) ~= "table" then
      tibulaSqlRun("INSERT INTO ejaSessions (ejaLog,ejaOwner,name, sub, value) VALUES ('%s',%d,'%s','%s','%s');",tibulaSqlNow(),ownerId,k,kk,vv);
     end
    end
   else
    tibulaSqlRun('INSERT INTO ejaSessions (ejaLog,ejaOwner,name, value) VALUES ("%s",%d,"%s","%s");',tibulaSqlNow(),ownerId,k,v); 
   end
  end
 else
  tibulaSqlRun('SET @ejaOwner=0;');
 end 
end


function tibulaSessionCode()	--generate new ejaSession id
 local seed=tibula['ejaOwner']

 math.randomseed(os.time()) 
 for i=1,10 do seed=seed..math.random(0,9) end
 
 return ejaSha256(seed);
end


function tibulaTranslate(value)	--return translated value for active module and language or same if not found
 local r;

 if not tibula['ejaTranslation'] then
  tibula['ejaTranslation']={};
  tibula['ejaTranslation']['Eja']='eja';
  for k,v in pairs (tibulaSqlMatrix("SELECT word,translation FROM ejaTranslations where ejaLanguage='%s' AND (ejaModuleId=0 OR ejaModuleId='' OR ejaModuleId=%d) ORDER BY ejaModuleId ASC;",tibula['ejaLanguage'],tibula['ejaModuleId'])) do --must be ORDER ASC to overwrite general translation with module one.
   tibula['ejaTranslation'][v['word']]=v['translation'];
  end
 end
 
 if tibula['ejaTranslation'][value] then
  r=tibula['ejaTranslation'][value]; 
 else 
  r=value; 
 end
 
 return r;
end


function tibulaInfo(value) 	--append value to the info box for alert, info and error messages and return the new infos

 if ejaString(value) ~= "" then
  translation=tibulaTranslate(value)
  if translation  and translation ~= value then
   if not translation:match("^%s*$") then
    tibula.ejaInfo=ejaSprintf('%s%s\n',ejaString(tibula.ejaInfo),translation)
   end
  else
   ejaTrace('[tibula] missing translation: %s %s',tibula.ejaLanguage,value)
  end
 end
 
 return ejaString(tibula.ejaInfo)
end


function tibulaLinkHistory(module,value) 	--manage linking history
 if not tibula['ejaLinkHistory'] or ejaString(module) == "" then tibula['ejaLinkHistory']={}; end
 if not tibula['ejaLinkHistoryOrder'] or ejaString(module) == "" then tibula['ejaLinkHistoryOrder']={}; end

 if ejaCheck(value) then
  tibula['ejaLinkHistory'][module]=value;
  table.insert(tibula['ejaLinkHistoryOrder'],module);
 else
  local bool=0
  table.sort(tibula['ejaLinkHistoryOrder'])
  for k,v in pairs(tibula['ejaLinkHistoryOrder']) do
   if ejaString(module) == v or bool > 0 then 
    tibula['ejaLinkHistory'][v]=nil
    tibula['ejaLinkHistoryOrder'][k]=nil
    bool=1;
   end
  end
 end
 
 return 0; 
end


function tibulaDateSet(value,type)		--convert datetime to dd/mm/yyyy or viceversa
 value=string.gsub(value,"/","-");
 if not value then value="" end
 if not string.find(type,"time") then 
  value=string.sub(value,1,10);
 end
 
 return value;
end


function tibulaUCFirst(value)	--return first letter capitalized value

 if value then
  value=string.gsub(value,"%a", string.upper, 1);
 end

 return value
end


function tibulaModuleExport(name)   --export a tibula module with fields and commands
 local a={}
 local id=tibulaSqlRun("SELECT ejaId FROM ejaModules WHERE name='%s';",name)
 a.name=name
 a.module=tibulaSqlArray("SELECT a.searchLimit,a.sqlCreated,a.power,a.sortList,a.lua,(SELECT x.name FROM ejaModules AS x WHERE x.ejaId=a.parentId) AS parentName FROM ejaModules AS a WHERE ejaId=%s;",id)
 a.field=tibulaSqlMatrix("SELECT translate,matrixUpdate,powerEdit,name,type,powerList,powerSearch,value FROM ejaFields WHERE ejaModuleId=%s;",id)
 a.command={}
 for _,row in next,tibulaSqlMatrix([[SELECT name from ejaCommands WHERE ejaId IN (SELECT ejaCommandId FROM ejaPermissions WHERE ejaModuleId=%s);]],id) do
  a.command[#a.command+1]=row.name
 end
 return a
end


function tibulaModuleImport(a,tableName)	--import a tibula module with fields, commands and permission
 local tableName=tableName or a.name
 local owner=1;
 local id=tibulaSqlRun("SELECT ejaId FROM ejaModules WHERE name='%s';",tableName)
 local parentId=tibulaSqlRun("SELECT ejaId FROM ejaModules WHERE name='%s';",a.module.parentName) 
 if ejaNumber(parentId) < 1 then parentId=1 end
 if ejaNumber(a.module.sqlCreated) > 0 then 
  tibulaSqlTableCreate(tableName);
 end
 if ejaNumber(id) < 1 then
  tibulaSqlRun([[INSERT INTO ejaModules (ejaId,ejaOwner,ejaLog,name,power,searchLimit,lua,sqlCreated,sortList,parentId) VALUES (NULL,%s,'%s','%s','%s','%s','%s','%s','%s','%s');]],
   owner,tibulaSqlNow(),tableName,a.module.power,a.module.searchLimit,a.module.lua,a.module.sqlCreated,a.module.sortList,parentId);
  id=tibulaSqlLastId();
 end
 if ejaNumber(id) > 0 then
  tibulaSqlRun([[DELETE FROM ejaFields WHERE ejaModuleId=%s;]],id)
  for k,v in next,a.field do
   if ejaNumber(a.module.sqlCreated) > 0 then
    tibulaSqlTableColumnCreate(tableName, v.name, v.type)
   end
   tibulaSqlRun([[INSERT INTO ejaFields (ejaId,ejaOwner,ejaLog,ejaModuleId,name,type,value,translate,matrixUpdate,powerSearch,powerList,powerEdit) VALUES (NULL,%s,'%s',%s,'%s','%s','%s','%s','%s','%s','%s','%s');]],
    owner,tibulaSqlNow(),id,v.name,v.type,v.value,v.translate,v.matrixUpdate,v.powerSearch,v.powerList,v.powerEdit)
  end
  local src=ejaSqlRun([[SELECT ejaId FROM ejaModules WHERE name='ejaPermissions';]])
  local dst=ejaSqlRun([[SELECT ejaId FROM ejaModules WHERE name='ejaUsers';]])
  tibulaSqlRun([[DELETE FROM ejaLinks WHERE dstModuleId=%s AND srcModuleId=%s AND srcFieldId IN (SELECT c.ejaId FROM ejaPermissions AS c WHERE c.ejaModuleId=%s);]],dst,src,id)
  tibulaSqlRun([[DELETE FROM ejaPermissions WHERE ejaModuleId=%s;]],id)
  for k,v in next,a.command do
   tibulaSqlRun([[INSERT INTO ejaPermissions (ejaId,ejaOwner,ejaLog,ejaModuleId,ejaCommandId) VALUES (NULL,%s,'%s',%s,(SELECT x.ejaId FROM ejaCommands AS x WHERE x.name='%s' LIMIT 1));]],owner,tibulaSqlNow(),id,v)
   tibulaSqlRun([[INSERT INTO ejaLinks (ejaId,ejaOwner,ejaLog,srcModuleId,srcFieldId,dstModuleId,dstFieldId,power) VALUES (NULL,%s,'%s','%s','%s','%s','%s',1);]],
    owner,tibulaSqlNow(),src,tibulaSqlLastId(),dst,owner);     
  end
 end
end


