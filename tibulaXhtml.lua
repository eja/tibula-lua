-- Copyright (C) 2007-2022 by Ubaldo Porcheddu <ubaldo@eja.it>
--
-- Magyar rapszódiák


function tibulaXhtmlExport(moduleId)         --export data as xhtml output
 tibula.ejaHttpHeader["Content-Type"]="text/html; charset=utf-8"
 tibula.ejaHttpHeader["Pragma"]="no-cache";
 tibula.ejaHttpHeader["Expires"]= "-1";
 tibula.ejaHttpHeader["Cache-Control"]="no-cache";
 
 local o={};
 o[#o+1]=tibulaXhtmlHeader();
 o[#o+1]=tibulaXhtmlMenu(moduleId);
 o[#o+1]=tibulaXhtmlModule(moduleId);
 o[#o+1]=tibulaXhtmlInfo();
 o[#o+1]=tibulaXhtmlCommand(moduleId);
 o[#o+1]=tibulaXhtmlFooter();
 
 return table.concat(o); 
end


function tibulaXhtmlHeader() 	--return xhtml header and open form
 local o={};

 local script=eja.opt.tibulaScript or "https://cdn.eja.cloud/tibula.js";
 o[#o+1]=ejaSprintf([[<!DOCTYPE html>]]);
 o[#o+1]=ejaSprintf([[<html lang="%s">]], tibula.ejaLanguage, tibula.ejaLanguage);
 o[#o+1]=ejaSprintf([[<head>]]);
 o[#o+1]=ejaSprintf([[<meta charset="utf-8">]]);
 o[#o+1]=ejaSprintf([[<meta name="author" content="ubaldo@eja.it">]]);
 o[#o+1]=ejaSprintf([[<meta name="viewport" content="width=device-width, initial-scale=1.0">]]);
 o[#o+1]=ejaSprintf([[<script type="text/javascript" src="%s"></script>]], script);
 o[#o+1]=ejaSprintf([[<title>[%s]</title>]], tibulaTranslate(tibula.ejaModuleName));
 o[#o+1]=ejaSprintf([[</head>]]);
 o[#o+1]=ejaSprintf([[<body><div id="ejaPage"><form name="ejaForm" action="?" method="post">]]);

 return table.concat(o);
end


function tibulaXhtmlFooter()	--return xhtml closed tags 
 local o={};
 
 if ejaNumber(tibula.ejaId) > 0		then o[#o+1]=ejaSprintf([[<input type="hidden" name="ejaId" value="%d"/>]], tibula.ejaId); end
 if ejaNumber(tibula.ejaModuleId) > 0	then o[#o+1]=ejaSprintf([[<input type="hidden" name="ejaModuleId" value="%d"/>]], tibula.ejaModuleId); end
 if ejaString(tibula.ejaSession) ~= ""	then o[#o+1]=ejaSprintf([[<input type="hidden" name="ejaSession" value="%s"/>]], tibula.ejaSession); end
 if ejaString(tibula.ejaLanguage) ~= ""	then o[#o+1]=ejaSprintf([[<input type="hidden" name="ejaLanguage" value="%s">]], tibula.ejaLanguage); end
 
 o[#o+1]=[[</form></div></body></html>]];
 
 return table.concat(o);
end


function tibulaXhtmlMenu(moduleId)		 --return the modules reverse traversal tree
 local i=0;
 local o={};
 local a=tibulaSqlModuleTree(tibula.ejaOwner, moduleId);
 local session=ejaSprintf([[ejaSession=%s&amp;ejaLanguage=%s]], tibula.ejaSession, tibula.ejaLanguage);
 
 o[#o+1]=[[<div id="ejaMenu">]];
  
 o[#o+1]=[[<div id="ejaMenuPath">]];
 o[#o+1]=ejaSprintf([[<a href="?%s&amp;ejaModuleId=%d&amp;ejaModuleChange=35248">%s</a>]], session, moduleId, tibulaTranslate("ejaRoot"));
 for i=#a.pathId,1,-1 do
  o[#o+1]=ejaSprintf([[ <a href="?%s&amp;ejaModuleId=%d&amp;ejaModuleChange=%d">%s</a>]], session, moduleId,a.pathId[i],tibulaTranslate(a.pathName[i]));
 end
 o[#o+1]=[[</div>]];
 
 o[#o+1]=[[<div id="ejaMenuLinks">]];
 for i=1,#a.treeId do
  o[#o+1]=ejaSprintf([[ <a href="?%s&amp;ejaModuleId=%d&amp;ejaModuleChange=%d">%s</a>]], session, moduleId, a.treeId[i], tibulaTranslate(a.treeName[i]));
 end
 o[#o+1]=[[</div>]];

 o[#o+1]=[[<div id="ejaModuleLinks">]];
 for i=1,#a.linkId do
  o[#o+1]=ejaSprintf([[<a href="?%s&amp;ejaModuleChange=%d&amp;ejaModuleLink=%d.%d">%s</a> ]], session, a.linkId[i], tibula.ejaModuleId, tibula.ejaId, tibulaTranslate(a.linkName[i]));
 end
 for i=1,#a.historyId do
  o[#o+1]=ejaSprintf([[ <a class="active" href="?%s&amp;ejaModuleLinkBack=%d">%s</a>]], session, a.historyId[i], tibulaTranslate(a.historyName[i]));
 end
 o[#o+1]=[[</div>]]; 
 
 o[#o+1]=[[</div>]];
 
 return table.concat(o);
end


function tibulaXhtmlModule(moduleId) 	--return the module. 
 local o={};
 local a={};
 local moduleName=tibulaSqlModuleGetNameById(moduleId);
 
 o[#o+1]=ejaSprintf([[<div id="ejaModule" class="ejaModule%s">]], tibulaUCFirst(moduleName));
 
 if ejaString(tibula.ejaActionType) == "List" then
  if ejaTableCount(tibula.ejaSearchList) > 0 then 
   local t=1;
   if ejaNumber(tibula.ejaLinking) > 0 and ejaString(tibula.ejaLinkingField) == "" and ejaString(tibula.ejaModuleName) ~= "ejaFiles" then t=2; end 
   if ejaNumber(tibula.ejaMatrix) > 0 then t=3; end
   o[#o+1]=tibulaXhtmlTable(tibula.ejaSearchList, t); 
  else 
   tibulaReset();
   tibula.ejaActionType="Search"; 
   tibulaInfo("ejaSearchEmpty");
  end
 end
 
 if ejaString(tibula.ejaActionType) ~= "List" and ejaTableCount(tibula.ejaFields) > 0 then 
  for k,v in next, tibula.ejaFields do
   o[#o+1]=tibulaXhtmlField(v.name, v.type, v.value, v.values);
  end
 end
 
 o[#o+1]=[[</div>]];

 return table.concat(o);
end


function tibulaXhtmlCommand(moduleId) 	--return the html list of enabled commands for this module
 local o={};
 
 o[#o+1]=[[<div id="ejaCommands">]];
 
 for k,v in next,tibulaSqlCommandArray(tibula.ejaOwner, moduleId, tibula.ejaActionType) do
  v=ejaString(v);
  local command=ejaSprintf([[ <input id="ejaCommand%s" type="submit" name="ejaAction[%s]" value="%s"/>]], tibulaUCFirst(v), v, tibulaTranslate(v));
  if ejaString(tibula.ejaSqlQuery64) == "" and v == "list" then command=""; end
  if ejaNumber(tibula.ejaSearchStep) > 0 then 
   if ejaNumber(tibula.ejaSqlLimit) == 0 and v == "previous" then command=""; end
   if ejaNumber(tibula.ejaSqlLimit) > 0 and ejaNumber(tibula.ejaSearchStep) ~= ejaNumber(tibula.ejaSqlCount) and v == "next" then command=""; end
  end
  if ejaNumber(tibula.ejaLinking) == 0 and (v == "link" or v == "unlink" or v == "searchLink" or v == "linkBack") then command=""; end
  if v == "searchLink" then command=""; end
  o[#o+1]=command;
 end
 
 o[#o+1]=[[</div>]];

 return table.concat(o);
end


function tibulaXhtmlField(fieldName, fieldType, fieldValue, fieldValueArray) 	--return the xhtml field for name of tType. 
 local o={};
 local fieldType=ejaString(fieldType);
 local fieldName=ejaString(fieldName);
 local fieldValueEncoded=ejaString(fieldValue):gsub(".", function(x) return string.format("&#x%x;",x:byte()) end);

 if fieldType == "label" then 
  o[#o+1]=ejaSprintf([[<div class="ejaModule%s">%s</div>]], tibulaUCFirst(fieldType), tibulaTranslate(fieldName));
 end
  
 if fieldType == "sqlTable" then 
  o[#o+1]=ejaSprintf([[<fieldset class="ejaModule%s"><legend>%s</legend>%s</fieldset>]], tibulaUCFirst(fieldType), tibulaTranslate(fieldName), tibulaXhtmlTable(fieldValueArray, 0));
 end 

 if fieldType == "text" or fieldType == "password" then
  o[#o+1]=ejaSprintf([[<fieldset class="ejaModule%s"><legend>%s</legend><input type="%s" name="ejaValues[%s]" value="%s"/></fieldset>]], tibulaUCFirst(fieldType), tibulaTranslate(fieldName), fieldType, fieldName, fieldValueEncoded);
 end

 if fieldType == "integer" or fieldType == "integerRange" or fieldType == "decimal" then
  if fieldType == "integerRange" and ejaSting(tibula.ejaActionType) == "Search" then
   if not tibula.ejaValues[fieldName..".begin"] then tibula.ejaValues[fieldName..".begin"]=""; end
   if not tibula.ejaValues[fieldName..".end"] then tibula.ejaValues[fieldName..".end"]=""; end
   o[#o+1]=ejaSprintf([[<fieldset class="ejaModule%s"><legend>%s</legend>]], tibulaUCFirst(fieldType), tibulaTranslate(fieldName));
   o[#o+1]=ejaSprintf([[<label>%s<input type="text" name="ejaValues[%s.begin]" value="%s"/></label>]], tibulaTranslate("ejaIntegerFrom"), fieldName, tibula.ejaValues[fieldName..".begin"]);  
   o[#o+1]=ejaSprintf([[<label>%s<input type="text" name="ejaValues[%s.end]" value="%s"/></label>]], tibulaTranslate("ejaIntegerTo"), fieldName,tibula.ejaValues[fieldName..".end"]);  
   o[#o+1]=ejaSprintf([[</fieldset>]]);
  else
   if not tibula.ejaValues[fieldName] then 
    fieldValue=""; 
   else 
    fieldValue=tibula.ejaValues[fieldName]; 
   end 
   o[#o+1]=ejaSprintf([[<fieldset class="ejaModule%s"><legend>%s</legend><input type="%s" name="ejaValues[%s]" value="%s"/></fieldset>]], string.sub(tibulaUCFirst(fieldType),0,-5), tibulaTranslate(fieldName), fieldType, fieldName, fieldValue);
  end
 end

 if fieldType == "textArea" or fieldType == "htmlArea" then
  local class="";
  local title=tibulaTranslate(fieldName);
  if fieldType == "htmlArea" then 
   class=[[class="jsEditor"]];
   fieldValue=tibulaXhtmlFilter(fieldValue); 
   title=tibulaTranslate(fieldName);
  end
  o[#o+1]=ejaSprintf([[<fieldset class="ejaModule%s"><legend>%s</legend><textarea %s name="ejaValues[%s]">%s</textarea></fieldset>]], tibulaUCFirst(fieldType), title, class, fieldName, fieldValue);
 end

 if string.find("#date#dateRange#time#timeRange#datetime#datetimeRange#", fieldType) then
  if string.find(fieldType, "Range") and ejaString(tibula.ejaActionType) == "Search" then
   if not tibula.ejaValues[fieldName..".begin"] then tibula.ejaValues[fieldName..".begin"]=""; end
   if not tibula.ejaValues[fieldName..".end"] then tibula.ejaValues[fieldName..".end"]=""; end
   o[#o+1]=ejaSprintf([[<fieldset class="ejaModule%s"><legend>%s</legend>]], tibulaUCFirst(fieldType), tibulaTranslate(fieldName));
   o[#o+1]=ejaSprintf([[<label>%s<input type="text" name="ejaValues[%s.begin]" value="%s" /></label>]], tibulaTranslate("ejaDateFrom"), fieldName,tibula.ejaValues[fieldName..".begin"]);  
   o[#o+1]=ejaSprintf([[<label>%s<input type="text" name="ejaValues[%s.end]" value="%s" /></label>]], tibulaTranslate("ejaDateTo"), fieldName, tibula.ejaValues[fieldName..".end"]);
   o[#o+1]=ejaSprintf([[</fieldset>]]);
  else
   o[#o+1]=ejaSprintf([[<fieldset class="ejaModule%s"><legend>%s</legend><input type="text" name="ejaValues[%s]" value="%s" /></fieldset>]], string.sub(tibulaUCFirst(fieldType),0,-5), tibulaTranslate(fieldName), fieldName, fieldValue);
  end
 end

 if fieldType == "boolean" then
  if ejaString(fieldValue) ~= "" then 
   options=[[<option value="1" selected="selected">TRUE</option><option value="0">FALSE</option>]]; 
  else 
   options=[[<option value="1">TRUE</option><option value="0" selected="selected">FALSE</option>]]; 
  end
  if ejaString(tibula.ejaActionType) == "Search" then options=[[<option></option><option value="1">TRUE</option><option value="0">FALSE</option>]]; end
  o[#o+1]=ejaSprintf([[<fieldset class="ejaModule%s"><legend>%s</legend><select name="ejaValues[%s]">%s</select></fieldset>]], tibulaUCFirst(fieldType), tibulaTranslate(fieldName), fieldName, options);
 end

 if fieldType == "select" or fieldType == "sqlMatrix" then
  local options="";
  local selected="";
  for k,v in next, getmetatable(fieldValueArray) do
   if ejaString(fieldValue) == ejaString(v) then selected=[[ selected="selected"]]; else selected=""; end
    options=options..ejaSprintf([[<option value="%s"%s>%s</option>]], v, selected, fieldValueArray[v]);
  end
  o[#o+1]=ejaSprintf([[<fieldset class="ejaModule%s"><legend>%s</legend><select name="ejaValues[%s]"><option></option>%s</select></fieldset>]], tibulaUCFirst(fieldType), tibulaTranslate(fieldName), fieldName, options);   
 end

 if fieldType == "sqlValue" then
  o[#o+1]=ejaSprintf([[<fieldset class="ejaModule%s"><legend>%s</legend><b>%s</b></fieldset>]], tibulaUCFirst(fieldType), tibulaTranslate(fieldName), fieldValue); 
 end
 
 if fieldType == "view" then
  o[#o+1]=ejaSprintf([[<fieldset class="ejaModule%s"><legend>%s</legend><input type="text" value="%s" disabled></fieldset>]], tibulaUCFirst(fieldType), tibulaTranslate(fieldName), ejaString(fieldValue));
 end
 
 if fieldType == "hidden" then
  o[#o+1]=ejaSprintf([[<fieldset class="ejaModule%s"><input type="%s" name="ejaValues[%s]" value="%s"/></fieldset>]], tibulaUCFirst(fieldType), fieldType, fieldName, fieldValueEncoded);
 end
 
 if fieldType == "file" then 
  o[#o+1]=ejaSprintf([[<fieldset class="ejaModule%s"><legend>%s</legend><input type="%s" name="%s" onClick="ejaForm.enctype=\'multipart/form-data\'"/></fieldset>]], tibulaUCFirst(fieldType), tibulaTranslate(fieldName), fieldType, fieldName);  
 end
 
 return table.concat(o);
end


function tibulaXhtmlTable(sqlArray, t) 	--return html table of results for t. t=0 output plain table, t=1 first column is ejaId; t=2 first column ejaId, second powerLink. t=3 each cell is editable, ejaValuesUpdate will be populated with row name, ejaId, and value.
 local o={};
 local value="";
 local ejaIdRow=0;
 local y,x=0,0;
 
 o[#o+1]=[[<table id="ejaTableList" border="1">]];

 for key,row in next,sqlArray do
  y=y+1;
  
  if (y==1) then
   o[#o+1]=[[<tr>]];
   for k,v in next,getmetatable(sqlArray) do 
    if (k == 1 and t > 0) then 
     o[#o+1]=[[<th class="mini"><input type="checkbox" name="ejaIdCheckAll" /></th>]];
     if (t == 2) then o[#o+1]=ejaSprintf([[<th class="mini">%s</th>]], tibulaTranslate("powerLink")); end
    else 
     if (t == 1 or t == 2) then
      options=[[<option></option>]];
      if tibula.ejaSearchOrder and ejaString(tibula.ejaSearchOrder[v]) == "ASC" or string.find(tibula.ejaSqlOrder, " "..v.." ASC") then 
       options=options..ejaSprintf([[<option value="ASC" selected="selected">AZ</option>]]);
      else
       options=options..ejaSprintf([[<option value="ASC">AZ</option>]]); 
      end
      if tibula.ejaSearchOrder and ejaString(tibula.ejaSearchOrder[v]) == "DESC" or string.find(tibula.ejaSqlOrder, " "..v.." DESC") then 
       options=options..ejaSprintf([[<option value="DESC" selected="selected">ZA</option>]]); 
      else 
       options=options..ejaSprintf([[<option value="DESC">ZA</option>]]); 
      end
      o[#o+1]=ejaSprintf([[<th>%s</th><th class="mini"><select name="ejaSearchOrder[%s]">%s</select></th>]], tibulaTranslate(v), v, options); 
     else
      o[#o+1]=ejaSprintf([[<th colspan="2">%s</th>]], tibulaTranslate(v)); 
     end
    end
   end
   o[#o+1]=[[</tr>]];
  end 
  
  o[#o+1]=[[<tr>]];
  x=0;
  for k,v in next,getmetatable(sqlArray) do
   x=x+1;
   if row[v] then 
    value=row[v];
   else 
    value="";
   end
   if ejaString(v) == "ejaId" and t > 0 then 
    ejaIdRow=value;
    o[#o+1]=ejaSprintf([[<td><input type="checkbox" name="ejaId[%d]" value="%d" /></td>]], value, value); 
    if t == 2 then
     local sql=tibulaSqlLinkGetPower(tibula.ejaModuleId, value, tibula.ejaLinkModuleId, tibula.ejaLinkFieldId);
     if ejaTableCount(sql) == 0 then 
      sql={};
      sql.ejaId=0; 
      sql.power=0;
     end
     o[#o+1]=ejaSprintf([[<td class="powerLink"><input type="text" name="ejaLinkPower[%d][%d]" value="%d" onClick="ejaIdCheck(%d)"/></td>]], value, sql.ejaId, sql.power, value);
    end
   else 
    if t == 3 then
     o[#o+1]=ejaSprintf([[<td class="powerLink" colspan="2"><input type="text" name="ejaValues[%s.%d]" value="%s"/></td>]], v, ejaIdRow, value); 
    else
     o[#o+1]=ejaSprintf([[<td colspan="2">%s</td>]], value); 
    end
   end
  end
  o[#o+1]=[[</tr>]];
  
 end
 
 if ejaNumber(tibula.ejaSqlCountTotal) > 0 then
  o[#o+1]=ejaSprintf([[<tr><th colspan="%d">%d-%d / %d</th></tr>]], (x*2), ejaNumber(tibula.ejaSqlLimit)+1, (ejaNumber(tibula.ejaSqlLimit)+ejaNumber(tibula.ejaSqlCount)), ejaNumber(tibula.ejaSqlCountTotal));
 end
 
 o[#o+1]=[[</table>]];
 
 return table.concat(o);
end


function tibulaXhtmlInfo() 	--return an alert/info box
 local info="";
 
 if ejaString(tibula.ejaActionType) ~= "" and ejaString(tibula.ejaAction) ~= "" then 
  info="alert"..tibula.ejaActionType..tibulaUCFirst(tibula.ejaAction); 
 end

 return ejaSprintf([[<div id="ejaInfo">%s</div>]], tibulaInfo(info)); 
end


function tibulaXhtmlFilter(value) 
 value=string.gsub(value, "&", "&amp;");
 value=string.gsub(value, "'", "&#039;");
 value=string.gsub(value, "\"", "&quot;");
 value=string.gsub(value, "<", "&lt;");
 value=string.gsub(value, ">", "&gt;");
    
 return value;
end
