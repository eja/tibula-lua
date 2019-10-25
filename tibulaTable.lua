-- Copyright (C) 2007-2019 by Ubaldo Porcheddu <ubaldo@eja.it>
--
-- Polonaise héroïque


function tibulaTableStart()	--set default tibula table value
 tibula={};
 tibula.ejaDefaultLanguage="en";
 tibula.ejaDefaultSearchStep=15;
 tibula.ejaDefaultSearchOrder="ejaLog DESC";
 tibula.ejaCommandsArray={}
 tibula.ejaHttpHeaders={}
 tibula.ejaSqlType=tibulaSqlType;
 tibula.ejaLanguage=tibula.ejaLanguage or tibula.ejaDefaultLanguage;
 tibula.path=eja.opt.tibulaPath or eja.pathVar..'/tibula/'
end


function tibulaTableImport(a)	--import data into tibula table
 for key,value in next,a do
  if type(value) ~= "table" then 
   key=ejaUrlDecode(key) 
   value=ejaUrlDecode(value) 
  else
   key=ejaString(key)
   value=ejaString(value)
  end

  if key == "ejaId" then tibula.ejaId=value;  end
  if key == "ejaAction" then tibula.ejaAction=value; end
  if key == "ejaSession" then tibula.ejaSession=value; end
  if key == "ejaModuleId" then tibula.ejaModuleId=value; end
  if key == "ejaLanguage" then tibula.ejaLanguage=value; end
  if key == "ejaLinkPower" then tibula.ejaLinkPower=value; end
  if key == "ejaModuleName" then tibula.ejaModuleName=value; end
  if key == "ejaSearchStep" then tibula.ejaSearchStep=value; end
  if key == "ejaModuleLink" then tibula.ejaModuleLink=value; end
  if key == "ejaSearchLimit" then tibula.ejaSearchLimit=value; end
  if key == "ejaModuleChange" then tibula.ejaModuleChange=value; end
  if key == "ejaModuleLinkBack" then tibula.ejaModuleLinkBack=value; end
  if key == "ejaOut" then --xhtml/xml/json
   tibula.ejaOut=value; 
   if ejaString(value) == "json" then tibula.ejaOutSession=0; end
  end
  if key == "ejaOutSession"	then tibula.ejaOutSession=value; end

  check=key:match('^ejaAction%[(.-)%]$')
  if  check then tibula.ejaAction=check end 
  if key == "ejaAction" then tibula.ejaAction=value; end

  if key:match("^ejaId%[") then
   if not tibula.ejaIdArray then tibula.ejaIdArray={}; end
   if ejaNumber(tibula.ejaId) < 1 then tibula.ejaId=value; end
   table.insert(tibula.ejaIdArray,value)
  end 
  if key == "ejaId" and type(value) == 'table' then 
   tibula.ejaIdArray=value; 
   if ejaNumber(tibula.ejaId) < 1 then _,tibula.ejaId=next(value); end   
  end  

  k,v=key:match("^ejaLinkPower%[(.-)%]%[(.-)%]$")
  if k and v then
   if type(tibula.ejaLinkPower) ~= "table" then tibula.ejaLinkPower={} end
   tibula.ejaLinkPower[k]=v.."."..value
  end
  if key == "ejaLinkPower" and type(value) == 'table' then tibula.ejaLinkPower=value; end
  
  check=key:match('^ejaSearchOrder%[(.-)%]$')
  if check and ejaString(value) ~= "" then
   if type(tibula.ejaSearchOrder) ~= "table" then tibula.ejaSearchOrder={} end
   tibula.ejaSearchOrder[check]=value; 
  end 
  if key == "ejaSearchOrder" and type(value) == 'table' then tibula.ejaSearchOrder=value; end
  
  check=key:match('^ejaValues%[(.-)%]$')
  if check then 
   if type(tibula.ejaValues) ~= "table" then tibula.ejaValues={} end
   k,v=check:match('^(.-)%]%[(.-)$')
   if k and v then 
    tibula.ejaValues[k]=v.."."..value
   else 
    k,v=check:match('^(.-)%.(.-)$')
    if k and v then
     tibula.ejaValues[check]=value;
     if ejaString(value) ~= "" then tibula.ejaValues[k]=value; end
    else
     tibula.ejaValues[check]=value
    end
   end
  end
  if key == "ejaValues" and type(value) == 'table' then tibula.ejaValues=value; end
  
  if ejaNumber(tibula.ejaId) == 0 and tibula.ejaValues and tibula.ejaValues.ejaId then
   tibula.ejaId=tibula.ejaValues.ejaId
  end

 end 
end


function tibulaTableRun(web)	--main tibula engine 
 if ejaString(tibula.ejaModuleName) ~= "" then tibula.ejaModuleId=tibulaSqlRun("SELECT ejaId FROM ejaModules WHERE name='%s';",tibula.ejaModuleName) end
 if ejaNumber(tibula.ejaModuleId) < 1 then tibula.ejaModuleId=tibulaSqlRun("SELECT ejaId FROM ejaModules WHERE name='eja';") end
 if ejaNumber(tibula.ejaModuleId) < 1 then tibula.ejaModuleId=1 end
 tibula.ejaModuleId=ejaNumber(tibula.ejaModuleId);
 tibula.ejaId=ejaNumber(tibula.ejaId)
 tibula.ejaValues=ejaTable(tibula.ejaValues)
 if not tibula.ejaIdArray and tibula.ejaId > 0 then 
  tibula.ejaIdArray=ejaTable(); 
  table.insert(tibula.ejaIdArray,tibula.ejaId) 
 end
 if not tibula.ejaOut then tibula.ejaOut="xhtml"; end
 if not tibula.ejaOutSession then tibula.ejaOutSession=1; end

 --login, set a random session value and retrieve defaultModuleId 
 if ejaString(tibula.ejaAction) == "login" and ejaString(tibula.ejaValues.username) ~= "" and ejaString(tibula.ejaValues.password) ~= "" then 
  tibula.ejaOwner=tibulaSqlRun("SELECT ejaId FROM ejaUsers WHERE username='%s' AND CASE WHEN LENGTH(password) = 64 THEN password='%s' ELSE password='%s' END;",tibula.ejaValues.username,ejaSha256(tibula.ejaValues.password),tibula.ejaValues.password);
  if ejaNumber(tibula.ejaOwner) > 0 then
   tibulaSqlRun('DELETE FROM ejaSessions WHERE ejaOwner=%d;',tibula.ejaOwner);
   tibulaSqlRun("UPDATE ejaUsers SET ejaSession='%s' WHERE ejaId='%d';",tibulaSessionCode(),tibula.ejaOwner); 
   local row=tibulaSqlArray('SELECT * FROM ejaUsers WHERE ejaId=%d;',tibula.ejaOwner);
   tibula.ejaSession=ejaString(row.ejaSession);
   tibula.ejaModuleId=ejaNumber(row.defaultModuleId);
  end
 end  

 --Session managment
 if ejaString(tibula.ejaSession) ~= "" then
  --set ejaOwner
  local user=tibulaSqlArray("SELECT * FROM ejaUsers WHERE ejaSession='%s';",tibula.ejaSession);
  if ejaTableCount(user) > 0 then
   tibula.ejaOwner=ejaNumber(user.ejaId);
   --set ejaLanguage
   if user.ejaLanguage then tibula.ejaLanguage=ejaString(user.ejaLanguage); end
   --fill tibula from ejaSessions
   if ejaNumber(tibula.ejaOwner) > 0 and ejaNumber(tibula.ejaOutSession) == 1 and ejaString(tibula.ejaAction) ~= "csvExport" and ejaString(tibula.ejaAction) ~= "xmlExport" then 
    tibulaSessionRead(tibula.ejaOwner); 
   end 
  --fill eja with the list and the array of other owners data enabled views
   tibula.ejaOwnerList=tibulaSqlOwnerList(tibula.ejaOwner); 
   tibula.ejaOwners=ejaTable(tibula.ejaOwners)
   for v in string.gmatch(tibula.ejaOwnerList,"%d+") do tibula.ejaOwners[v]=v; end 
  else 
   tibula.ejaOwner=0;
  end
 else 
  tibula.ejaOwner=0;
 end 
 
 --Security checks
 if ejaString(tibula.ejaAction) =="logout" then
  --logout 
  if ejaNumber(tibula.ejaOwner) > 0 then tibulaSqlRun("UPDATE ejaUsers SET ejaSession='' WHERE ejaId=%d;",tibula.ejaOwner); end
  tibula.ejaSession="";
  tibula.ejaOwner=0;   
  tibulaReset();
  tibula.ejaLinkHistory={};
  tibula.ejaLinkModuleId=0;
  tibula.ejaLinkFieldId=0; 
 end
 
 -- ejaSession semaphore
 if ejaNumber(tibula.ejaOwner) < 1 then 
  tibula.ejaModuleId=tibulaSqlRun("SELECT ejaId FROM ejaModules WHERE name='ejaLogin'");
  tibula.ejaModuleName="ejaLogin";
  tibula.ejaLanguage=tibula.ejaDefaultLanguage;
  tibula.ejaSession="";
  tibulaInfo("ejaNotAuthorized");
  
 else 	-- authorized
 
  --Module selection 
  if ejaString(tibula.ejaAction) == "query" then tibula.ejaModuleChange=tibula.ejaModuleId; end
  if ejaNumber(tibula.ejaModuleChange) > 0 then      --if changing module reset sql order,limit,query..
   if tibula.ejaLinkHistory and tibula.ejaModuleChange == 35248 then tibulaLinkHistory(0,0) end --force ejaLinkHistory reset if on root module
   tibula.ejaModuleId=tibula.ejaModuleChange;
   tibulaReset();   
  end

  --Linking managment
  if ejaString(tibula.ejaModuleLink) ~= "" and ejaNumber(tibula.ejaModuleChange) > 0 then	--link begin
   tibula.ejaModuleId=tibula.ejaModuleChange;
   tibulaLinkHistory(tibula.ejaModuleLink:match('([%d]*)%.([%d]*)'));	--add to ejaLinkHistory
   tibula.ejaAction="searchLink";
   table.insert(tibula.ejaCommandsArray,"searchLink");
  end
  --linking back
  if ejaNumber(tibula.ejaModuleLinkBack) > 0 and ejaTableCount(tibula.ejaLinkHistory) > 0 then	--link back
   tibulaReset();
   tibula.ejaId=ejaNumber(tibula.ejaLinkHistory[tibula.ejaModuleLinkBack]);
   tibula.ejaModuleId=tibula.ejaModuleLinkBack;
   tibula.ejaAction="edit";
   tibulaLinkHistory(tibula.ejaModuleId,0);	--reset this ejaLinkHistory
  end
  --linking history
  if ejaTableCount(tibula.ejaLinkHistoryOrder) > 0 then	--if linking check link type 
   table.sort(tibula.ejaLinkHistoryOrder);
   for k,v in next,tibula.ejaLinkHistoryOrder do
    if ejaNumber(v) > 0 then
     tibula.ejaLinkModuleId=v
     tibula.ejaLinkFieldId=tibula.ejaLinkHistory[v]
    end
   end
   if ejaNumber(tibula.ejaId) < 1 then tibula.ejaLinking=1; end
   if ejaNumber(tibula.ejaLinkModuleId) > 0 then tibula.ejaLinkingField=ejaString(tibulaSqlRun('SELECT srcFieldName FROM ejaModuleLinks WHERE dstModuleId=%d AND srcModuleId=%d',tibula.ejaLinkModuleId,tibula.ejaModuleId)); end
  end   

  --Fill or update ejaModuleName
  if ejaNumber(tibula.ejaModuleId) > 0 then tibula.ejaModuleName=tibulaSqlRun('SELECT name FROM ejaModules WHERE ejaId=%d;',tibula.ejaModuleId) or 'eja'; end
   
  --Fill ejaCommands
  tibula.ejaCommands={}
  for k,v in next,tibulaSqlCommandArray(tibula.ejaOwner,tibula.ejaModuleId,"") do 
   tibula.ejaCommands[v]=k; 
  end

  --run lua script for this ejaModuleId and save tibula into ejaSessions
  tibulaModuleLua(0,web);
  tibulaSessionWrite(tibula.ejaOwner,tibula);

  --Actions engine, runs only if ejaAction is in ejaSqlCommandList
  if ejaString(tibula.ejaAction) ~= "" and ejaString(tibula.ejaCommands[tibula.ejaAction]) ~= "" then

   --update matrix
   if ejaString(tibula.ejaAction) == "update" then
    tibula.ejaMatrix=1;
    tibula.ejaAction="search"; 
    if ejaNumber(tibula.ejaId) > 0 then 
     local validFields={}
     for k,v in next,tibulaSqlFieldsMatrix(tibula.ejaModuleId, "Matrix") do
      if v.name and ejaString(v.type) == "matrix" then 
       for kk,vv in next,tibula.ejaIdArray do
        if tibula.ejaValues[v.name.."."..vv] then
         tibulaSqlRun("UPDATE %s SET %s='%s' WHERE ejaId=%d AND ejaOwner IN (%s)",tibula.ejaModuleName,v.name,tibula.ejaValues[v.name.."."..vv],vv,tibula.ejaOwnerList)
        end
       end
      end
     end
    end 
   end
 
   --link and unlink
   if (ejaString(tibula.ejaAction) == "link" or ejaString(tibula.ejaAction) == "unlink") and ejaTableCount(tibula.ejaIdArray) > 0 then
    for k,v in next,tibula.ejaIdArray do
     local linkPower=0;
     local linkId=0;
     if ejaString(v) ~= "" and tibula.ejaLinkPower[v] then
      linkId,linkPower=tibula.ejaLinkPower[v]:match('(%d+)%.(%d+)')
      if ejaString(tibula.ejaAction) == "link" then 
       if ejaNumber(linkPower) < 1 then linkPower=1 end
       if ejaNumber(linkId) > 0 then
        tibulaSqlRun('UPDATE ejaLinks SET power=%d WHERE ejaId=%d AND ejaOwner IN (%s);',linkPower,linkId,tibula.ejaOwnerList); 
       else 
        tibulaSqlRun("INSERT INTO ejaLinks (ejaOwner,ejaLog,srcModuleId,srcFieldId,dstModuleId,dstFieldId,power) VALUES (%d,'%s',%d,%d,%d,%d,%d);",tibula.ejaOwner,tibulaSqlNow(),tibula.ejaModuleId,v,tibula.ejaLinkModuleId,tibula.ejaLinkFieldId,linkPower);     
       end
      end
     if ejaString(tibula.ejaAction) == "unlink" then tibulaSqlRun('DELETE FROM ejaLinks WHERE ejaId=%d AND ejaOwner IN (%s);',linkId,tibula.ejaOwnerList); end
     end
    end 
    tibula.ejaAction="searchLink";  
    tibula.ejaLinking=2; 
   end 

   --edit and view
   if ejaNumber(tibula.ejaId) > 0 and (ejaString(tibula.ejaAction) == "edit") or ejaString(tibula.ejaAction) == "view" then 
    tibula.ejaValues=tibulaSqlArray('SELECT * FROM %s WHERE ejaId=%d;',tibula.ejaModuleName,tibula.ejaId);
   end
  
   --new and copy
   if ejaString(tibula.ejaAction) == "new" or ejaString(tibula.ejaAction) == "copy" then
    tibula.ejaValues.ejaLog=tibulaSqlNow();
    tibula.ejaValues.ejaOwner=ejaNumber(tibula.ejaOwner);
    tibulaSqlRun("INSERT INTO %s (ejaId,ejaOwner,ejaLog) VALUES (NULL,'%d','%s');",tibula.ejaModuleName,tibula.ejaValues.ejaOwner,tibula.ejaValues.ejaLog);
    tibula.ejaIdCopied=tibula.ejaId;
    tibula.ejaId=tibulaSqlLastId();
    if ejaString(tibula.ejaAction) == "copy" then --copy ejaLinks and ejaFiles
     tibulaSqlRun("INSERT INTO ejaLinks (ejaId,ejaOwner,ejaLog,srcModuleId,srcFieldId,dstModuleId,dstFieldId,power) SELECT NULL,%d,'%s',srcModuleId,srcFieldId,dstModuleId,%d,power FROM ejaLinks WHERE dstModuleId=%d AND dstFieldId=%d;",tibula.ejaOwner,tibulaSqlNow(),tibula.ejaId,tibula.ejaModuleId,tibula.ejaIdCopied);
     tibula.ejaLinkFieldId=tibula.ejaId;
    end 
   end

   --save and copy (must be after "new" for "copy" to work). update data also if ejaAction=new and we are in batch mode (xml) 
   if ejaTableCount(tibula.ejaValues) > 0 and ( 
    (ejaString(tibula.ejaAction) == "save" or ejaString(tibula.ejaAction) == "copy") or 
    (ejaNumber(tibula.ejaOutSession) == 0 and ejaString(tibula.ejaAction) == "new") or 
    (ejaString(tibula.ejaAction) == "searchLink" and ejaNumber(tibula.ejaId) > 0) 
   ) then
    if ejaString(tibula.ejaModuleName) == "ejaModules" and (tibula.ejaAction == "save" or (ejaNumber(tibula.ejaOutSession) == 0 and tibula.ejaAction =="new")) then	-- create table on database and add permissions
     if ejaNumber(tibula.ejaValues.sqlCreated) > 0 then
      local tableCreate=tibulaSqlTableCreate(tibula.ejaValues.name);  
      if ejaNumber(tableCreate) > 0 then tibulaInfo("ejaSqlModuleCreated"); end
      if ejaNumber(tableCreate) < 0 then tibulaInfo("ejaSqlModuleNotCreated"); end
     end
     if ejaNumber(tibulaSqlRun('SELECT COUNT(*) FROM ejaPermissions WHERE ejaModuleId=%d;',tibula.ejaId)) == 0 then
      if ejaNumber(tibula.ejaValues.sqlCreated) > 0 then
       tibulaInfo("ejaModuleSqlPermissionsCreated");
       tibulaSqlRun("INSERT INTO ejaPermissions SELECT NULL,%d,'%s',%d,ejaId FROM ejaCommands WHERE defaultCommand>0",tibula['ejaOwner'],tibulaSqlNow(),tibula['ejaId']);
      else
       tibulaInfo("ejaModuleContainerPermissionsCreated");
       tibulaSqlRun("INSERT INTO ejaPermissions SELECT NULL,%d,'%s',%d,ejaId FROM ejaCommands WHERE name='logout'",tibula['ejaOwner'],tibulaSqlNow(),tibula['ejaId']);
      end
       tibulaSqlRun("INSERT INTO ejaLinks (ejaId,ejaOwner,ejaLog,srcModuleId,srcFieldId,dstModuleId,dstFieldId,power) SELECT NULL,1,'%s',(SELECT ejaId FROM ejaModules WHERE name='ejaPermissions'),ejaId,(SELECT ejaId FROM ejaModules WHERE name='ejaUsers'),%d,2 from ejaPermissions where ejaModuleId=%d;",tibulaSqlNow(),tibula.ejaOwner,tibula.ejaId);      
     end
    end
    if ejaNumber(tibula.ejaId) < 1 then 
     tibulaSqlRun("INSERT INTO %s (ejaId,ejaOwner,ejaLog) VALUES (NULL,'%d','%s');",tibula.ejaModuleName,tibula.ejaOwner,tibulaSqlNow());
     tibula.ejaId=tibulaSqlLastId();
    else    
     if not tibulaSqlRun("SELECT ejaId FROM %s WHERE ejaId=%d;",tibula.ejaModuleName,tibula.ejaId) then
      tibulaSqlRun("INSERT INTO %s (ejaId,ejaOwner,ejaLog) VALUES (%d,%d,'%s');",tibula.ejaModuleName,tibula.ejaId,tibula.ejaOwner,tibulaSqlNow());
     end 
    end
    for k,v in next,tibula.ejaValues do
     local t=tibulaSqlRun("SELECT type FROM ejaFields WHERE ejaModuleId=%d AND name='%s';",tibula.ejaModuleId,k);
     if t then 
      if string.find("#date#dateRange#time#timeRange#datetime#datetimeRange#",t) then v=tibulaDateSet(v,t); end
      if t == "password" and string.len(v) ~= 64 then v=ejaSha256(v) end
     end
     tibulaSqlRun("UPDATE %s SET %s='%s' WHERE ejaId=%d AND ejaOwner IN (%s);",tibula.ejaModuleName,k,tibulaSqlEscape(v),tibula.ejaId,tibula.ejaOwnerList);
    end
    tibula.ejaValues=tibulaSqlArray('SELECT * FROM %s WHERE ejaId=%d;',tibula.ejaModuleName,tibula.ejaId);
    
    --create table column
    if ejaString(tibula.ejaModuleName) == "ejaFields" and ejaString(tibula.ejaValues.name) ~= "" and ejaString(tibula.ejaValues.type) ~= "" and ejaNumber(tibula.ejaValues.ejaModuleId) > 0 then
     local fieldCreate=tibulaSqlTableColumnCreate(tibulaSqlRun('SELECT name FROM ejaModules WHERE ejaId=%d;',tibula.ejaValues.ejaModuleId), tibula.ejaValues.name, tibula.ejaValues.type)
     if ejaNumber(fieldCreate) > 0 then tibulaInfo("ejaSqlFieldCreated"); end
     if ejaNumber(fieldCreate) < 0 then tibulaInfo("ejaSqlFieldNotCreated"); end
    end
    
   end

   --delete
   if ejaString(tibula.ejaAction) == "delete" and ejaTableCount(tibula.ejaIdArray) > 0 then
    for k,v in next,tibula.ejaIdArray do 
     if ejaString(tibula.ejaModuleName) == "ejaModules" then	
      local tableName=tibulaSqlRun('SELECT name FROM ejaModules WHERE ejaId=%d AND ejaOwner IN (%s);',v,tibula.ejaOwnerList);
      if ejaString(tableName) ~= "" then
       tibulaSqlRun('DROP TABLE %s;',tableName);
       tibulaSqlRun('DELETE FROM ejaFields WHERE ejaModuleId=%d;',v);
       tibulaSqlRun('DELETE FROM ejaPermissions WHERE ejaModuleId=%d;',v);
       tibulaSqlRun('DELETE FROM ejaHelps WHERE ejaModuleId=%d;',v);
       tibulaSqlRun('DELETE FROM ejaTranslations WHERE ejaModuleId=%d;',v);
       tibulaSqlRun('DELETE FROM ejaModuleLinks WHERE dstModuleId=%d;',v);
       tibulaInfo("ejaSqlModuleDeleted");
      end
     end
     tibulaSqlRun('DELETE FROM %s WHERE ejaId=%d AND ejaOwner IN (%s);',tibula.ejaModuleName,v,tibula.ejaOwnerList); 
     tibulaSqlRun('DELETE FROM ejaLinks WHERE (dstModuleId=%d AND dstFieldId=%d) OR (srcModuleId=%d AND srcFieldId=%d) AND ejaOwner IN (%s);',tibula.ejaModuleId,v,tibula.ejaModuleId,v,tibula.ejaOwnerList);
    end
    tibula.ejaAction="search";
   end 

   --search engine
   if ejaString(tibula.ejaAction) == "searchLink" then tibulaReset(); end
   if string.find("#search#previous#next#list#searchLink#csvExport#xmlExport#",ejaString(tibula.ejaAction)) then
    local sql="";
    local sqlType={};
    tibula.ejaActionType="List";
    --check ejaSearchStep (how many rows per page) and ejaSearchLimit (row limit begin)
    if ejaNumber(tibula.ejaSearchStep) < 1 then tibula.ejaSearchStep=tibulaSqlRun('SELECT searchLimit FROM ejaModules WHERE ejaId=%d;',tibula.ejaModuleId); end
    if ejaNumber(tibula.ejaSearchStep) < 1 then tibula.ejaSearchStep=tibula.ejaDefaultSearchStep; end
    if ejaNumber(tibula.ejaSearchLimit) > 0 then tibula.ejaSqlLimit=tibula.ejaSearchLimit; end
    if ejaNumber(tibula.ejaSqlLimit) < 1 then tibula.ejaSqlLimit=0 end
    --previous and next
    if ejaString(tibula.ejaAction) == "previous" then tibula.ejaSqlLimit=tibula.ejaSqlLimit-tibula.ejaSearchStep; end
    if ejaString(tibula.ejaAction) == "next" then tibula.ejaSqlLimit=tibula.ejaSqlLimit+tibula.ejaSearchStep; end
    --query construction
    if ejaString(tibula.ejaSqlQuery64) ~= "" then 
     sql=ejaBase64Decode(tibula.ejaSqlQuery64);
    else
     sql='SELECT ejaId';
     for k,v in next,tibulaSqlMatrix("SELECT name,type FROM ejaFields WHERE ejaModuleId=%d AND powerList>0 AND powerList !='' ORDER BY powerList;",tibula.ejaModuleId) do
      sql=sql..','..v.name;
     end
     for k,v in next,tibulaSqlMatrix('SELECT name,type FROM ejaFields WHERE ejaModuleId=%d;',tibula.ejaModuleId) do   
      sqlType[v.name]=v.type;
     end
     sql=sql..ejaSprintf(' FROM %s WHERE ejaOwner IN (%s)',tibula.ejaModuleName,tibula.ejaOwnerList);
     if ejaTableCount(tibula.ejaValues) > 0 then
      for k,v in next,tibula.ejaValues do
       local sqlTypeThis=ejaString(sqlType[k])
       if ejaString(v) ~= "" and not string.find(k,"%.") then 
        local sqlAnd="";
        v=string.gsub(v,"*","%%");
        v=string.gsub(v,"%%","%%%%%%%%");
        if sqlTypeThis == "boolean" or sqlTypeThis == "integer" then 
         sqlAnd=ejaSprintf(' AND %s = %d ',k,v); 
        end
        if sqlTypeThis == "date" or sqlTypeThis == "time" or sqlTypeThis == "datetime" then 
         sqlAnd=ejaSprintf(" AND %s='%s' ",k,tibulaDateSet(v,sqlTypeThis)); 
        end
        if sqlTypeThis == "dateRange" or sqlTypeThis == "timeRange" or sqlTypeThis == "datetimeRange" or sqlTypeThis == "integerRange" then
         if ejaString(tibula.ejaValues[k..".begin"]) ~= "" then sqlAnd=sqlAnd..ejaSprintf(" AND %s > '%s' ",k,tibulaDateSet(tibula.ejaValues[k..".begin"],"")); end
         if ejaString(tibula.ejaValues[k..".end"]) ~= "" then sqlAnd=sqlAnd..ejaSprintf(" AND %s < '%s' ",k,tibulaDateSet(tibula.ejaValues[k..".end"],"")); end
        end
        if ejaString(sqlAnd) == "" then sqlAnd=" AND "..k.." LIKE '"..v.."'"; end
        sql=sql..sqlAnd;
       end
      end
     end  
     --if linking restrict search to active links. If srcFieldName is present in ejaModuleLinks use this to restrict search.
     if ejaString(tibula.ejaAction) == "searchLink" then
      if ejaString(tibula.ejaLinkingField) ~= "" then
       sql=sql..ejaSprintf(" AND ejaId IN (SELECT ejaId FROM %s WHERE %s=%d AND ejaOwner IN (%s)) ",tibula.ejaModuleName,tibula.ejaLinkingField,tibula.ejaLinkFieldId,tibula.ejaOwnerList);
      else
       sql=sql..ejaSprintf(" AND ejaId IN (SELECT srcFieldId FROM ejaLinks WHERE srcModuleId=%d AND dstModuleId=%d AND dstFieldId=%d) ",tibula.ejaModuleId,tibula.ejaLinkModuleId,tibula.ejaLinkFieldId); 
      end
     end
     tibula.ejaSqlQuery64=ejaBase64Encode(sql);
    end
    --limit and order stuff
    if ejaString(tibula.ejaSqlLimit) == "" then tibula['ejaSqlLimit']=0; end
    if ejaTableCount(tibula.ejaSearchOrder) > 0 then
     tibula['ejaSqlOrder']="";
     for k,v in next,tibula.ejaSearchOrder do 
      if v then tibula.ejaSqlOrder=tibula.ejaSqlOrder..", "..k.." "..v; end
     end
     if ejaString(tibula.ejaSqlOrder) ~= "" then tibula.ejaSqlOrder=string.sub(tibula.ejaSqlOrder,2); end
    end 
    if ejaString(tibula.ejaSqlOrder) == "" then 
     tibula.ejaSqlOrder=tibulaSqlRun('SELECT sortList FROM ejaModules WHERE ejaId=%d',tibula.ejaModuleId);
     if ejaString(tibula.ejaSqlOrder) == "" then tibula.ejaSqlOrder=tibula.ejaDefaultSearchOrder; end
    end
    --finish query construction
    tibula.ejaSqlQueryRaw=sql;
    tibula.ejaSqlQuery=ejaSprintf('%s ORDER BY %s LIMIT %d,%d;',sql,tibula.ejaSqlOrder,tibula.ejaSqlLimit,tibula.ejaSearchStep);
    tibula.ejaId=0;
   end

  end 
 end 


 --Define ejaActionType and populate fields/result matrix
 if ejaString(tibula.ejaActionType) == "List" then 
print(tibula.ejaSqlQuery)
  tibula.ejaSearchList=tibulaSqlSearchMatrix(tibula.ejaSqlQuery,tibula.ejaModuleId); 
 else
   if ejaNumber(tibula.ejaId) > 0 then 
    tibula.ejaActionType="Edit" 
   else 
    tibula.ejaActionType="Search" 
   end
  tibula.ejaFields=tibulaSqlFieldsMatrix(tibula.ejaModuleId, tibula.ejaActionType);
end
  
 -- lua module script last call.
 tibulaModuleLua(1,web);
end


function tibulaTableExport()
 local data=""
  
 if ejaString(tibula.ejaOut) == "json" then 
  data=tibulaJsonExport(tibula['ejaModuleId']); 
 else --xhtml
  data=tibulaXhtmlExport(tibula['ejaModuleId']);
 end

 return data;
end 


function tibulaTableStop()
 if ejaNumber(tibula.ejaOutSession) < 1 then
  tibulaSessionWrite(tibula.ejaOwner,{});
 else
  --Update ejaSession
  local ejaBkp={}
  ejaBkp.ejaSqlQuery64=tibula.ejaSqlQuery64;
  ejaBkp.ejaLinkHistory=tibula.ejaLinkHistory;
  ejaBkp.ejaLinkHistoryOrder=tibula.ejaLinkHistoryOrder;
  ejaBkp.ejaSqlLimit=tibula.ejaSqlLimit;
  ejaBkp.ejaSqlOrder=tibula.ejaSqlOrder; 
  tibulaSessionWrite(tibula.ejaOwner,ejaBkp);
  ejaBkp="";
 end
 tibula={}
end


