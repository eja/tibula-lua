-- Copyright (C) 2007-2016 by Ubaldo Porcheddu <ubaldo@eja.it>
--
-- Suite española, Op. 47 


tibula={}
tibulaCDN="http://cdn.tibula.net/"

eja.mime["tibula"]="application/tibula"
eja.mimeApp['application/tibula']='tibulaWeb'
eja.lib.tibulaStop='tibulaStop'
eja.lib.tibulaStart='tibulaStart'

eja.help.tibulaStart='start tibula [web port] {35248}'
eja.help.tibulaStop='stop tibula [web port] {35248}'
eja.opt.webSize=65536

function tibulaStart() 
 if ejaNumber(eja.opt.tibulaStart) > 0 then eja.opt.webPort=eja.opt.tibulaStart end
 ejaInfo('[tibula] starting on web port %s and database %s',eja.opt.webPort,eja.opt.sqlDatabase);
 if tibulaSqlStart(eja.opt.sqlType,eja.opt.sqlUsername,eja.opt.sqlPassword,eja.opt.sqlHostname,eja.opt.sqlDatabase) then
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
 tibulaTableStart()

 if not ejaSqlConnection or not ejaSqlRun("SELECT COUNT(*) FROM ejaSessions;") then 
  tibulaSqlStart(eja.opt.sqlType,eja.opt.sqlUsername,eja.opt.sqlPassword,eja.opt.sqlHostname,eja.opt.sqlDatabase) 
 end
 
 if web and web.postFile and web.headerIn and web.headerIn['content-type'] == 'application/json' then
  local a=ejaJsonFileRead(web.postFile)
  if a then 
   for k,v in next,a do
    web.opt[k]=v
   end
   web.opt.ejaOut='json' 
  end
 end

 tibulaTableImport(web.opt);
 tibulaTableRun(web)
 web.data=tibulaTableExport()

 for k,v in next,tibula.ejaHttpHeaders do web.headerOut[k]=v; end

 tibulaTableStop()
 return web
end

