-- Copyright (C) 2007-2015 by Ubaldo Porcheddu <ubaldo@eja.it>
--
-- Prelude Op. 23 No. 5


function tibulaSqlStart(sqlType,sqlUsername,sqlPassword,sqlHostname,sqlDatabase) 
 if ejaSqlStart(sqlType,sqlUsername,sqlPassword,sqlHostname,sqlDatabase) then
  if sqlType=="mysql" then
   ejaSqlRun("CREATE TEMPORARY TABLE `ejaSessions` (`ejaId` integer NOT NULL AUTO_INCREMENT primary key, `ejaOwner` integer default 0, `ejaLog` datetime default NULL, `name` varchar(255) default NULL, `value` varchar(8192), `sub` varchar(255) default NULL) ENGINE=MEMORY;");   
  elseif sqlType=="sqlite3" then
  end
  return true
 else 
  return nil
 end
end


function ejaSqlQuery(query,...)	--filter sql query 
 query=sf(query,...); 
 
 if ejaCheck(tibula['ejaOwner']) and ejaCheck(tibula['ejaModuleId']) and not ejaCheck(tibula['ejaModuleName'],"ejaFields") and not ejaCheck(tibula['ejaModuleName'],"ejaSql") and not ejaCheck(tibula['ejaModuleName'],"ejaBackups") then
  query=string.gsub(query,"@ejaOwner",tibula['ejaOwner']);
 end
 
 return query;
end


function tibulaSqlOwnerList(ownerId)	--return the allowed id list of owners for active module and ownerId
 local moduleId;
 if ejaCheck(tibula['ejaModuleId']) then moduleId=tibula['ejaModuleId']; else moduleId=tibula['ejaModuleLink']; end

 local groupOwners=ejaSqlIncludeList("SELECT dstFieldId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaGroups') AND srcFieldId IN (SELECT srcFieldId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaGroups') AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaUsers') AND dstFieldId=%d AND srcFieldId IN ( SELECT dstFieldId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaModules') AND srcFieldId=%d AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaGroups') )) AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaUsers');",ownerId,moduleId);

 local ownerTree="";
 local sub=ownerId;
 local deep=10;
 local value="0";
 while n(deep) > 0 do
  deep=deep-1;
  value=ejaSqlIncludeList('SELECT ejaId FROM ejaUsers WHERE ejaOwner IN (%s) AND ejaId NOT IN (%s);',sub,sub);
  if ejaCheck(value) then 
   sub=value; 
   ownerTree=ownerTree..","..sub;   
  else 
   deep=0;
  end
 end
 local a={}
 for v in string.gmatch(ownerId..","..groupOwners..","..ownerTree,"%d+") do 
  if v and not a[v] then 
   a[v]=v; 
   value=v..","..value 
  end
 end
 
 return string.sub(value,1,-2);
end


function tibulaSqlCommandArray(userId, moduleId, actionType)	--return the power ordered list of commands allowed for $actionType, $moduleId and $userId
 local r={}
 local extra=""; 
 local order=""; 
 local linking="";
 
 if ejaCheck(tibula['ejaModuleName'],"ejaLogin") then table.insert(r,"login"); end
 if ejaCheck(tibula['ejaModuleId'],35248) then table.insert(r,"logout"); end
 if ejaCheck(tibula['ejaCommandsArray']) then
  for k,v in pairs(tibula['ejaCommandsArray']) do
   extra=extra.." OR name='"..v.."' ";
   if ejaCheck(v,"searchLink") then table.insert(r,"searchLink"); end
  end
 end 
 if ejaCheck(actionType) then order=" ORDER BY power"..actionType.. " ASC";  end
 if ejaCheck(tibula['ejaLinking']) then linking=" AND linking > 0 ";  end
 for k,v in pairs(ejaSqlMatrix("SELECT * FROM ejaCommands WHERE (ejaId IN (SELECT ejaCommandId FROM ejaPermissions WHERE ejaModuleId=%d AND ejaId IN (SELECT srcFieldId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId From ejaModules WHERE name='ejaPermissions') AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaUsers') AND dstFieldId=%d)) %s ) %s %s;",moduleId,userId,extra,linking,order)) do
  local commandName=v['name'];
  if ejaCheck(tibula['ejaAction'],"view") and ejaCheck(commandName,"save") then commandName=""; end
  if ejaCheck(commandName) then
   if ejaCheck(actionType) then
    if ejaCheck(v['power'..actionType]) then table.insert(r,commandName); end
   else 
    table.insert(r,commandName);
   end
  end
 end
 
 return r;
end


function tibulaSqlModuleTree(ownerId,moduleId)	--return path, tree and links array
 local row;
 local a={}
 local id=moduleId;
 a['pathId']={}
 a['pathName']={}
 a['treeId']={}
 a['treeName']={} 
 a['linkId']={}
 a['linkName']={}
 a['historyId']={}
 a['historyName']={}

 --path
 while id do
  row=ejaSqlArray("SELECT ejaId,parentId,name FROM ejaModules WHERE ejaId=%d;",id);
  id=nil;
  if ejaCheck(row) and ejaSqlRun("SELECT ejaId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaPermissions') AND srcFieldId IN (SELECT ejaId FROM ejaPermissions WHERE ejaModuleId=%d) AND dstFieldId=%d AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaUsers') LIMIT 1;",row['ejaId'],ownerId) then
   table.insert(a['pathId'],row['ejaId'])
   table.insert(a['pathName'],row['name'])
   if ejaCheck(row['parentId']) then
    id = row['parentId']
   end
  end
 end
 --tree 
 row=ejaSqlMatrix("SELECT ejaId,name FROM ejaModules WHERE parentId=%d ORDER BY power ASC;",moduleId);
 if not ejaCheck(row) then
  if not ejaCheck(a['pathId']) then
   row=ejaSqlMatrix("SELECT ejaId,name FROM ejaModules WHERE parentId=0 OR parentId='' AND ejaId != %d ORDER BY power ASC;",moduleId);
  end
 end
 if ejaCheck(row) then
  for k,v in pairs(row) do
   if ejaCheck(row) and ejaSqlRun("SELECT ejaId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaPermissions') AND srcFieldId IN (SELECT ejaId FROM ejaPermissions WHERE ejaModuleId=%d) AND dstFieldId=%d AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaUsers') LIMIT 1;",v['ejaId'],ownerId) then
    if not ("#ejaFiles#ejaSql#ejaBackups#"):find(v['name']) then
     table.insert(a['treeId'],v['ejaId']);
     table.insert(a['treeName'],v['name']);
    end
   end
  end
 end
 --links
 if ejaCheck(tibula['ejaId']) then
  for k,v in pairs(ejaSqlMatrix('SELECT srcModuleId,(SELECT name FROM ejaModules WHERE ejaId=srcModuleId) AS srcModuleName FROM ejaModuleLinks WHERE dstModuleId=%d ORDER BY power ASC;',moduleId)) do 
   if not ejaCheck(tibula['ejaLinkHistory']) or not ejaCheck(tibula['ejaLinkHistory'][v['srcModuleId']]) and ejaSqlRun("SELECT ejaId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaPermissions') AND srcFieldId IN (SELECT ejaId FROM ejaPermissions WHERE ejaModuleId=%d) AND dstFieldId=%d AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaUsers') LIMIT 1;",v['srcModuleId'],ownerId) then
    if v['srcModuleName'] ~= "ejaFiles" then
     table.insert(a['linkId'],v['srcModuleId']);
     table.insert(a['linkName'],v['srcModuleName']);
    end
   end
  end
 end
 
 if ejaCheck(tibula['ejaLinkHistory']) then
  for k,v in pairs (tibula['ejaLinkHistory']) do
   if not ejaCheck(k,moduleId) and ejaCheck(v) then	
    table.insert(a['historyId'],k);
    table.insert(a['historyName'],tibulaTranslate(ejaSqlRun('SELECT name FROM ejaModules WHERE ejaId=%d;',k)));
   end 
  end 
 end
 
 return a;
end


function tibulaSqlFieldsMatrix(moduleId, actionType) 	--return an array with rowName,rowType,rowValue, rowArray of moduleName for actionType
 local a={};
 local t="";
 local matrix=0;
 
 if ejaCheck(actionType,"Matrix") then actionType="List"; matrix=1; end 
 
 for k,v in pairs (ejaSqlMatrix("SELECT * FROM ejaFields WHERE ejaModuleId=%d AND power%s>0 AND power%s!='' ORDER BY power%s ASC",moduleId,actionType,actionType,actionType)) do 
  if ejaCheck(tibula['ejaAction'],"view") then t="view"; else t=v['type']; end
  if ejaCheck(matrix,1) and ejaCheck(v['matrixUpdate']) then 
   t="matrix" 
  end
  if ejaCheck(v['ejaGroup']) and ejaCheck(tibula['ejaActionType'],"Edit") then
   if not ejaSqlRun("SELECT ejaId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaGroups') AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaUsers') AND dstFieldId=%d AND srcFieldId=%d LIMIT 1;",tibula['ejaOwner'],v['ejaGroup']) then
    t="view";
   end 
  end
  local rowName=v['name'];
  local rowType=t;
  local rowValue=""
  local rowArray={}
  if ejaCheck(tibula['ejaValues'][rowName]) then rowValue=tibula['ejaValues'][rowName]; end
  if ejaCheck(v['type'],"select") then rowArray=tibulaSelectToArray(v['value']); end
  if ejaCheck(v['type'],"sqlMatrix") then rowArray=tibulaSelectSqlToArray(v['value']); end
  if ejaCheck(v['type'],"sqlValue") or ejaCheck(v['type'],"sqlHidden") then rowValue=ejaSqlRun(v['value']); end
  if ejaCheck(v['type'],"sqlTable") then rowArray=ejaSqlMatrix(v['value']); end
  if ejaCheck(rowType,"view") then 
   if ejaCheck(rowArray) then rowValue=rowArray[ tibula['ejaValues'][rowName] ]; end
   if ejaCheck(v['type'],"password") then rowValue="********"; end
  end
  if ejaCheck(v['translate']) then rowValue=tibulaTranslate(rowValue); end
  table.insert(a, { name=rowName; type=rowType; value=rowValue; values=rowArray }); 
 end

 return a;
end


function tibulaSqlSearchMatrix(query,moduleId) 	--return an associative array for the sql query on module or 0, and set total retrieved rows on tibula['ejaSqlCount'] and total (no limit) rows on tibula['ejaSqlCountTotal']
 local y=0;
 local a={};
 local head={};
 
 if ejaCheck(moduleId) then
  head=tibulaSqlSearchHeader(query,moduleId);
  query=head[1]['query'];
 end

 local sql=ejaSqlMatrix(query);
 
 if ejaCheck(sql) then
  for k,v in pairs(sql) do
   setmetatable(v,getmetatable(sql))
   table.insert(a,tibulaSqlSearchRowFilter(head,v))
   y=y+1
  end
  setmetatable(a,getmetatable(sql))
 end
 tibula['ejaSqlCountTotal']=0;
 local x="";
 local moduleName=ejaSqlRun('SELECT name FROM ejaModules WHERE ejaId=%d',moduleId);
 if ejaCheck(moduleName) then x=string.find(query,"FROM "..moduleName.." WHERE"); end
 if ejaCheck(x) then
  local queryCountFrom=string.sub(query,x,-1);
  local queryCount=sf('SELECT COUNT(*) %s',queryCountFrom)
  if ejaCheck(queryCount) then
   local k,l=1,1;
   while l do 
    k,l=string.find(string.sub(queryCount,l),"ORDER BY") 
    if ejaCheck(l) then queryCountLimit=l end
   end
   if ejaCheck(queryCountLimit) then 
    queryCount=string.sub(queryCount,1,queryCountLimit-string.len("ORDER BY"))
    tibula['ejaSqlCountTotal']=ejaSqlRun(queryCount);
   end
  end
 end
 tibula['ejaSqlCount']=y;

 return a;
end


function tibulaSqlSearchHeader(query,moduleId) 	--return an associative array with the possible values for each columns and the "right" query to execute. 
 local head={};

 if ejaCheck(moduleId) then
  for k,v in pairs(ejaSqlMatrix("SELECT * FROM ejaFields WHERE ejaModuleId='%s' AND powerList!='' AND powerList>0 ORDER BY powerList;",moduleId)) do
   head[v['name']]={}
   if ejaCheck(v['type'],"boolean") then 
    head[v['name']]['value']={}
    head[v['name']]['value']['0']="FALSE";
    head[v['name']]['value']['1']="TRUE";
   end	
   if ejaCheck(v['type'],"select") then 
    head[v['name']]['value']=tibulaSelectToArray(v['value']); 
   end	
   if ejaCheck(v['type'],"sqlMatrix") then 
    head[v['name']]['value']=tibulaSelectSqlToArray(v['value']); 
   end
   if ejaCheck(v['type'],"sqlValue") or ejaCheck(v['type'],"sqlHidden") then 
    query=string.gsub(query,v['name'], sf('(%s) AS %s',v['value'],v['name']) ); 
   end
   if ejaCheck(v['translate']) then head[v['name']]['translation']=v['translate'] else head[v['name']]['translation']=0; end
  end
 end
 if not ejaCheck(head[1]) then head[1]={} end
 head[1]['query']=query;
 
 return head;
end


function tibulaSqlSearchRowFilter(head,row) 	--return filtered row with translation and subQuery substitution if needed.
 local a={};
 local value="";
 
 for k,v in ipairs(getmetatable(row)) do
  value=row[v]

  if ejaCheck(head[v]) and ejaCheck(head[v]['value']) then --if the v name begins with ejaId use ejaId as v for the value to search for.
   if ejaCheck(string.sub(v,1,5),"ejaId") then 
    value=head[v]['value'][a['ejaId']]; 
   else 
    value=head[v]['value'][row[v]]; 
   end
  end
  
  if ejaCheck(k,1) then 
   a[v]=value; 
  else 
   if ejaCheck(head[v]['translation']) then a[v]=tibulaTranslate(value);  else  a[v]=value; end
  end
  
 end

 return a;
end


function tibulaSelectSqlToArray(value)   --convert an sql query to bidimensional matrix for selectBox
 local a={};
 local ai={}
 local i,z=0,0;
 
 local queryName,queryValue=value:match('^%w+[ ]*(%w+),(%w+)')
 
 for k,v in pairs(ejaSqlMatrix(value)) do 
  k1,v1=next(v);
  k2,v2=next(v,k1);
  if v1 and v2 then
   if k1 == queryName then 
    table.insert(ai,v1)
    a[v1]=v2
   else
    table.insert(ai,v2)
    a[v2]=v1
   end
  end
 end
 setmetatable(a,ai);

 return a;
end


function tibulaSelectToArray(value)      --convert a "|" separated list of "\n" delimited rows to array for selectBox
 local a={}
 local ai={}
 local i=0;
 
 value=string.gsub(value,"\r","")
 
 if (string.find(value,"%|")) then
  for k,v in string.gmatch(value,"([^%|%\n]*)%|([^%\n]*)") do 
   a[k]=v; 
   table.insert(ai,k);
   end
 else 
  for k,v in string.gmatch(value,"([^\n]*)") do 
   a[k]=k; 
   if i == 0 then i=1; table.insert(ai,k); else i=0; end
  end
 end
 setmetatable(a,ai);
 
 return a;                      
end




