-- Copyright (C) 2007-2018 by Ubaldo Porcheddu <ubaldo@eja.it>
--
-- Malagueña


function tibulaJsonExport(moduleId)         --export data as json output
 tibula['ejaHttpHeaders']["Content-Type"]="application/json; charset=utf-8"
 tibula['ejaHttpHeaders']["Pragma"]="no-cache";
 tibula['ejaHttpHeaders']["Expires"]= "-1";
 tibula['ejaHttpHeaders']["Cache-Control"]="no-cache";

 local a={}

 a.ejaModule={}
 
 if ejaCheck(tibula['ejaActionType'],"List") then
 if ejaCheck(tibula['ejaSearchList']) then 
  local t=1;
  if ejaCheck(tibula['ejaLinking']) and not ejaCheck(tibula['ejaLinkingField']) and not ejaCheck(tibula['ejaModuleName'],"ejaFiles") then t=2 end 
  if ejaCheck(tibula['ejaMatrix']) then t=3 end
   a.ejaModule=tibulaJsonTable(tibula['ejaSearchList'],t); 
  else 
   tibulaReset();
   tibula['ejaActionType']="Search"; 
   tibulaInfo("ejaSearchEmpty");
  end
 end
 
 if not ejaCheck(tibula['ejaActionType'],"List") and ejaCheck(tibula['ejaFields']) then 
  a.ejaModule.ejaFields={}
  for k,v in pairs(tibula['ejaFields']) do
   a.ejaModule.ejaFields[#a.ejaModule.ejaFields+1]=tibulaJsonField(v['name'],v['type'],v['value'],v['values'])
  end
 end

 
 a.ejaMenu=tibulaJsonMenu(moduleId)
 
 a.ejaCommand=tibulaJsonCommand(moduleId)
 
 a.ejaInfo=tibulaJsonInfo()

 a.ejaModule.ejaId=tibula['ejaId']
 a.ejaModule.ejaModuleId=tibula['ejaModuleId']
 a.ejaModule.ejaSession=tibula['ejaSession']
 a.ejaModule.ejaModuleName=tibula['ejaModuleName']

 return ejaJsonEncode(a); 
end


function tibulaJsonMenu(moduleId)
 local i=0;
 local a={};
 local aa=tibulaSqlModuleTree(tibula['ejaOwner'],moduleId);
 
  a.ejaMenuPath={}
  for i=#aa['pathId'],1,-1 do
   a.ejaMenuPath[#a.ejaMenuPath+1]={ ejaModuleChange=aa['pathId'][i], name=aa['pathName'][i], label=tibulaTranslate(aa['pathName'][i]) }
  end

  a.ejaMenuLinks={} 
  for i=1,#aa['treeId'] do
   a.ejaMenuLinks[#a.ejaMenuLinks+1]={ ejaModuleChange=aa['treeId'][i], name=aa['treeName'][i], label=tibulaTranslate(aa['treeName'][i]) }
  end

  a.ejaModuleLinks={}
  for i=1,#aa['linkId'] do
   a.ejaModuleLinks[#a.ejaModuleLinks+1]={ ejaModuleChange=aa['linkId'][i], ejaModuleLink=tibula['ejaModuleId']..'.'..tibula['ejaId'], name=aa['linkName'][i], label=tibulaTranslate(aa['linkName'][i]) }
  end
  for i=1,#aa['historyId'] do
   a.ejaModuleLinks[#a.ejaModuleLinks+1]={ ejaModuleLinkBack=aa['historyId'][i], name=aa['historyName'][i], label=tibulaTranslate(aa['historyName'][i]) }
  end

 return a;
end


function tibulaJsonCommand(moduleId)
 local a={};
 
 for k,v in ipairs(tibulaSqlCommandArray(tibula['ejaOwner'],moduleId,tibula['ejaActionType'])) do
  local command={ name=v, label=tibulaTranslate(v) }
  if not ejaCheck(tibula['ejaSqlQuery64']) and ejaCheck(v,"list") then command=nil; end
  if ejaCheck(tibula['ejaSearchStep']) then 
   if not ejaCheck(tibula['ejaSqlLimit']) and ejaCheck(v,"previous") then command=nil; end
   if ejaCheck(tibula['ejaSqlLimit']) and not ejaCheck(tibula['ejaSearchStep'],tibula['ejaSqlCount']) and ejaCheck(v,"next") then command=nil; end
  end
  if not ejaCheck(tibula['ejaLinking']) and ( ejaCheck(v,"link") or ejaCheck(v,"unlink") or ejaCheck(v,"searchLink") or ejaCheck(v,"linkBack") ) then command=nil; end
  if ejaCheck(v,"searchLink") then command=nil; end
  if command then 
   a[#a+1]=command;
  end
 end
 
 return a;
end


function tibulaJsonField(fieldName, fieldType, fieldValue, fieldValueArray) 	--return the json field for name of tType. 
 local r="";
 local a={}
 
 a.type=fieldType
 a.name=fieldName
 a.label=tibulaTranslate(fieldName)
 a.value=fieldValue
 
 if ejaCheck(fieldType,"sqlTable") or ( ejaCheck(fieldType,"view") and ejaCheck(fieldValueArray) ) then 
  local aa=tibulaJsonTable(fieldValueArray,0)
  a.list=aa.ejaTableList
  a.head=aa.ejaTableHeader
 end 

 if ejaCheck(fieldType,"select") or ejaCheck(fieldType,"sqlMatrix") then
  local options="";
  local selected="";
  a.list={}
  for k,v in ipairs(getmetatable(fieldValueArray)) do
   a.list[#a.list+1]={ name=fieldValueArray[v], value=v }
  end
 end

 return a;
end


function tibulaJsonTable(sqlArray,t) 	--return json table of results for t. t=0 output plain table, t=1 first column is ejaId; t=2 first column ejaId, second powerLink.
 local a={}
 local y=0

 a.ejaTableList={}
 a.ejaTableHeader={}
 
 for key,row in pairs (sqlArray) do
  y=y+1

  local ax={}
  for k,v in pairs(getmetatable(sqlArray)) do
   if y == 1 then 
    a.ejaTableHeader[#a.ejaTableHeader+1]={}
    a.ejaTableHeader[#a.ejaTableHeader][v]=tibulaTranslate(v)
   end
   if row[v] then value=row[v] else value="" end
   if ejaString(v) == "ejaId" and t > 0 then 
    ax.ejaId=value 
    if t == 2 then
     local sql=tibulaSqlArray('SELECT ejaId,power FROM ejaLinks WHERE srcModuleId=%d AND srcFieldId=%s AND dstModuleId=%s AND dstFieldId=%s;',tibula['ejaModuleId'],value,tibula['ejaLinkModuleId'],tibula['ejaLinkFieldId']);
     if not ejaCheck(sql) then 
      sql={}
      sql['ejaId']=0; 
      sql['power']=0;
     end
     ax.ejaId=value
     ax.ejaLinkPowerValue=ejaNumber(sql.power)
     ax.ejaLinkPowerId=ejaNumber(sql.ejaId) 
    end
   else
    ax[v]=value
   end
  end
  a.ejaTableList[#a.ejaTableList+1]=ax
 end

 if ejaCheck(tibula['ejaSqlCountTotal']) then
  a.ejaTableCountTotal=tibula.ejaSqlCountTotal
  a.ejaTableLimit=tibula.ejaSqlLimit
  a.ejaTableCount=tibula.ejaSqlCount
  a.ejaTableSearchOrder=tibula.ejaSearchOrder
 end
 
 return a;
end


function tibulaJsonInfo() 	--return an alert/info box
 local info="";
 
 if ejaCheck(tibula['ejaActionType']) and ejaCheck(tibula['ejaAction']) then info="alert"..tibula['ejaActionType']..tibulaUCFirst(tibula['ejaAction']) end

 return tibulaInfo(info); 
end



