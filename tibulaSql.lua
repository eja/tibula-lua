-- Copyright (C) 2007-2019 by Ubaldo Porcheddu <ubaldo@eja.it>
--
-- Prelude Op. 23 No. 5


eja.help.tibulaType='db type (maria|mysql|sqlite3) {maria}'
eja.help.tibulaUsername='db username'
eja.help.tibulaPassword='db password'
eja.help.tibulaHostname='db hostname'
eja.help.tibulaDatabase='db name'

tibulaSqlType=nil
tibulaSqlConnection=nil


function tibulaSqlStart(sqlType,sqlUsername,sqlPassword,sqlHostname,sqlDatabase)	--start sql connection

 local sqlType=sqlType or eja.opt.sqlType or "maria"
 local sqlUsername=sqlUsername or eja.opt.tibulaUsername or eja.opt.sqlUsername -- eja.opt.sqlxxx deprecated
 local sqlPassword=sqlPassword or eja.opt.tibulaPassword or eja.opt.sqlPassword
 local sqlHostname=sqlHostname or eja.opt.tibulaHostname or eja.opt.sqlHostname
 local sqlDatabase=sqlDatabase or eja.opt.tibulaDatabase or eja.opt.sqlDatabase

 tibulaSqlType=sqlType
 
 if sqlType == "maria" and eja.maria then
  eja.sql=ejaMaria();
 elseif ejaFileStat(eja.pathLib..'luasql/'..sqlType..'.so') then 
  if sqlType == "sqlite3" then eja.sql=require "luasql.sqlite3" end
  if sqlType == "mysql" then eja.sql=require "luasql.mysql" end
 else
  ejaError('[sql] %s library missing',sqlType)
  return nil
 end

 if eja.sql then 
  if sqlType=="maria" then
   tibulaSqlConnection=ejaMariaOpen(sqlHostname,3306,sqlUsername,sqlPassword,sqlDatabase)
   tibulaSqlRun("SET SESSION sql_mode = '';")
   tibulaSqlRun("CREATE TABLE IF NOT EXISTS `ejaSessions` (`ejaId` integer NOT NULL AUTO_INCREMENT primary key, `ejaOwner` integer default 0, `ejaLog` datetime default NULL, `name` varchar(255) default NULL, `value` varchar(8192), `sub` varchar(255) default NULL) ENGINE=MEMORY;");     
  end
 
  if sqlType=="mysql" then 
   tibulaSqlConnection=eja.sql.mysql():connect(sqlDatabase,sqlUsername,sqlPassword,sqlHostname);
   tibulaSqlRun("SET SESSION sql_mode = '';");
   tibulaSqlRun("CREATE TABLE IF NOT EXISTS `ejaSessions` (`ejaId` integer NOT NULL AUTO_INCREMENT primary key, `ejaOwner` integer default 0, `ejaLog` datetime default NULL, `name` varchar(255) default NULL, `value` varchar(8192), `sub` varchar(255) default NULL) ENGINE=MEMORY;");     
  end
 
  if sqlType=="sqlite3" then
   tibulaSqlConnection=eja.sql.sqlite3():connect(sqlDatabase);
   if tibulaSqlConnection then
    tibulaSqlRun("PRAGMA journal_mode = MEMORY;");
    if sqlPassword ~= "" then tibulaSqlRun("PRAGMA key = '%s';",sqlPassword); end
    tibulaSqlRun("PRAGMA temp_store = MEMORY;");
   end
  end
 end

 if tibulaSqlConnection then 
  ejaDebug('[sql] %s connection open',sqlType) 
 else
  ejaError('[sql] %s connection error',sqlType)
 end

 return tibulaSqlConnection;   
end


function tibulaSqlStop()	--stop sql connection
 ejaDebug('[sql] %s connection closed',sqlType)
 if tibulaSqlType=="maria" then return ejaMariaClose(); end
 if tibulaSqlType=="mysql" then return tibulaSqlConnection:close(); end
 if tibulaSqlType=="sqlite3" then return tibulaSqlConnection:close(); end
end


function tibulaSqlMatrix(query,...)	--sql multi rows array
 query=tibulaSqlQuery(query,...);

 local row={}; 
 local rows={};
 if tibulaSqlType == "maria" then
  rows=ejaMariaQuery(query)
  local cols={}
  for rk,rv in next,getmetatable(rows) do
   for rvk,rvv in next,rv do
    if rvk=="name" then cols[#cols+1]=rvv end
   end
  end
  setmetatable(rows,cols)
 else
  local cur=tibulaSqlConnection:execute(query);
  if cur then
   setmetatable(rows,cur:getcolnames(row));
   row=cur:fetch({},"a");
   while row do 
    local a={}
    table.insert(rows,row)
    row=cur:fetch({}, "a");
   end
   cur:close();
  end
 end
 
 return rows;
end


function tibulaSqlArray(query,...)	--sql last row array
 query=tibulaSqlQuery(query,...);
 
 local rowLast={}
 if tibulaSqlType == "maria" then
  for rk,rv in next,ejaMariaQuery(query) do
   rowLast=rv
  end
 else
  local cur=tibulaSqlConnection:execute(query);
  if cur then
   local row=cur:fetch({},"a");
   rowLast=row;
   while row do 
    rowLast=row;
    row=cur:fetch({}, "a");
   end
   cur:close();
  end
 end
    
 return rowLast;
end


function tibulaSqlRun(query,...)	--execute sql command 
 query=tibulaSqlQuery(query,...);

 local r;
 if tibulaSqlType == "maria" then
  rv=ejaMariaQuery(query) 
  if rv then 
   for k,v in next,rv do
    if type(v) == "table" then
     for kk,vv in next,v do r=vv end
    else
     r=v
    end
   end 
  end
 else
  local cur=tibulaSqlConnection:execute(query);
  if type(cur) == "userdata" then
   local row=cur:fetch({},"n");
   if row then 
    r=row[1]
   else 
    r=false; 
   end
  else  
    r=cur;
  end
  if cur and type(cur) ~= "number" then cur:close(); end
 end
 return r;
end


function tibulaSqlLastId()	--retrieve last inserted row id
 if tibulaSqlType == "maria" then return tibulaSqlRun('SELECT LAST_INSERT_ID();'); end
 if tibulaSqlType == "mysql" then return tibulaSqlRun('SELECT LAST_INSERT_ID();'); end
 if tibulaSqlType == "sqlite3" then return tibulaSqlRun('SELECT last_insert_rowid();'); end
end


function tibulaSqlTableCreate(tableName)	--create a new table if it does not exist
 local r=0;
 
 if ejaString(tableName) ~= "" and not tibulaSqlRun('SELECT * FROM %s LIMIT 1;',tableName) then
  local extra="";
  if tibulaSqlType == "maria" then extra=" AUTO_INCREMENT "; end  
  if tibulaSqlType == "mysql" then extra=" AUTO_INCREMENT "; end  
  if tibulaSqlRun('CREATE TABLE %s (ejaId BINGINT UNSIGNED %s PRIMARY KEY, ejaOwner INTEGER, ejaLog DATETIME);',tableName,extra) then
   r=1;
  else 
   r=-1;
  end
 end

 return r;
end


function tibulaSqlTableColumnCreate(tableName, columnName, columnType) 	--add a new column field into a table if it does not exist
 local r=0;   
 local dataType=tibulaSqlTableDataType(columnType);

 if ejaString(dataType) ~= "" and not tibulaSqlRun('SELECT %s FROM %s LIMIT 1',columnName,tableName) then
  if tibulaSqlRun('ALTER TABLE %s ADD %s %s;',tableName,columnName,dataType) then
   r=1;
  else
   r=-1;
  end
 end

 return r;
end


function tibulaSqlIncludeList(query,...)   --return a comma separated list of values to be included in IN() clause (only first column will be addded).
 local query=tibulaSqlQuery(query,...);
 local r='';
 local list=""; 
 for rk,rv in next,tibulaSqlMatrix(query) do
  local k,v=next(rv)
  list=list..','..v
 end
 
 return string.sub(list,2);
end


function tibulaSqlNow()   --return actual datetime 
 return os.date('%Y-%m-%d %H:%M:%S');
end


function tibulaSqlUnixTime(value)	--?convert value to unix or sql timestamp
 local r="";
 
 if tibulaSqlType == "sqlite3" then 
  if ejaNumber(value) > 0 then
   r=tibulaSqlRun("SELECT datetime(%d, 'unixepoch');",value);
  else
   r=tibulaSqlRun("SELECT strftime('%%s','%s');",value); 
  end
 end
 
 if tibulaSqlType == "maria" or tibulaSqlType == "mysql" then 
  if ejaNumber(value) > 0 then
   r=tibulaSqlRun("SELECT FROM_UNIXTIME(%d);",value);
  else
   r=tibulaSqlRun("SELECT UNIX_TIMESTAMP('%s');",value); 
  end
 end
 
 return r or 0;
end


function tibulaSqlEscape(data)	--escape data for sql
  return string.gsub(data,"'", "''");
end


function tibulaSqlTableDataType(sType)	--return sql data type syntax for sType data type
 local dType="";

 sType=ejaString(sType)
 if sType=="boolean" 		then dType="INTEGER(1) DEFAULT 0";	end
 if sType=="integer"		then dType="INTEGER DEFAULT 0"; 	end
 if sType=="integerRange"	then dType="INTEGER DEFAULT 0";		end
 if sType=="decimal" 		then dType="DECIMAL(10,2)"; 		end
 if sType=="date" 		then dType="DATE"; 			end
 if sType=="dateRange" 		then dType="DATE"; 			end
 if sType=="time" 		then dType="TIME"; 			end
 if sType=="timeRange" 		then dType="TIME"; 			end
 if sType=="datetime" 		then dType="DATETIME"; 			end
 if sType=="datetimeRange"	then dType="DATETIME"; 			end
 if sType=="text" 		then dType="TEXT";	 		end
 if sType=="hidden"	 	then dType="TEXT"; 			end
 if sType=="view" 		then dType="TEXT"; 			end
 if sType=="file" 		then dType="TEXT"; 			end
 if sType=="select" 		then dType="TEXT"; 			end
 if sType=="sqlValue" 		then dType="TEXT"; 			end
 if sType=="sqlHidden" 		then dType="TEXT"; 			end
 if sType=="sqlMatrix" 		then dType="TEXT"; 			end
 if sType=="textArea" 		then dType="TEXT"; 			end
 if sType=="htmlArea"		then dType="TEXT";	 		end

 return dType;
end


function tibulaSqlQuery(query,...)	--filter sql query 
 argIn=table.pack(...)
 argOut={}
 for k,v in next,argIn do
  if tonumber(k) then
   str=tostring(v)
   str=str:gsub("'","''")  
   str=str:gsub("%%","%%%%")   
   argOut[k]=str
  end
 end
 query=string.format(query,table.unpack(argOut))
 
 if ejaCheck(tibula['ejaOwner']) and ejaCheck(tibula['ejaModuleId']) and not ejaCheck(tibula['ejaModuleName'],"ejaFields") and not ejaCheck(tibula['ejaModuleName'],"ejaSql") and not ejaCheck(tibula['ejaModuleName'],"ejaBackups") then
  query=string.gsub(query,"@ejaOwner",tibula['ejaOwner']);
 end

 ejaTrace('[sql] %s',query)

 return query;
end


function tibulaSqlOwnerList(ownerId)	--return the allowed id list of owners for active module and ownerId
 local moduleId;
 if ejaNumber(tibula['ejaModuleLink']) > 0 and ejaNumber(tibula['ejaModuleChange']) > 0 then moduleId=tibula['ejaModuleChange']; else moduleId=tibula['ejaModuleId']; end

 local groupOwners=tibulaSqlIncludeList("SELECT dstFieldId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaGroups') AND srcFieldId IN (SELECT srcFieldId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaGroups') AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaUsers') AND dstFieldId=%d AND srcFieldId IN ( SELECT dstFieldId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaModules') AND srcFieldId=%d AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaGroups') )) AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaUsers');",ownerId,moduleId);

 local ownerTree="";
 local sub=ownerId;
 local deep=10;
 local value="0";
 while ejaNumber(deep) > 0 do
  deep=deep-1;
  value=tibulaSqlIncludeList('SELECT ejaId FROM ejaUsers WHERE ejaOwner IN (%s) AND ejaId NOT IN (%s);',sub,sub);
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
 local query="";
 
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
 query=ejaSprintf("SELECT * FROM ejaCommands WHERE (ejaId IN (SELECT ejaCommandId FROM ejaPermissions WHERE ejaModuleId=%d AND ejaId IN (SELECT srcFieldId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId From ejaModules WHERE name='ejaPermissions') AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaUsers') AND dstFieldId=%d)) %s ) %s %s;",moduleId,userId,extra,linking,order)
 for k,v in pairs(tibulaSqlMatrix(query)) do
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
  row=tibulaSqlArray("SELECT ejaId,parentId,name FROM ejaModules WHERE ejaId=%d;",id);
  id=nil;
  if ejaCheck(row) and tibulaSqlRun("SELECT ejaId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaPermissions') AND srcFieldId IN (SELECT ejaId FROM ejaPermissions WHERE ejaModuleId=%d) AND dstFieldId=%d AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaUsers') LIMIT 1;",row['ejaId'],ownerId) then
   table.insert(a['pathId'],row['ejaId'])
   table.insert(a['pathName'],row['name'])
   if ejaCheck(row['parentId']) then
    id = row['parentId']
   end
  end
 end
 --tree 
 row=tibulaSqlMatrix("SELECT ejaId,name FROM ejaModules WHERE parentId=%d ORDER BY power ASC;",moduleId);
 if not ejaCheck(row) then
  if not ejaCheck(a['pathId']) then
   row=tibulaSqlMatrix("SELECT ejaId,name FROM ejaModules WHERE parentId=0 OR parentId='' AND ejaId != %d ORDER BY power ASC;",moduleId);
  end
 end
 if ejaCheck(row) then
  for k,v in pairs(row) do
   if ejaCheck(row) and tibulaSqlRun("SELECT ejaId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaPermissions') AND srcFieldId IN (SELECT ejaId FROM ejaPermissions WHERE ejaModuleId=%d) AND dstFieldId=%d AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaUsers') LIMIT 1;",v['ejaId'],ownerId) then
    if not ("#ejaFiles#ejaSql#ejaBackups#"):find(v['name']) then
     table.insert(a['treeId'],v['ejaId']);
     table.insert(a['treeName'],v['name']);
    end
   end
  end
 end
 --links
 if ejaCheck(tibula['ejaId']) then
  for k,v in pairs(tibulaSqlMatrix('SELECT srcModuleId,(SELECT name FROM ejaModules WHERE ejaId=srcModuleId) AS srcModuleName FROM ejaModuleLinks WHERE dstModuleId=%d ORDER BY power ASC;',moduleId)) do 
   if not ejaCheck(tibula['ejaLinkHistory']) or not ejaCheck(tibula['ejaLinkHistory'][v['srcModuleId']]) and tibulaSqlRun("SELECT ejaId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaPermissions') AND srcFieldId IN (SELECT ejaId FROM ejaPermissions WHERE ejaModuleId=%d) AND dstFieldId=%d AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaUsers') LIMIT 1;",v['srcModuleId'],ownerId) then
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
    table.insert(a['historyName'],tibulaTranslate(tibulaSqlRun('SELECT name FROM ejaModules WHERE ejaId=%d;',k)));
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
 
 for k,v in pairs (tibulaSqlMatrix("SELECT * FROM ejaFields WHERE ejaModuleId=%d AND power%s>0 AND power%s!='' ORDER BY power%s ASC",moduleId,actionType,actionType,actionType)) do 
  if ejaCheck(tibula['ejaAction'],"view") then t="view"; else t=v['type']; end
  if ejaCheck(matrix,1) and ejaCheck(v['matrixUpdate']) then 
   t="matrix" 
  end
  if ejaCheck(v['ejaGroup']) and ejaCheck(tibula['ejaActionType'],"Edit") then
   if not tibulaSqlRun("SELECT ejaId FROM ejaLinks WHERE srcModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaGroups') AND dstModuleId=(SELECT ejaId FROM ejaModules WHERE name='ejaUsers') AND dstFieldId=%d AND srcFieldId=%d LIMIT 1;",tibula['ejaOwner'],v['ejaGroup']) then
    t="view";
   end 
  end
  local rowName=v['name'];
  local rowType=t;
  local rowValue=""
  local rowArray={}
  if tibula.ejaValues and tibula['ejaValues'][rowName] then rowValue=tibula['ejaValues'][rowName]; end
  if ejaCheck(v['type'],"select") then rowArray=tibulaSelectToArray(v['value']); end
  if ejaCheck(v['type'],"sqlMatrix") then rowArray=tibulaSelectSqlToArray(v['value']); end
  if ejaCheck(v['type'],"sqlValue") or ejaCheck(v['type'],"sqlHidden") then rowValue=tibulaSqlRun(v['value']); end
  if ejaCheck(v['type'],"sqlTable") then rowArray=tibulaSqlMatrix(v['value']); end
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

 local sql=tibulaSqlMatrix(query);
 
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
 local moduleName=tibulaSqlRun('SELECT name FROM ejaModules WHERE ejaId=%d',moduleId);
 if ejaCheck(moduleName) then x=string.find(query,"FROM "..moduleName.." WHERE"); end
 if ejaCheck(x) then
  local queryCountFrom=string.sub(query,x,-1);
  local queryCount=ejaSprintf('SELECT COUNT(*) %s',queryCountFrom)
  if ejaCheck(queryCount) then
   local k,l=1,1;
   while l do 
    k,l=string.find(string.sub(queryCount,l),"ORDER BY") 
    if ejaCheck(l) then queryCountLimit=l end
   end
   if ejaCheck(queryCountLimit) then 
    queryCount=string.sub(queryCount,1,queryCountLimit-string.len("ORDER BY"))
    tibula['ejaSqlCountTotal']=tibulaSqlRun(queryCount);
   end
  end
 end
 tibula['ejaSqlCount']=y;

 return a;
end


function tibulaSqlSearchHeader(query,moduleId) 	--return an associative array with the possible values for each columns and the "right" query to execute. 
 local head={};

 if ejaCheck(moduleId) then
  for k,v in pairs(tibulaSqlMatrix("SELECT * FROM ejaFields WHERE ejaModuleId='%s' AND powerList!='' AND powerList>0 ORDER BY powerList;",moduleId)) do
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
    query=string.gsub(query,v['name'], ejaSprintf('(%s) AS %s',v['value'],v['name']) ); 
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
   if head and head[v] and head[v]['translation'] then a[v]=tibulaTranslate(value);  else  a[v]=value; end
  end
  
 end

 return a;
end


function tibulaSelectSqlToArray(value)   --convert an sql query to bidimensional matrix for selectBox
 local a={};
 local ai={}
 local i,z=0,0;
 
 local queryName,queryValue=value:match('^%w+[ ]*(%w+),(%w+)')
 
 for k,v in pairs(tibulaSqlMatrix(value)) do 
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


--deprecated functions
function ejaSqlArray(query,...) return tibulaSqlArray(query,...); end
function ejaSqlEscape(data) return tibulaSqlEscape(data); end
function ejaSqlIncludeList(query,...) return tibulaSqlIncludeList(query,...); end
function ejaSqlLastId() return tibulaSqlLastId(); end
function ejaSqlMatrix(query,...) return tibulaSqlMatrix(query,...); end
function ejaSqlNow() return tibulaSqlNow(); end
function ejaSqlQuery(query,...) return tibulaSqlQuery(query,...); end
function ejaSqlRun(query,...) return tibulaSqlRun(query,...); end
function ejaSqlStart(sqlType,sqlUsername,sqlPassword,sqlHostname,sqlDatabase) return tibulaSqlStart(sqlType,sqlUsername,sqlPassword,sqlHostname,sqlDatabase); end
function ejaSqlStop() return tibulaSqlStop(); end
function ejaSqlTableColumnCreate(tableName, columnName, columnType) return tibulaSqlTableColumnCreate(tableName, columnName, columnType); end
function ejaSqlTableCreate(tableName) return tibulaSqlTableCreate(tableName); end
function ejaSqlTableDataType(sType) return tibulaSqlTableDataType(sType); end
function ejaSqlUnixTime(value) return tibulaSqlUnixTime(value); end
