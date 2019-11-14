-- Copyright (C) 2007-2019 by Ubaldo Porcheddu <ubaldo@eja.it>
--
-- Suite española, Op. 47 


tibula={}

eja.mime["tibula"]="application/tibula"
eja.mimeApp['application/tibula']='tibulaWeb'
eja.lib.tibulaStop='tibulaStop'
eja.lib.tibulaStart='tibulaStart'
eja.lib.tibulaInstall='tibulaInstall'
eja.lib.tibulaImport='tibulaImport'
eja.lib.tibulaExport='tibulaExport'

eja.help.tibulaStart='start tibula [web port] {35248}'
eja.help.tibulaStop='stop tibula [web port] {35248}'
eja.help.tibulaInstall='create db/user and install demo version'
eja.help.tibulaPath='tibula data path'
eja.help.tibulaScript='javascript full url {https://cdn.tibula.net/tibula.js}'
eja.help.tibulaCron='cron keep alive interval {0=off}'
eja.help.tibulaImport='import module {file name}'
eja.help.tibulaExport='export module {module name}'

eja.opt.webSize=65536


function tibulaCheck()
 if ejaNumber(eja.version) == 0 or ejaNumber(eja.version) < 12.1024 then
  ejaError('[tibula] eja version too old, please update eja first.')
  os.exit()
 end
end


function tibulaStart() 
 tibulaCheck()
 if ejaNumber(eja.opt.tibulaStart) > 0 then 
  eja.opt.webPort=eja.opt.tibulaStart 
 else
  eja.opt.webPort=eja.opt.webPort or 35248
 end
 ejaInfo('[tibula] starting on web port %s and database %s',eja.opt.webPort,eja.opt.tibulaDatabase);
 if tibulaSqlStart(eja.opt.tibulaType,eja.opt.tibulaUsername,eja.opt.tibulaPassword,eja.opt.tibulaHostname,eja.opt.tibulaDatabase) then
  if ejaNumber(eja.opt.tibulaCron) > 0 then
   if ejaFork()==0 then 
    ejaPidWrite('tibula.cron.'..eja.opt.webPort);
    ejaInfo('[tibula] cron job start with %s sec. interval',eja.opt.tibulaCron);
    while true do
     ejaSleep(ejaNumber(eja.opt.tibulaCron))
     local data=ejaWebGet("http://localhost:%s/.tibula",eja.opt.webPort)
     if not data or #data < 1 then
      ejaWarn('[tibula] cron job stop')
      break
     end
    end
    os.exit(); 
   end
  end 
  tibulaTableStart();
  ejaWebStart();
 end
end


function tibulaStop()
 ejaInfo('[tibula] halting on web port %s',eja.opt.webPort);
 if ejaNumber(eja.opt.tibulaStop) > 0 then eja.opt.webPort=eja.opt.tibulaStop end
 ejaPidKillTree(ejaSprintf('web_%d',eja.opt.webPort or 35248))
end


function tibulaWeb(web) 
 tibulaCheck()
 tibulaTableStart()
 tibulaSqlCheck()
 
 if web.postFile and web.headerIn then
  if web.headerIn['content-type'] == 'application/json' then
   local a=ejaJsonFileRead(web.postFile)
   if a then 
    for k,v in next,a do
     web.opt[k]=v
    end
    web.opt.ejaOut='json' 
   end
  end
  if web.headerIn['content-type'] == 'application/octet-stream' then
   local file=ejaFileRead(web.postFile)
   local a={}
   a.hash=ejaSha256(file)
   ejaFileMove(web.postFile,tibula.path..a.hash)
   web.headerOut['Content-Type'] = 'application/json'
   web.data=ejaJsonEncode(a)
   web.opt=nil
  end
  ejaFileRemove(web.postFile)
 end

 if web.opt then
  if web.opt.data and web.opt.data:match('^[%x]+$') then
   local path=tibula.path..web.opt.data
   if ejaFileCheck(path) then
    web.headerOut['Content-Disposition']='attachment; filename="'..web.opt.data..'"'
    web.file=path
   else
    web.status='404 Not Found'
   end
  else 
   tibulaTableImport(web.opt);
   tibulaTableRun(web)
   web.data=tibulaTableExport()
   for k,v in next,tibula.ejaHttpHeaders do web.headerOut[k]=v; end
   tibulaTableStop()
  end
 end
 
 return web
end


function tibulaInstall()
 ejaUpdate()
 local type=eja.opt.tibulaType or "maria"
 local user=eja.opt.tibulaUsername or ejaReadLine("tibula db username: ")
 local pass=eja.opt.tibulaPassword or ejaReadLine("tibula db password: ")
 local host=eja.opt.tibulaHostname or 'localhost'
 local db=eja.opt.tibulaDatabase or ejaReadLine("tibula db name: ")
 local installUsername=eja.opt.tibulaInstallUsername or ejaReadLine("local db username: ")
 local installPassword=eja.opt.tibulaInstallPassword or ejaReadLine("local db password: ")
 if user ~= "" and pass ~= "" and db ~= "" then
  local sqlTmpFile=eja.pathTmp..'/tibula.install.sql'
  if ejaFileStat(sqlTmpFile) then ejaFileRemove(sqlTmpFile) end
  ejaFileWrite(sqlTmpFile,ejaSprintf([[
   CREATE DATABASE %s;
   CREATE USER '%s'@'%s' IDENTIFIED BY '%s';
   GRANT ALL PRIVILEGES ON %s.* TO '%s'@'%s' WITH GRANT OPTION;
   FLUSH PRIVILEGES;
   USE %s;
  ]],db,user,host,pass,db,user,host,db))
  ejaExecute('wget -qO - "http://github.com/ubaldus/tibula/raw/master/tibula.sql" >> %s',sqlTmpFile)
  if installUsername ~= "" and installPassword ~= "" then
   ejaExecute('mysql -u %s -p%s < %s',installUsername,installPassword,sqlTmpFile)
  else
   ejaExecute('mysql < "%s"',sqlTmpFile)   
  end
  ejaFileRemove(sqlTmpFile)
  if tibulaSqlStart('maria',user,pass,'localhost',db) then
   ejaInfo('[tibula] database ready')
   if not ejaFileStat(eja.pathEtc..'/eja.init') then ejaSetup() end
   if ejaFileAppend(eja.pathEtc..'/eja.init',ejaSprintf([[
    --tibula setup
    eja.opt.tibulaUsername="%s"
    eja.opt.tibulaPassword="%s"
    eja.opt.tibulaDatabase="%s"
    eja.opt.tibulaCron=300
   ]],user,pass,db)) then
    ejaWarn('[tibula] eja.init updated, please check')
   end
  else
   ejaError('[tibula] database installation error')   
  end
 else
  ejaError('[tibula] username, password and database name are mandatory')
 end
end


function tibulaImport(module)
 local module=module or eja.opt.tibulaImport
 local data=ejaJsonFileRead(module)
 if data then
  if tibulaSqlCheck() then
   tibulaModuleImport(data)
   ejaInfo('[tibula] module %s imported from file %s',data.name,module)
  end
 else
  ejaError('[tibula] file not valid')
 end
end


function tibulaExport(module)
 local module=module or eja.opt.tibulaExport
 if tibulaSqlCheck() then
  local data=ejaJsonEncode(tibulaModuleExport(module),1)
  if data then
   ejaFileWrite(module..'.json',data)
   ejaInfo('[tibula] module %s exported to file %s.json',module,module)
  else
   ejaError('[tibula] module not found') 
  end
 end
end
