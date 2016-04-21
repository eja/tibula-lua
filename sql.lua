-- Copyright (C) 2007-2016 by Ubaldo Porcheddu <ubaldo@eja.it>


eja.help.sqlType='db type (mysql|sqlite3) {sqlite3}'
eja.help.sqlUsername='db username'
eja.help.sqlPassword='db password'
eja.help.sqlHostname='db hostname'
eja.help.sqlDatabase='db name'

ejaSqlConnection=nil


function ejaSqlStart(sqlType,sqlUsername,sqlPassword,sqlHostname,sqlDatabase)	--start sql connection

 local sqlType=sqlType or eja.opt.sqlType or "sqlite3"
 local sqlUsername=sqlUsername or eja.opt.sqlUsername
 local sqlPassword=sqlPassword or eja.opt.sqlPassword
 local sqlHostname=sqlHostname or eja.opt.sqlHostname
 local sqlDatabase=sqlDatabase or eja.opt.sqlDatabase

 ejaSqlType=sqlType
  
 if ejaFileStat(eja.pathLib..'luasql/'..sqlType..'.so') then 
  eja.sql=require "luasql."..sqlType
 else
  ejaError('[sql] %s library missing',sqlType)
  return nil
 end

 if eja.sql then 
  if sqlType=="mysql" then 
   ejaSqlConnection=eja.sql.mysql():connect(sqlDatabase,sqlUsername,sqlPassword,sqlHostname);
  end
 
  if sqlType=="sqlite3" then
   ejaSqlConnection=eja.sql.sqlite3():connect(sqlDatabase);
   if ejaSqlConnection then
    ejaSqlConnection:execute("PRAGMA journal_mode = MEMORY;");
    if sqlPassword ~= "" then ejaSqlConnection:execute(ejaSprintf("PRAGMA key = '%s';",sqlPassword)); end
    ejaSqlConnection:execute("PRAGMA temp_store = MEMORY;");
   end
  end
 end

 if ejaSqlConnection then 
  ejaDebug('[sql] %s connection open',sqlType) 
 else
  ejaError('[sql] %s connection error',sqlType)
 end

 return ejaSqlConnection;   
end


function ejaSqlStop()	--stop sql connection
 ejaDebug('[sql] %s connection closed',sqlType)
 if ejaSqlType=="mysql" then return ejaSqlConnection:close(); end
 if ejaSqlType=="sqlite3" then return ejaSqlConnection:close(); end
end


function ejaSqlQuery(query,...)	--filter sql query 
 ejaTrace('[sql] %s',query) 
 return query;
end


function ejaSqlMatrix(query,...)	--sql multi rows array
 query=ejaSqlQuery(query,...);

 local row={}; 
 local rows={};
 local cur=ejaSqlConnection:execute(query);
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
 
 return rows;
end


function ejaSqlArray(query,...)	--sql last row array
 query=ejaSqlQuery(query,...);
 
 local rowLast={}
 local cur=ejaSqlConnection:execute(query);
 if cur then
  local row=cur:fetch({},"a");
  rowLast=row;
  while row do 
   rowLast=row;
   row=cur:fetch({}, "a");
  end
  cur:close();
 end
   
 return rowLast;
end


function ejaSqlRun(query,...)	--execute sql command 
 query=ejaSqlQuery(query,...);

 local r;
 local cur=ejaSqlConnection:execute(query);
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

 return r;
end


function ejaSqlLastId()	--retrieve last inserted row id
 if ejaSqlType == "mysql" then return ejaSqlRun('SELECT LAST_INSERT_ID();'); end
 if ejaSqlType == "sqlite3" then return ejaSqlRun('SELECT last_insert_rowid();'); end
end


function ejaSqlTableCreate(tableName)	--create a new table if it does not exist
 local r=0;
 
 if ejaString(tableName) ~= "" and not ejaSqlRun('SELECT * FROM %s LIMIT 1;',tableName) then
  local extra="";
  if ejaSqlType == "mysql" then extra=" AUTO_INCREMENT "; end
  if ejaSqlRun('CREATE TABLE %s (ejaId INTEGER %s PRIMARY KEY, ejaOwner INTEGER, ejaLog DATETIME);',tableName,extra) then
   r=1;
  else 
   r=-1;
  end
 end

 return r;
end


function ejaSqlTableColumnCreate(tableName, columnName, columnType) 	--add a new column field into a table if it does not exist
 local r=0;   
 local dataType=ejaSqlTableDataType(columnType);

 if ejaString(dataType) ~= "" and not ejaSqlRun('SELECT %s FROM %s LIMIT 1',columnName,tableName) then
  if ejaSqlRun('ALTER TABLE %s ADD %s %s;',tableName,columnName,dataType) then
   r=1;
  else
   r=-1;
  end
 end

 return r;
end


function ejaSqlIncludeList(query,...)   --return a comma separated list of values to be included in IN() clause (only first column will be addded).
 query=ejaSqlQuery(query,...);

 local list=""; 
 local cur=ejaSqlConnection:execute(query);
 if (cur) then
  local row=cur:fetch({},"n")
  while row do 
   list=list..","..row[1]
   row=cur:fetch({},"n");
  end
  cur:close();
 end
 
 return string.sub(list,2);
end


function ejaSqlNow()   --return actual datetime 
 return os.date('%Y-%m-%d %H:%M:%S');
end


function ejaSqlUnixTime(value)	--?convert value to unix or sql timestamp
 local r="";
 
 if ejaString(ejaSqlType) == "sqlite3" then 
  if ejaNumber(value) > 0 then
   r=ejaSqlRun("SELECT datetime(%d, 'unixepoch');",value);
  else
   r=ejaSqlRun("SELECT strftime('%%s','%s');",value); 
  end
 end
 
 if ejaString(ejaSqlType) == "mysql" then 
  if ejaNumber(value) > 0 then
   r=ejaSqlRun("SELECT FROM_UNIXTIME(%d);",value);
  else
   r=ejaSqlRun("SELECT UNIX_TIMESTAMP('%s');",value); 
  end
 end
 
 return r or 0;
end


function ejaSqlEscape(data)	--escape data for sql
  return string.gsub(data,"'", "''");
end


function ejaSqlTableDataType(sType)	--return sql data type syntax for sType data type
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
 if sType=="text" 		then dType="CHAR(255)"; 		end
 if sType=="hidden"	 	then dType="CHAR(255)"; 		end
 if sType=="view" 		then dType="CHAR(255)"; 		end
 if sType=="select" 		then dType="TEXT"; 			end
 if sType=="sqlValue" 		then dType="TEXT"; 			end
 if sType=="sqlHidden" 		then dType="TEXT"; 			end
 if sType=="sqlMatrix" 		then dType="TEXT"; 			end
 if sType=="textArea" 		then dType="MEDIUMTEXT"; 		end
 if sType=="htmlArea"		then dType="MEDIUMTEXT"; 		end

 return dType;
end


