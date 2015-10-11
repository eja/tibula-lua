-- Copyright (C) 2007-2015 by Ubaldo Porcheddu <ubaldo@eja.it>
--
-- Suite española, Op. 47 


tibula={}
tibulaCDN="http://media.tibula.org/"

eja.mime["tibula"]="application/tibula"
eja.mimeApp['application/tibula']='tibulaWeb'
eja.lib.tibulaStop='tibulaStop'
eja.lib.tibulaStart='tibulaStart'

eja.help.tibulaStart='start tibula'
eja.help.tibulaStop='stop tibula'


function tibulaStart() 
 sqlType=eja.opt.sqlType or "mysql"
 sqlUsername=eja.opt.sqlUsername or "root"
 sqlPassword=eja.opt.sqlPassword or "eja.it"
 sqlHostname=eja.opt.sqlHostname or "localhost"
 sqlDatabase=eja.opt.sqlDatabase or "tibula"
 if tibulaSqlStart(sqlType,sqlUsername,sqlPassword,sqlHostname,sqlDatabase) then
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

 if ejaSqlConnection and not ejaSqlRun("SELECT COUNT(*) FROM ejaSessions;") then 
  tibulaSqlStart(sqlType,sqlUsername,sqlPassword,sqlHostname,sqlDatabase) 
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

