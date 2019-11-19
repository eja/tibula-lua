-- Copyright (C) 2007-2019 by Ubaldo Porcheddu <ubaldo@eja.it>
--
-- Magyar rapszódiák


function tibulaXhtmlExport(moduleId)         --export data as xhtml output
 tibula.ejaHttpHeaders["Content-Type"]="text/html; charset=utf-8"
 tibula.ejaHttpHeaders["Pragma"]="no-cache";
 tibula.ejaHttpHeaders["Expires"]= "-1";
 tibula.ejaHttpHeaders["Cache-Control"]="no-cache";
 
 local r=''
 r=r..tibulaXhtmlHeader()
 r=r..tibulaXhtmlMenu(moduleId)
 r=r..tibulaXhtmlModule(moduleId)
 r=r..tibulaXhtmlInfo()
 r=r..tibulaXhtmlCommand(moduleId)
 r=r..tibulaXhtmlFooter();
 
 return r; 
end


function tibulaXhtmlHeader() 	--return xhtml header and open form
 local r="";

 local script=eja.opt.tibulaScript or "https://cdn.tibula.net/tibula.js"
 
 r=ejaSprintf('<!DOCTYPE html>');
 r=r..ejaSprintf('<html lang="%s">',tibula.ejaLanguage,tibula.ejaLanguage);
 r=r..ejaSprintf('<head>');
 r=r..ejaSprintf('<meta charset="utf-8">')
 r=r..ejaSprintf('<meta name="author" content="ubaldo@eja.it">')
 r=r..ejaSprintf('<meta name="viewport" content="width=device-width, initial-scale=1.0">')
 r=r..ejaSprintf('<script type="text/javascript" src="%s"></script>',script);
 r=r..ejaSprintf('<title>[%s]</title>',tibulaTranslate(tibula.ejaModuleName));
 r=r..ejaSprintf('</head>');
 r=r..ejaSprintf('<body><div id="ejaPage"><form name="ejaForm" action="?ejaLanguage=%s" method="post">',tibula.ejaLanguage);

 return r;
end


function tibulaXhtmlFooter()	--return xhtml closed tags 
 local r=""
 
 if ejaNumber(tibula.ejaId) > 0 then r=r..ejaSprintf('<input type="hidden" name="ejaId" value="%d"/>',tibula.ejaId); end
 if ejaNumber(tibula.ejaModuleId) > 0 then r=r..ejaSprintf('<input type="hidden" name="ejaModuleId" value="%d"/>',tibula.ejaModuleId); end
 if ejaString(tibula.ejaSession) ~= "" then r=r..ejaSprintf('<input type="hidden" name="ejaSession" value="%s"/>',tibula.ejaSession); end
 r=r..ejaSprintf('</form></div></body></html>');
 
 return r;
end


function tibulaXhtmlMenu(moduleId)		 --return the modules reverse traversal tree
 local i=0;
 local r="";
 local a=tibulaSqlModuleTree(tibula['ejaOwner'],moduleId);
 
 r='<div id="ejaMenu">';
  
  r=r..'<div id="ejaMenuPath">'
  r=r..ejaSprintf('<a href="?ejaSession=%s&amp;ejaModuleId=%d&amp;ejaModuleChange=35248">%s</a>',tibula['ejaSession'],moduleId,tibulaTranslate("ejaRoot"));
  for i=#a['pathId'],1,-1 do
   r=r..ejaSprintf(' <a href="?ejaSession=%s&amp;ejaModuleId=%d&amp;ejaModuleChange=%d">%s</a>',tibula['ejaSession'],moduleId,a['pathId'][i],tibulaTranslate(a['pathName'][i]));
  end
  r=r..'</div>';
 
  r=r..'<div id="ejaMenuLinks">';
  for i=1,#a['treeId'] do
   r=r..ejaSprintf(' <a href="?ejaSession=%s&amp;ejaModuleId=%d&amp;ejaModuleChange=%d">%s</a>',tibula['ejaSession'],moduleId,a['treeId'][i],tibulaTranslate(a['treeName'][i]));
  end
  r=r.."</div>";

  r=r..'<div id="ejaModuleLinks">';   
  for i=1,#a['linkId'] do
   r=r..ejaSprintf('<a href="?ejaSession=%s&amp;ejaModuleChange=%d&amp;ejaModuleLink=%d.%d">%s</a> ',tibula['ejaSession'],a['linkId'][i],tibula['ejaModuleId'],tibula['ejaId'],tibulaTranslate(a['linkName'][i]));
  end
  for i=1,#a['historyId'] do
   r=r..ejaSprintf(' <a class="active" href="?ejaSession=%s&amp;ejaModuleLinkBack=%d">%s</a>',tibula['ejaSession'],a['historyId'][i],tibulaTranslate(a['historyName'][i]));
  end
  r=r..'</div>'; 
 
 r=r.."</div>";
 
 return r;
end


function tibulaXhtmlModule(moduleId) 	--return the module. 
 local r="";
 local moduleName=tibulaSqlRun('SELECT name FROM ejaModules WHERE ejaId=%d;',moduleId);
 local a={}
 
 if ejaCheck(tibula['ejaActionType'],"List") then
  if ejaCheck(tibula['ejaSearchList']) then 
   local t=1;
   if ejaCheck(tibula['ejaLinking']) and not ejaCheck(tibula['ejaLinkingField']) and not ejaCheck(tibula['ejaModuleName'],"ejaFiles") then t=2 end 
   if ejaCheck(tibula['ejaMatrix']) then t=3 end
   r=r..tibulaXhtmlTable(tibula['ejaSearchList'],t); 
  else 
   tibulaReset();
   tibula['ejaActionType']="Search"; 
   tibulaInfo("ejaSearchEmpty");
  end
 end
 
 if not ejaCheck(tibula['ejaActionType'],"List") and ejaCheck(tibula['ejaFields']) then 
  for k,v in pairs(tibula['ejaFields']) do
   r=r..tibulaXhtmlField(v['name'],v['type'],v['value'],v['values'])
  end
 end
 
 if ejaCheck(tibula['ejaAction'],"help") then 
  r=tibulaXhtmlHelp(tibula['ejaActionType'],tibula['ejaModuleId'],tibula['ejaLanguage']); 
 end
 
 r=ejaSprintf('<div id="ejaModule" class="ejaModule%s">%s</div>',tibulaUCFirst(moduleName),r);

 return r;
end


function tibulaXhtmlCommand(moduleId) 	--return the html list of enabled commands for this module
 local r="";
 local command="";
 
 for k,v in ipairs(tibulaSqlCommandArray(tibula['ejaOwner'],moduleId,tibula['ejaActionType'])) do
  command=ejaSprintf(' <input id="ejaCommand%s" type="submit" name="ejaAction[%s]" value="%s"/>',tibulaUCFirst(v),v,tibulaTranslate(v));
  if not ejaCheck(tibula['ejaSqlQuery64']) and ejaCheck(v,"list") then command=""; end
  if ejaCheck(tibula['ejaSearchStep']) then 
   if not ejaCheck(tibula['ejaSqlLimit']) and ejaCheck(v,"previous") then command=""; end
   if ejaCheck(tibula['ejaSqlLimit']) and not ejaCheck(tibula['ejaSearchStep'],tibula['ejaSqlCount']) and ejaCheck(v,"next") then command=""; end
  end
  if not ejaCheck(tibula['ejaLinking']) and ( ejaCheck(v,"link") or ejaCheck(v,"unlink") or ejaCheck(v,"searchLink") or ejaCheck(v,"linkBack") ) then command=""; end
  if ejaCheck(v,"searchLink") then command=""; end
  r=r..command;
 end
 
 r='<div id="ejaCommands">'..r..'</div>'; 
 
 return r;
end


function tibulaXhtmlField(fieldName, fieldType, fieldValue, fieldValueArray) 	--return the xhtml field for name of tType. 
 local r="";

 if ejaCheck(fieldType,"label") then 
  r=r..ejaSprintf('<div class="ejaModule%s">%s</div>',tibulaUCFirst(fieldType),tibulaTranslate(fieldName));
 end 
 
 if ejaCheck(fieldType,"sqlTable") or ( ejaCheck(fieldType,"view") and ejaCheck(fieldValueArray) ) then 
  r=r..ejaSprintf('<fieldset class="ejaModule%s"><legend>%s</legend>%s</fieldset>',tibulaUCFirst(fieldType),tibulaTranslate(fieldName),tibulaXhtmlTable(fieldValueArray,0));
 end 

 if ejaCheck(fieldType,"text") or ejaCheck(fieldType,"password") then
  local value=fieldValue:gsub(".",function(x) return string.format("&#x%X",x:byte()) end)
  r=r..ejaSprintf('<fieldset class="ejaModule%s"><legend>%s</legend><input type="%s" name="ejaValues[%s]" value="%s"/></fieldset>',tibulaUCFirst(fieldType),tibulaTranslate(fieldName),fieldType,fieldName,value);
 end

 if ejaCheck(fieldType,"integer") or ejaCheck(fieldType,"integerRange") or ejaCheck(fieldType,"decimal") then
  if ejaCheck(fieldType,"integerRange") and ejaCheck(tibula['ejaActionType'],"Search") then
   if not ejaCheck(tibula['ejaValues'][fieldName..".begin"]) then tibula['ejaValues'][fieldName..".begin"]=""; end
   if not ejaCheck(tibula['ejaValues'][fieldName..".end"]) then tibula['ejaValues'][fieldName..".end"]=""; end
   r=r..ejaSprintf('<fieldset class="ejaModule%s"><legend>%s</legend>',tibulaUCFirst(fieldType),tibulaTranslate(fieldName));
   r=r..ejaSprintf('<label>%s<input type="text" name="ejaValues[%s.begin]" value="%s"/></label>',tibulaTranslate("ejaIntegerFrom"),fieldName,tibula['ejaValues'][fieldName..".begin"]);  
   r=r..ejaSprintf('<label>%s<input type="text" name="ejaValues[%s.end]" value="%s"/></label>',tibulaTranslate("ejaIntegerTo"),fieldName,tibula['ejaValues'][fieldName..".end"]);  
   r=r..ejaSprintf('</fieldset>');
  else
   if not tibula['ejaValues'][fieldName] then fieldValue=""; else fieldValue=tibula['ejaValues'][fieldName]; end 
   r=r..ejaSprintf('<fieldset class="ejaModule%s"><legend>%s</legend><input type="%s" name="ejaValues[%s]" value="%s"/></fieldset>',string.sub(tibulaUCFirst(fieldType),0,-5),tibulaTranslate(fieldName),fieldType,fieldName,fieldValue);
  end
 end

 if ejaCheck(fieldType,"textArea") or ejaCheck(fieldType,"htmlArea") then
  local class="";
  local title=tibulaTranslate(fieldName);
  if ejaCheck(fieldType,"htmlArea") then 
   class='class="jsEditor"';
   fieldValue=tibulaXhtmlFilter(fieldValue); 
   title=ejaSprintf('%s',tibulaTranslate(fieldName));
  end
  r=r..ejaSprintf('<fieldset class="ejaModule%s"><legend>%s</legend><textarea %s name="ejaValues[%s]">%s</textarea></fieldset>',tibulaUCFirst(fieldType),title,class,fieldName,fieldValue);
 end

 if (string.find("#date#dateRange#time#timeRange#datetime#datetimeRange#",fieldType)) then
  if string.find(fieldType,"Range") and ejaCheck(tibula['ejaActionType'],"Search") then
   if not ejaCheck(tibula['ejaValues'][fieldName..".begin"]) then tibula['ejaValues'][fieldName..".begin"]="" end
   if not ejaCheck(tibula['ejaValues'][fieldName..".end"]) then tibula['ejaValues'][fieldName..".end"]="" end
   r=r..ejaSprintf('<fieldset class="ejaModule%s"><legend>%s</legend>',tibulaUCFirst(fieldType),tibulaTranslate(fieldName));
   r=r..ejaSprintf('<label>%s<input type="text" name="ejaValues[%s.begin]" value="%s" /></label>',tibulaTranslate("ejaDateFrom"),fieldName,tibula['ejaValues'][fieldName..".begin"]);  
   r=r..ejaSprintf('<label>%s<input type="text" name="ejaValues[%s.end]" value="%s" /></label>',tibulaTranslate("ejaDateTo"),fieldName,tibula['ejaValues'][fieldName..".end"]);
   r=r..ejaSprintf('</fieldset>');
  else
   r=r..ejaSprintf('<fieldset class="ejaModule%s"><legend>%s</legend><input type="text" name="ejaValues[%s]" value="%s" /></fieldset>',string.sub(tibulaUCFirst(fieldType),0,-5),tibulaTranslate(fieldName),fieldName,fieldValue);
  end
 end

 if ejaCheck(fieldType,"boolean") then
  if ejaCheck(fieldValue) then options='<option value="1" selected="selected">TRUE</option><option value="0">FALSE</option>'; else options='<option value="1">TRUE</option><option value="0" selected="selected">FALSE</option>'; end
  if ejaCheck(tibula['ejaActionType'],"Search") then options='<option></option><option value="1">TRUE</option><option value="0">FALSE</option>'; end
  r=r..ejaSprintf('<fieldset class="ejaModule%s"><legend>%s</legend><select name="ejaValues[%s]">%s</select></fieldset>',tibulaUCFirst(fieldType),tibulaTranslate(fieldName),fieldName,options);
 end

 if ejaCheck(fieldType,"select") or ejaCheck(fieldType,"sqlMatrix") then
  local options="";
  local selected="";
  for k,v in ipairs(getmetatable(fieldValueArray)) do
   if ejaCheck(fieldValue,v) then selected=' selected="selected"'; else selected=""; end
    options=options..ejaSprintf('<option value="%s"%s>%s</option>',v,selected,fieldValueArray[v]);
  end
  r=r..ejaSprintf('<fieldset class="ejaModule%s"><legend>%s</legend><select name="ejaValues[%s]"><option></option>%s</select></fieldset>',tibulaUCFirst(fieldType),tibulaTranslate(fieldName),fieldName,options);   
 end

 if ejaCheck(fieldType,"sqlValue") then
  r=r..ejaSprintf('<fieldset class="ejaModule%s"><legend>%s</legend><b>%s</b></fieldset>',tibulaUCFirst(fieldType),tibulaTranslate(fieldName),fieldValue); 
 end
 
 if ejaCheck(fieldType,"view") and not ejaCheck(fieldValueArray) then
  r=r..ejaSprintf('<fieldset class="ejaModule%s"><legend>%s</legend>%s&nbsp;</fieldset>',tibulaUCFirst(fieldType),tibulaTranslate(fieldName),fieldValue);
 end
 
 if ejaCheck(fieldType,"hidden") then
  r=r..ejaSprintf('<fieldset class="ejaModule%s"><input type="%s" name="ejaValues[%s]" value="%s"/></fieldset>',tibulaUCFirst(fieldType),fieldType,fieldName,fieldValue);
 end
 
 if ejaCheck(fieldType,"file") then 
  r=r..ejaSprintf('<fieldset class="ejaModule%s"><legend>%s</legend><input type="%s" name="%s" onClick="ejaForm.enctype=\'multipart/form-data\'"/></fieldset>',tibulaUCFirst(fieldType),tibulaTranslate(fieldName),fieldType,fieldName);  
 end
 
 return r;
end


function tibulaXhtmlTable(sqlArray,t) 	--return html table of results for t. t=0 output plain table, t=1 first column is ejaId; t=2 first column ejaId, second powerLink. t=3 each cell is editable, ejaValuesUpdate will be populated with row name, ejaId, and value.
 local r='<table id="ejaTableList" border="1">';
 local value=""
 local ejaIdRow=0;
 local y,x=0,0;
 
 for key,row in pairs (sqlArray) do
  y=y+1;
  
  if (y==1) then
   r=r..'<tr>';
   for k,v in pairs(getmetatable(sqlArray)) do 
    if (k==1 and t>0) then 
     r=r..'<th class="mini"><input type="checkbox" name="ejaIdCheckAll" /></th>'; 
     if (t == 2) then r=r..ejaSprintf('<th class="mini">%s</th>',tibulaTranslate("powerLink")); end
    else 
     if (t == 1 or t == 2) then
      options="<option></option>";
      if ejaCheck(tibula['ejaSearchOrder']) and ejaCheck(tibula['ejaSearchOrder'][v],"ASC") or string.find(tibula['ejaSqlOrder']," "..v.." ASC") then options=options..ejaSprintf('<option value="ASC" selected="selected">AZ</option>'); else options=options..ejaSprintf('<option value="ASC">AZ</option>'); end
      if ejaCheck(tibula['ejaSearchOrder']) and ejaCheck(tibula['ejaSearchOrder'][v],"DESC") or string.find(tibula['ejaSqlOrder']," "..v.." DESC") then options=options..ejaSprintf('<option value="DESC" selected="selected">ZA</option>'); else options=options..ejaSprintf('<option value="DESC">ZA</option>'); end
      r=r..ejaSprintf('<th>%s</th><th class="mini"><select name="ejaSearchOrder[%s]">%s</select></th>',tibulaTranslate(v),v,options); 
     else
      r=r..ejaSprintf('<th colspan="2">%s</th>',tibulaTranslate(v)); 
     end
    end
   end
   r=r..'</tr>';
  end 
  
  r=r..'<tr>';
  x=0;
  for k,v in pairs(getmetatable(sqlArray)) do
   x=x+1;
   if row[v] then value=row[v] else value="" end
   if ejaString(v) == "ejaId" and t > 0 then 
    ejaIdRow=value;
    r=r..ejaSprintf('<td><input type="checkbox" name="ejaId[%d]" value="%d" /></td>',value,value); 
    if t == 2 then
     local sql=tibulaSqlArray('SELECT ejaId,power FROM ejaLinks WHERE srcModuleId=%d AND srcFieldId=%d AND dstModuleId=%d AND dstFieldId=%d;',tibula['ejaModuleId'],value,tibula['ejaLinkModuleId'],tibula['ejaLinkFieldId']);
     if not ejaCheck(sql) then 
      sql={}
      sql['ejaId']=0; 
      sql['power']=0;
     end
     r=r..ejaSprintf('<td class="powerLink"><input type="text" name="ejaLinkPower[%d][%d]" value="%d" onClick="ejaIdCheck(%d)"/></td>',value,sql['ejaId'],sql['power'],value);
    end
   else 
    if t == 3 then
     r=r..ejaSprintf('<td class="powerLink" colspan="2"><input type="text" name="ejaValues[%s.%d]" value="%s"/></td>',v,ejaIdRow,value); 
    else
     r=r..ejaSprintf('<td colspan="2">%s</td>',value); 
    end
   end
  end
  r=r..'</tr>';
  
 end
 
 if ejaCheck(tibula['ejaSqlCountTotal']) then
  r=r..ejaSprintf('<tr><th colspan="%d">%d-%d / %d</th></tr>',(x*2),tibula['ejaSqlLimit']+1,(tibula['ejaSqlLimit']+tibula['ejaSqlCount']),tibula['ejaSqlCountTotal']);
 end
 
 r=r..'</table>';
 
 return r;
end


function tibulaXhtmlHelp(actionType, moduleId, language) 	--return xml help for selected moduleId/language 
 local r="";
 
 r=tibulaSqlRun("SELECT text FROM ejaHelps WHERE (ejaModuleId=0 OR ejaModuleId=%d) AND (actionType='%s' OR actionType='') AND ejaLanguage='%s' ORDER BY actionType DESC, ejaModuleId DESC LIMIT 1;",moduleId,actionType,language) or "";
 return ejaSprintf('<div id="ejaModuleHelps">%s</div>',r); 
end

function tibulaXhtmlInfo() 	--return an alert/info box
 local r="";
 local info="";
 
 if ejaCheck(tibula['ejaActionType']) and ejaCheck(tibula['ejaAction']) then info="alert"..tibula['ejaActionType']..tibulaUCFirst(tibula['ejaAction']) end
 r=ejaSprintf('<div id="ejaInfo">%s</div>',tibulaInfo(info)); 

 return r;
end


function tibulaXhtmlFilter(value) 
 
 value=string.gsub(value,"&","&amp;")
 value=string.gsub(value,"'","&#039;")
 value=string.gsub(value,"\"","&quot;")
 value=string.gsub(value,"<","&lt;")
 value=string.gsub(value,">","&gt;")
    
 return value
end


