-- Copyright (C) 2007-2021 by Ubaldo Porcheddu <ubaldo@eja.it>
--
-- Nocturne no.20


function tibulaReset()    --reset global variables
 tibula.ejaSqlLimit=0;
 tibula.ejaSqlOrder="";
 tibula.ejaSqlQuery64="";
 tibula.ejaValues={};
 tibula.ejaId=0;
end


function tibulaModuleLua(step, web)	--load lua script from ejaModule 
 tibulaModuleLuaStep=step or 0;
 local script=tibulaSqlTableGetAllById("ejaModules", tibula.ejaModuleId).lua;
 if ejaString(script) ~= "" then
   local func,err=loadstring(script, tibula.ejaModuleName)(web);
   if func then 
    func();
   else
    ejaError("[tibula] %s", err);
   end
 end
end


function tibulaSessionCode()	--generate new ejaSession id
 local seed=tibula.ejaOwner;

 math.randomseed(os.time()); 
 for i=1,10 do seed=seed..math.random(0, 9); end
 
 return ejaSha256(seed);
end


function tibulaTranslate(value)	--return translated value for active module and language or same if not found
 local r;

 if not tibula.ejaTranslation then
  tibula.ejaTranslation={};
  tibula.ejaTranslation['Eja']="eja";
  for k,v in next, tibulaSqlTranslateMatrix(tibula.ejaModuleId, tibula.ejaLanguage) do 
   tibula.ejaTranslation[v.word]=v.translation;
  end
 end
 
 if tibula.ejaTranslation[value] then
  r=tibula.ejaTranslation[value]; 
 else 
  r=value; 
 end
 
 return ejaString(r);
end


function tibulaInfo(value) 	--append value to the info box for alert, info and error messages and return the new infos

 if ejaString(value) ~= "" then
  translation=tibulaTranslate(value);
  if translation and translation ~= value then
   if not translation:match("^%s*$") then
    tibula.ejaInfo=ejaSprintf([[%s%s]].."\n", ejaString(tibula.ejaInfo), translation);
   end
  else
   ejaTrace("[tibula] missing translation: %s %s", tibula.ejaLanguage, value);
  end
 end
 
 return ejaString(tibula.ejaInfo);
end


function tibulaLinkHistory(module, value) 	--manage linking history
 if not tibula.ejaLinkHistory or ejaString(module) == "" then 
  tibula.ejaLinkHistory={}; 
 end

 if ejaNumber(value) > 0 then
  tibula.ejaLinkHistory[module]=value;
 else
  for k,v in next,tibula.ejaLinkHistory do
   if ejaNumber(module) == ejaNumber(k)  then 
    tibula.ejaLinkHistory[k]=nil;
   end
  end
 end

 return 0; 
end


function tibulaDateSet(value, type)		--convert datetime to dd/mm/yyyy or viceversa
 value=string.gsub(value, "/", "-");
 if not value then value=""; end
 if not string.find(type, "time") then 
  value=string.sub(value, 1, 10);
 end
 
 return value;
end


function tibulaUCFirst(value)	--return first letter capitalized value
 if value then
  value=string.gsub(value, "%a", string.upper, 1);
 end
 return value;
end


function tibulaModuleImport(a, tableName)
 return tibulaSqlModuleImport(a, tableName);
end


function tibulaModuleExport(tableName) 
 return tibulaSqlModuleExport(tableName);
end


