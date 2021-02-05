-- Copyright (C) 2007-2021 by Ubaldo Porcheddu <ubaldo@eja.it>
--
-- Malagueña


function tibulaJsonExport(moduleId)         --export data as json output
 tibula.ejaHttpHeader["Content-Type"]="application/json; charset=utf-8";
 tibula.ejaHttpHeader["Pragma"]="no-cache";
 tibula.ejaHttpHeader["Expires"]= "-1";
 tibula.ejaHttpHeader["Cache-Control"]="no-cache";

 local a={};

 a.ejaModule={};
 
 if ejaString(tibula.ejaActionType) == "List" then
 if ejaTableCount(tibula.ejaSearchList) > 0 then 
  local t=1;
  if ejaNumber(tibula.ejaLinking) > 0 and ejaString(tibula.ejaLinkingField) == "" and ejaString(tibula.ejaModuleName) ~= "ejaFiles" then t=2; end 
  if ejaNumber(tibula.ejaMatrix) > 0 then t=3; end
   a.ejaModule=tibulaJsonTable(tibula.ejaSearchList, t); 
  else 
   tibulaReset();
   tibula.ejaActionType="Search"; 
   tibulaInfo("ejaSearchEmpty");
  end
 end
 
 if ejaString(tibula.ejaActionType) ~= "List" and ejaTableCount(tibula.ejaFields) > 0 then 
  a.ejaModule.ejaFields={};
  for k,v in next,tibula.ejaFields do
   table.insert(a.ejaModule.ejaFields, tibulaJsonField(v.name, v.type, v.value, v.values)); 
  end
 end
 
 a.ejaMenu=tibulaJsonMenu(moduleId);
 a.ejaCommand=tibulaJsonCommand(moduleId);
 a.ejaInfo=tibulaJsonInfo();
 a.ejaModule.ejaId=tibula.ejaId;
 a.ejaModule.ejaModuleId=tibula.ejaModuleId;
 a.ejaModule.ejaSession=tibula.ejaSession;
 a.ejaModule.ejaModuleName=tibula.ejaModuleName;

 return ejaJsonEncode(a); 
end


function tibulaJsonMenu(moduleId)
 local i=0;
 local a={};
 local aa=tibulaSqlModuleTree(tibula.ejaOwner, moduleId);
 
  a.ejaMenuPath={};
  for i=#aa["pathId"],1,-1 do
   table.insert(a.ejaMenuPath, { ejaModuleChange=aa.pathId[i], name=aa.pathName[i], label=tibulaTranslate(aa.pathName[i]) });
  end

  a.ejaMenuLinks={};
  for i=1,#aa.treeId do
   table.insert(a.ejaMenuLinks, { ejaModuleChange=aa.treeId[i], name=aa.treeName[i], label=tibulaTranslate(aa.treeName[i]) });
  end

  a.ejaModuleLinks={};
  for i=1,#aa.linkId do
   table.insert(a.ejaModuleLinks, { ejaModuleChange=aa.linkId[i], ejaModuleLink=tibula.ejaModuleId.."."..tibula.ejaId, name=aa.linkName[i], label=tibulaTranslate(aa.linkName[i]) });
  end
  for i=1,#aa.historyId do
   table.insert(a.ejaModuleLinks, { ejaModuleLinkBack=aa.historyId[i], name=aa.historyName[i], label=tibulaTranslate(aa.historyName[i]) });
  end

 return a;
end


function tibulaJsonCommand(moduleId)
 local a={};
 
 for k,v in next,tibulaSqlCommandArray(tibula.ejaOwner, moduleId, tibula.ejaActionType) do
  local command={ name=v, label=tibulaTranslate(v) };
  if ejaString(tibula.ejaSqlQuery64) == "" and ejaString(v) == "list" then command=nil; end
  if ejaNumber(tibula.ejaSearchStep) > 0 then 
   if ejaNumber(tibula.ejaSqlLimit) == 0 and ejaString(v) == "previous" then command=nil; end
   if ejaNumber(tibula.ejaSqlLimit) > 0 and ejaNumber(tibula.ejaSearchStep) ~= ejaNumber(tibula.ejaSqlCount) and ejaString(v) == "next" then command=nil; end
  end
  if ejaNumber(tibula.ejaLinking) > 0 and ( ejaString(v) == "link" or ejaString(v) == "unlink" or ejaString(v) == "searchLink" or ejaString(v) == "linkBack") then command=nil; end
  if ejaString(v) == "searchLink" then command=nil; end
  if command then 
   a[#a+1]=command;
  end
 end
 
 return a;
end


function tibulaJsonField(fieldName, fieldType, fieldValue, fieldValueArray) 	--return the json field for name of tType. 
 local r="";
 local a={};
 
 a.type=fieldType;
 a.name=fieldName;
 a.label=tibulaTranslate(fieldName);
 a.value=fieldValue;
 
 if ejaString(fieldType) == "sqlTable" or ( ejaString(fieldType) == "view" and ejaTableCount(fieldValueArray) > 0) then 
  local aa=tibulaJsonTable(fieldValueArray, 0);
  a.list=aa.ejaTableList;
  a.head=aa.ejaTableHeader;
 end 

 if ejaString(fieldType) == "select" or ejaString(fieldType) == "sqlMatrix" then
  local options="";
  local selected="";
  a.list={};
  for k,v in next,getmetatable(fieldValueArray) do
   a.list[#a.list+1]={ name=fieldValueArray[v], value=v };
  end
 end

 return a;
end


function tibulaJsonTable(sqlArray, t) 	--return json table of results for t. t=0 output plain table, t=1 first column is ejaId; t=2 first column ejaId, second powerLink.
 local a={};
 local y=0;

 a.ejaTableList={};
 a.ejaTableHeader={};
 
 for key,row in next,sqlArray do
  y=y+1;

  local ax={};
  for k,v in next,getmetatable(sqlArray) do
   if y == 1 then 
    a.ejaTableHeader[#a.ejaTableHeader+1]={};
    a.ejaTableHeader[#a.ejaTableHeader][v]=tibulaTranslate(v);
   end
   if row[v] then value=row[v]; else value=""; end
   if ejaString(v) == "ejaId" and t > 0 then 
    ax.ejaId=value;
    if t == 2 then
     local sql=tibulaSqlLinkGetPower(tibula.ejaModuleId, value, tibula.ejaLinkModuleId, tibula.ejaLinkFieldId);
     if ejaTableCount(sql) == 0 then 
      sql={};
      sql.ejaId=0; 
      sql.power=0;
     end
     ax.ejaId=value;
     ax.ejaLinkPowerValue=ejaNumber(sql.power);
     ax.ejaLinkPowerId=ejaNumber(sql.ejaId);
    end
   else
    ax[v]=value;
   end
  end
  a.ejaTableList[#a.ejaTableList+1]=ax;
 end

 if ejaNumber(tibula.ejaSqlCountTotal) > 0 then
  a.ejaTableCountTotal=tibula.ejaSqlCountTotal;
  a.ejaTableLimit=tibula.ejaSqlLimit;
  a.ejaTableCount=tibula.ejaSqlCount;
  a.ejaTableSearchOrder=tibula.ejaSearchOrder;
 end
 
 return a;
end


function tibulaJsonInfo() 	--return an alert/info box
 local info="";
 
 if ejaString(tibula.ejaActionType) ~= "" and ejaString(tibula.ejaAction) ~= "" then info="alert"..tibula.ejaActionType..tibulaUCFirst(tibula.ejaAction); end

 return tibulaInfo(info); 
end
