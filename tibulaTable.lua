-- Copyright (C) 2007-2021 by Ubaldo Porcheddu <ubaldo@eja.it>
--
-- Polonaise héroïque


function tibulaTableStart()	--set default tibula table value
 tibula={};
 tibula.ejaDefaultLanguage="en";
 tibula.ejaDefaultSearchStep=15;
 tibula.ejaDefaultSearchOrder="ejaLog DESC";
 tibula.ejaCommandArray={};
 tibula.ejaHttpHeader={};
 tibula.ejaSqlType=tibulaSqlType;
 tibula.ejaLanguage=tibula.ejaLanguage or tibula.ejaDefaultLanguage;
 tibula.path=eja.opt.tibulaPath or eja.pathVar..'/tibula/';
end


function tibulaTableImport(a)	--import data into tibula table
 for key,value in next,a do
  if type(value) ~= "table" then 
   key=ejaUrlDecode(key);
   value=ejaUrlDecode(value); 
  else
   key=ejaString(key);
   value=ejaString(value);
  end

  if key == "ejaId" then tibula[key]=value;  end
  if key == "ejaAction" then tibula[key]=value; end
  if key == "ejaSession" then tibula[key]=value; end
  if key == "ejaModuleId" then tibula[key]=value; end
  if key == "ejaLanguage" then tibula[key]=value; end
  if key == "ejaLinkPower" then tibula[key]=value; end
  if key == "ejaModuleName" then tibula[key]=value; end
  if key == "ejaSearchStep" then tibula[key]=value; end
  if key == "ejaModuleLink" then tibula[key]=value; end
  if key == "ejaSearchLimit" then tibula[key]=value; end
  if key == "ejaModuleChange" then tibula[key]=value; end
  if key == "ejaModuleLinkBack" then tibula[key]=value; end
  if key == "ejaOut" then --xhtml/xml/json
   tibula.ejaOut=value; 
   if ejaString(value) == "json" then tibula.ejaOutSession=0; end
  end
  if key == "ejaOutSession"	then tibula[key]=value; end

  check=key:match('^ejaAction%[(.-)%]$')
  if  check then tibula.ejaAction=check end 
  if key == "ejaAction" then tibula.ejaAction=value; end

  if key:match("^ejaId%[") then
   if not tibula.ejaIdArray then tibula.ejaIdArray={}; end
   if ejaNumber(tibula.ejaId) < 1 then tibula.ejaId=value; end
   table.insert(tibula.ejaIdArray, value);
  end 
  if key == "ejaId" and type(value) == 'table' then 
   tibula.ejaIdArray=value; 
   if ejaNumber(tibula.ejaId) < 1 then _,tibula.ejaId=next(value); end   
  end  

  k,v=key:match("^ejaLinkPower%[(.-)%]%[(.-)%]$");
  if k and v then
   if type(tibula.ejaLinkPower) ~= "table" then tibula.ejaLinkPower={}; end
   tibula.ejaLinkPower[k]=v.."."..value;
  end
  if key == "ejaLinkPower" and type(value) == 'table' then tibula.ejaLinkPower=value; end
  
  check=key:match('^ejaSearchOrder%[(.-)%]$')
  if check and ejaString(value) ~= "" then
   if type(tibula.ejaSearchOrder) ~= "table" then tibula.ejaSearchOrder={}; end
   tibula.ejaSearchOrder[check]=value; 
  end 
  if key == "ejaSearchOrder" and type(value) == 'table' then tibula.ejaSearchOrder=value; end
  
  check=key:match('^ejaValues%[(.-)%]$');
  if check then 
   if type(tibula.ejaValues) ~= "table" then tibula.ejaValues={}; end
   k,v=check:match('^(.-)%]%[(.-)$');
   if k and v then 
    tibula.ejaValues[k]=v.."."..value;
   else 
    k,v=check:match('^(.-)%.(.-)$');
    if k and v then
     tibula.ejaValues[check]=value;
     if ejaString(value) ~= "" then tibula.ejaValues[k]=value; end
    else
     tibula.ejaValues[check]=value;
    end
   end
  end
  if key == "ejaValues" and type(value) == 'table' then tibula.ejaValues=value; end
  
  if ejaNumber(tibula.ejaId) == 0 and tibula.ejaValues and tibula.ejaValues.ejaId then
   tibula.ejaId=tibula.ejaValues.ejaId;
  end

 end 
end


function tibulaTableRun(web)	--main tibula engine 
 if ejaString(tibula.ejaModuleName) ~= "" then tibula.ejaModuleId=tibulaSqlModuleGetIdByName(tibula.ejaModuleName); end
 if ejaNumber(tibula.ejaModuleId) < 1 then tibula.ejaModuleId=tibulaSqlModuleGetIdByName("eja"); end
 if ejaNumber(tibula.ejaModuleId) < 1 then tibula.ejaModuleId=1; end
 tibula.ejaModuleId=ejaNumber(tibula.ejaModuleId);
 tibula.ejaId=ejaNumber(tibula.ejaId);
 tibula.ejaValues=ejaTable(tibula.ejaValues)
 if not tibula.ejaIdArray and tibula.ejaId > 0 then 
  tibula.ejaIdArray=ejaTable(); 
  table.insert(tibula.ejaIdArray, tibula.ejaId);
 end
 if not tibula.ejaOut then tibula.ejaOut="xhtml"; end
 if not tibula.ejaOutSession then tibula.ejaOutSession=1; end

 --login, set a random session value and retrieve defaultModuleId 
 if ejaString(tibula.ejaAction) == "login" and ejaString(tibula.ejaValues.username) ~= "" and ejaString(tibula.ejaValues.password) ~= "" then 
  tibulaTableOwnerReset(tibulaSqlUserGetIdByUserAndPass(tibula.ejaValues.username, tibula.ejaValues.password));
 elseif ejaString(tibula.ejaValues.googleAuthToken) ~= "" then
  local googleAuth=ejaTable(ejaJsonDecode(ejaString(ejaWebGet("https://oauth2.googleapis.com/tokeninfo?id_token="..tibula.ejaValues.googleAuthToken))));
  if googleAuth.email then
   tibulaTableOwnerReset(tibulaSqlUserGetIdByUsername(googleAuth.email));
  end
 end  

 --Session managment
 if ejaString(tibula.ejaSession) ~= "" then
  --set ejaOwner
  local user=tibulaSqlUserGetAllBySession(tibula.ejaSession);
  if ejaTableCount(user) > 0 then
   tibula.ejaOwner=ejaNumber(user.ejaId);
   --set ejaLanguage
   if user.ejaLanguage then tibula.ejaLanguage=ejaString(user.ejaLanguage); end
   --fill tibula from ejaSessions
   if ejaNumber(tibula.ejaOwner) > 0 and ejaNumber(tibula.ejaOutSession) == 1 and ejaString(tibula.ejaAction) ~= "csvExport" and ejaString(tibula.ejaAction) ~= "xmlExport" then 
    tibulaSqlSessionRead(tibula.ejaOwner); 
   end 
  --fill eja with the list and the array of other owners data enabled views
   tibula.ejaOwnerList=tibulaSqlOwnerList(tibula.ejaOwner);
   tibula.ejaOwners=ejaTable(tibula.ejaOwners);
   for v in string.gmatch(tibula.ejaOwnerList, "%d+") do tibula.ejaOwners[v]=v; end 
  else 
   tibula.ejaOwner=0;
  end
 else 
  tibula.ejaOwner=0;
 end 
 
 --Security checks
 if ejaString(tibula.ejaAction) =="logout" then
  --logout 
  if ejaNumber(tibula.ejaOwner) > 0 then tibulaSqlUserSessionReset(tibula.ejaOwner); end
  tibula.ejaSession="";
  tibula.ejaOwner=0;   
  tibulaReset();
  tibula.ejaLinkHistory={};
  tibula.ejaLinkModuleId=0;
  tibula.ejaLinkFieldId=0; 
 end
 
 -- ejaSession semaphore
 if ejaNumber(tibula.ejaOwner) < 1 then 
  tibula.ejaModuleId=tibulaSqlModuleGetIdByName('ejaLogin');
  tibula.ejaModuleName="ejaLogin";
  tibula.ejaLanguage=tibula.ejaDefaultLanguage;
  tibula.ejaSession="";
  tibulaInfo("ejaNotAuthorized");
  
 else 	-- authorized
 
  --Module selection 
  if ejaString(tibula.ejaAction) == "query" then tibula.ejaModuleChange=tibula.ejaModuleId; end
  if ejaNumber(tibula.ejaModuleChange) > 0 then								--if changing module reset sql order,limit,query..
   if tibula.ejaLinkHistory and tibula.ejaModuleChange == 35248 then tibulaLinkHistory(0, 0); end	--force ejaLinkHistory reset if on root module
   tibula.ejaModuleId=tibula.ejaModuleChange;
   tibulaReset();   
  end

  --Linking managment
  if ejaString(tibula.ejaModuleLink) ~= "" and ejaNumber(tibula.ejaModuleChange) > 0 then		--link begin
   tibula.ejaModuleId=tibula.ejaModuleChange;
   tibulaLinkHistory(tibula.ejaModuleLink:match('([%d]*)%.([%d]*)'));					--add to ejaLinkHistory
   tibula.ejaAction="searchLink";
   table.insert(tibula.ejaCommandArray, "searchLink");
  end
  --linking back
  if ejaNumber(tibula.ejaModuleLinkBack) > 0 and ejaTableCount(tibula.ejaLinkHistory) > 0 then		--link back
   tibulaReset();
   tibula.ejaId=ejaNumber(tibula.ejaLinkHistory[tibula.ejaModuleLinkBack]);
   tibula.ejaModuleId=tibula.ejaModuleLinkBack;
   tibula.ejaAction="edit";
   tibulaLinkHistory(tibula.ejaModuleId, 0);								--reset this ejaLinkHistory
  end
  --linking history
  if ejaTableCount(tibula.ejaLinkHistory) > 0 then							--if linking check link type 
   for k,v in next,tibula.ejaLinkHistory do
    if ejaNumber(k) > 0 then
     tibula.ejaLinkModuleId=k;
     tibula.ejaLinkFieldId=v;
    end
   end
   if ejaNumber(tibula.ejaId) < 1 then tibula.ejaLinking=1; end
   if ejaNumber(tibula.ejaLinkModuleId) > 0 then tibula.ejaLinkingField=tibulaSqlModuleLinkGetSrcField(tibula.ejaLinkModuleId, tibula.ejaModuleId); end
  end   

  --Fill or update ejaModuleName
  if ejaNumber(tibula.ejaModuleId) > 0 then tibula.ejaModuleName=tibulaSqlModuleGetNameById(tibula.ejaModuleId) or 'eja'; end
   
  --Fill ejaCommands
  tibula.ejaCommands={};
  for k,v in next,tibulaSqlCommandArray(tibula.ejaOwner, tibula.ejaModuleId, "") do 
   tibula.ejaCommands[v]=k; 
  end

  --run lua script for this ejaModuleId and save tibula into ejaSessions
  tibulaModuleLua(0, web);
  tibulaSqlSessionWrite(tibula.ejaOwner, tibula);

  --Actions engine, runs only if ejaAction is in ejaSqlCommandList
  if ejaString(tibula.ejaAction) ~= "" and ejaString(tibula.ejaCommands[tibula.ejaAction]) ~= "" then

   --update matrix
   if ejaString(tibula.ejaAction) == "update" then
    tibula.ejaMatrix=1;
    tibula.ejaAction="search"; 
    if ejaNumber(tibula.ejaId) > 0 then 
     local validFields={};
     for k,v in next,tibulaSqlFieldsMatrix(tibula.ejaModuleId, "Matrix") do
      if v.name and ejaString(v.type) == "matrix" then 
       for kk,vv in next,tibula.ejaIdArray do
        if tibula.ejaValues[v.name.."."..vv] then
         tibulaSqlTableUpdateById(tibula.ejaModuleName, v.name, tibula.ejaValues[v.name.."."..vv], vv, tibula.ejaOwnerList);
        end
       end
      end
     end
    end 
   end
 
   --link and unlink
   if (ejaString(tibula.ejaAction) == "link" or ejaString(tibula.ejaAction) == "unlink") and ejaTableCount(tibula.ejaIdArray) > 0 then
    for k,v in next,tibula.ejaIdArray do
     local linkPower=0;
     local linkId=0;
     if ejaString(v) ~= "" and tibula.ejaLinkPower[v] then
      linkId,linkPower=tibula.ejaLinkPower[v]:match('(%d+)%.(%d+)');
      if ejaString(tibula.ejaAction) == "link" then 
       if ejaNumber(linkPower) < 1 then linkPower=1; end
       if ejaNumber(linkId) > 0 then
        tibulaSqlLinkSetPower(linkPower, linkId, tibula.ejaOwnerList); 
       else 
        tibulaSqlLinkAdd(tibula.ejaOwner, tibula.ejaModuleId, v, tibula.ejaLinkModuleId, tibula.ejaLinkFieldId, linkPower);
       end
      end
     if ejaString(tibula.ejaAction) == "unlink" then tibulaSqlLinkDel(linkId, tibula.ejaOwnerList); end
     end
    end 
    tibula.ejaAction="searchLink";  
    tibula.ejaLinking=2; 
   end 

   --edit and view
   if ejaNumber(tibula.ejaId) > 0 and (ejaString(tibula.ejaAction) == "edit") or ejaString(tibula.ejaAction) == "view" then 
    tibula.ejaValues=tibulaSqlTableGetAllById(tibula.ejaModuleName, tibula.ejaId);
   end
  
   --new and copy
   if ejaString(tibula.ejaAction) == "new" or ejaString(tibula.ejaAction) == "copy" then
    local ejaIdCopy=tibula.ejaId;   
    tibula.ejaId=tibulaSqlTableNew(tibula.ejaModuleName, tibula.ejaOwner);
    if ejaString(tibula.ejaAction) == "copy" then --copy ejaLinks
     tibulaSqlLinkCopy(tibula.ejaOwner, tibula.ejaId, tibula.ejaModuleId, ejaIdCopy);
     tibula.ejaLinkFieldId=tibula.ejaId;
    end 
   end

   --save and copy (must be after "new" for "copy" to work). update data also if ejaAction=new and we are in batch mode (xml) 
   if ejaTableCount(tibula.ejaValues) > 0 and ( 
    (ejaString(tibula.ejaAction) == "save" or ejaString(tibula.ejaAction) == "copy") or 
    (ejaNumber(tibula.ejaOutSession) == 0 and ejaString(tibula.ejaAction) == "new") or 
    (ejaString(tibula.ejaAction) == "searchLink" and ejaNumber(tibula.ejaId) > 0) 
   ) then
    if ejaString(tibula.ejaModuleName) == "ejaModules" and (tibula.ejaAction == "save" or (ejaNumber(tibula.ejaOutSession) == 0 and tibula.ejaAction =="new")) then	-- create table on database and add permissions
     if ejaNumber(tibula.ejaValues.sqlCreated) > 0 then
      local tableCreate=tibulaSqlTableCreate(tibula.ejaValues.name);  
      if ejaNumber(tableCreate) > 0 then tibulaInfo("ejaSqlModuleCreated"); end
      if ejaNumber(tableCreate) < 0 then tibulaInfo("ejaSqlModuleNotCreated"); end
     end
     if tibulaSqlPermissionCount(tibula.ejaId) == 0 then
      if ejaNumber(tibula.ejaValues.sqlCreated) > 0 then
       tibulaSqlPermissionAddDefault(tibula.ejaOwner, tibula.ejaId);
       tibulaInfo("ejaModuleSqlPermissionsCreated");
      else
       tibulaSqlPermissionAdd(tibula.ejaOwner, tibula.ejaId, 'logout');
       tibulaInfo("ejaModuleContainerPermissionsCreated");
      end
      tibulaSqlUserPermissionCopy(tibula.ejaOwner, tibula.ejaId);
     end
    end
    if ejaNumber(tibula.ejaId) < 1 then 
     tibula.ejaId=tibulaSqlTableNew(tibula.ejaModuleName, tibula.ejaOwner);
    else    
     if ejaNumber(tibulaSqlTableGetAllById(tibula.ejaModuleName, tibula.ejaId).ejaId) < 1 then
      tibulaSqlTableNew(tibula.ejaModuleName, tibula.ejaId, tibula.ejaOwner);
     end 
    end
    for k,v in next,tibula.ejaValues do
     local t=tibulaSqlFieldType(tibula.ejaModuleId, k);
     if t then 
      if string.find("#date#dateRange#time#timeRange#datetime#datetimeRange#", t) then v=tibulaDateSet(v, t); end
      if t == "password" and string.len(v) ~= 64 then v=ejaSha256(v); end
     end
     tibulaSqlTableUpdateById(tibula.ejaModuleName, k, v, tibula.ejaId, tibula.ejaOwnerList);
    end
    tibula.ejaValues=tibulaSqlTableGetAllById(tibula.ejaModuleName, tibula.ejaId);
    
    --create table column
    if ejaString(tibula.ejaModuleName) == "ejaFields" and ejaString(tibula.ejaValues.name) ~= "" and ejaString(tibula.ejaValues.type) ~= "" and ejaNumber(tibula.ejaValues.ejaModuleId) > 0 then
     local fieldCreate=tibulaSqlTableColumnCreate(tibulaSqlModuleGetNameById(tibula.ejaValues.ejaModuleId), tibula.ejaValues.name, tibula.ejaValues.type);
     if ejaNumber(fieldCreate) > 0 then tibulaInfo("ejaSqlFieldCreated"); end
     if ejaNumber(fieldCreate) < 0 then tibulaInfo("ejaSqlFieldNotCreated"); end
    end
    
   end

   --delete
   if ejaString(tibula.ejaAction) == "delete" and ejaTableCount(tibula.ejaIdArray) > 0 then
    for k,v in next,tibula.ejaIdArray do 
     if ejaString(tibula.ejaModuleName) == "ejaModules" then	
      if tibulaSqlModuleDel(v, tibula.ejaOwnerList) then
       tibulaInfo("ejaSqlModuleDeleteTrue");
      else
       tibulaInfo("ejaSqlModuleDeleteFalse");
      end
     end
     tibulaSqlTableDelete(tibula.ejaModuleName, v, tibula.ejaOwnerList);
    end
    tibula.ejaAction="search";
   end 

   --search engine
   if ejaString(tibula.ejaAction) == "searchLink" then tibulaReset(); end
   if string.find("#search#previous#next#list#searchLink#csvExport#xmlExport#", ejaString(tibula.ejaAction)) then
    local sql="";
    local sqlType={};
    tibula.ejaActionType="List";
    --check ejaSearchStep (how many rows per page) and ejaSearchLimit (row limit begin)
    if ejaNumber(tibula.ejaSearchStep) < 1 then tibula.ejaSearchStep=ejaNumber(tibulaSqlTableGetAllById('ejaModules', tibula.ejaModuleId).searchLimit); end
    if ejaNumber(tibula.ejaSearchStep) < 1 then tibula.ejaSearchStep=tibula.ejaDefaultSearchStep; end
    if ejaNumber(tibula.ejaSearchLimit) > 0 then tibula.ejaSqlLimit=tibula.ejaSearchLimit; end
    if ejaNumber(tibula.ejaSqlLimit) < 1 then tibula.ejaSqlLimit=0; end
    --previous and next
    if ejaString(tibula.ejaAction) == "previous" then tibula.ejaSqlLimit=tibula.ejaSqlLimit-tibula.ejaSearchStep; end
    if ejaString(tibula.ejaAction) == "next" then tibula.ejaSqlLimit=tibula.ejaSqlLimit+tibula.ejaSearchStep; end
    --query construction
    if ejaString(tibula.ejaSqlQuery64) ~= "" then 
     sql=ejaBase64Decode(tibula.ejaSqlQuery64);
    else
     sql=tibulaSqlSearchQuery(tibula.ejaModuleName, tibula.ejaValues, tibula.ejaOwnerList);
     --if linking restrict search to active links. If srcFieldName is present in ejaModuleLinks use this to restrict search.
     if ejaString(tibula.ejaAction) == "searchLink" then
       sql=sql..tibulaSqlSearchQueryLink(tibula.ejaModuleName, tibula.ejaLinkingField, tibula.ejaLinkFieldId, tibula.ejaLinkModuleId, tibula.ejaOwnerList);
     end
     tibula.ejaSqlQuery64=ejaBase64Encode(sql);
    end
    --limit and order stuff
    if ejaString(tibula.ejaSqlLimit) == "" then tibula.ejaSqlLimit=0; end
    if ejaTableCount(tibula.ejaSearchOrder) > 0 then
     tibula.ejaSqlOrder="";
     for k,v in next,tibula.ejaSearchOrder do 
      if v then tibula.ejaSqlOrder=tibula.ejaSqlOrder..", "..k.." "..v; end
     end
     if ejaString(tibula.ejaSqlOrder) ~= "" then tibula.ejaSqlOrder=string.sub(tibula.ejaSqlOrder, 2); end
    end 
    if ejaString(tibula.ejaSqlOrder) == "" then 
     tibula.ejaSqlOrder=tibulaSqlTableGetAllById('ejaModules', tibula.ejaModuleId).sortList;
     if ejaString(tibula.ejaSqlOrder) == "" then tibula.ejaSqlOrder=tibula.ejaDefaultSearchOrder; end
    end
    --finish query construction
    tibula.ejaSqlQueryRaw=sql;
    tibula.ejaSqlQuery=sql..tibulaSqlSearchQueryOrderAndLimit(tibula.ejaSqlOrder, tibula.ejaSqlLimit, tibula.ejaSearchStep);
    tibula.ejaId=0;
   end

  end 
 end 


 --Define ejaActionType and populate fields/result matrix
 if ejaString(tibula.ejaActionType) == "List" then 
  tibula.ejaSearchList=tibulaSqlSearchMatrix(tibula.ejaSqlQuery, tibula.ejaModuleId); 
 else
   if ejaNumber(tibula.ejaId) > 0 then 
    tibula.ejaActionType="Edit";
   else 
    tibula.ejaActionType="Search";
   end
  tibula.ejaFields=tibulaSqlFieldsMatrix(tibula.ejaModuleId, tibula.ejaActionType);
 end
  
 -- lua module script last call.
 tibulaModuleLua(1, web);
end


function tibulaTableExport()
 local data=""
  
 if ejaString(tibula.ejaOut) == "json" then 
  data=tibulaJsonExport(tibula.ejaModuleId); 
 else --xhtml
  data=tibulaXhtmlExport(tibula.ejaModuleId);
 end

 return data;
end 


function tibulaTableOwnerReset(ownerId)
 if ejaNumber(ownerId) > 0 then
  tibula.ejaOwner=ejaNumber(ownerId);
  tibulaSqlSessionResetByUserId(tibula.ejaOwner);
  tibulaSqlUserSessionUpdate(tibulaSessionCode(), tibula.ejaOwner);
  local row=tibulaSqlUserGetAllById(tibula.ejaOwner);
  tibula.ejaSession=ejaString(row.ejaSession);
  tibula.ejaModuleId=ejaNumber(row.defaultModuleId);
  return true;
 else
  return false;
 end
end


function tibulaTableStop()
 if ejaNumber(tibula.ejaOutSession) < 1 then
  tibulaSqlSessionWrite(tibula.ejaOwner, {});
 else
  --Update ejaSession
  local ejaBkp={};
  ejaBkp.ejaSqlQuery64=tibula.ejaSqlQuery64;
  ejaBkp.ejaLinkHistory=tibula.ejaLinkHistory;
  ejaBkp.ejaSqlLimit=tibula.ejaSqlLimit;
  ejaBkp.ejaSqlOrder=tibula.ejaSqlOrder; 
  tibulaSqlSessionWrite(tibula.ejaOwner, ejaBkp);
  ejaBkp="";
 end
 tibula={};
end
