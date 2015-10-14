-- Copyright (C) 2007-2015 by Ubaldo Porcheddu <ubaldo@eja.it>
--
-- Suite española, Op. 47 


tibula={}
tibulaCDN="http://cdn.tibula.net/"

eja.mime["tibula"]="application/tibula"
eja.mimeApp['application/tibula']='tibulaWeb'
eja.lib.tibulaStop='tibulaStop'
eja.lib.tibulaStart='tibulaStart'

eja.help.tibulaStart='start tibula'
eja.help.tibulaStop='stop tibula'


function tibulaStart() 
 if tibulaSqlStart(eja.opt.sqlType,eja.opt.sqlUsername,eja.opt.sqlPassword,eja.opt.sqlHostname,eja.opt.sqlDatabase) then
  tibulaTableStart();
  ejaWeb();
 end
end


function tibulaStop()
 ejaSqlStop();
end


function tibulaWeb(web) 
 local opt={}
 tibulaTableStart()

 if not ejaSqlConnection or not ejaSqlRun("SELECT COUNT(*) FROM ejaSessions;") then 
  tibulaSqlStart(eja.opt.sqlType,eja.opt.sqlUsername,eja.opt.sqlPassword,eja.opt.sqlHostname,eja.opt.sqlDatabase) 
 else
  
 end
 
 for k,v in next,web.opt do
  opt[ejaUrlDecode(k)]=ejaUrlDecode(v)
 end

 tibulaTableImport(opt);
 tibulaTableRun()
 web.data=tibulaTableExport()

 for k,v in next,tibula.ejaHttpHeaders do web.headerOut[k]=v; end

 tibulaTableStop()
 return web
end

