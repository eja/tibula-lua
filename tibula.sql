BEGIN;
CREATE TABLE ejaCommands (
  ejaId integer NOT NULL primary key,
  ejaOwner integer default 0,
  ejaLog datetime default NULL,
  name varchar(32) default NULL,
  powerSearch integer default 0,
  powerList integer default 0,
  powerEdit integer default 0,
  defaultCommand integer default 0,
  linking integer default 0
);
ALTER TABLE ejaCommands CHANGE ejaId ejaId integer AUTO_INCREMENT;
INSERT INTO ejaCommands VALUES(1,1,'0000-00-00 00:00:00','login',1,1,1,0,0);
INSERT INTO ejaCommands VALUES(2,1,'0000-00-00 00:00:00','logout',50,50,50,1,0);
INSERT INTO ejaCommands VALUES(3,1,'0000-00-00 00:00:00','new',2,2,0,1,1);
INSERT INTO ejaCommands VALUES(4,1,'0000-00-00 00:00:00','edit',0,2,0,1,1);
INSERT INTO ejaCommands VALUES(5,1,'0000-00-00 00:00:00','previous',0,1,0,1,1);
INSERT INTO ejaCommands VALUES(6,1,'0000-00-00 00:00:00','next',0,100,0,1,1);
INSERT INTO ejaCommands VALUES(7,1,'0000-00-00 00:00:00','search',1,4,0,1,1);
INSERT INTO ejaCommands VALUES(8,1,'0000-00-00 00:00:00','save',0,0,2,1,1);
INSERT INTO ejaCommands VALUES(9,1,'0000-00-00 00:00:00','copy',0,0,3,1,0);
INSERT INTO ejaCommands VALUES(10,1,'0000-00-00 00:00:00','list',0,0,1,1,1);
INSERT INTO ejaCommands VALUES(11,1,'0000-00-00 00:00:00','delete',0,7,7,1,0);
INSERT INTO ejaCommands VALUES(12,1,'0000-00-00 00:00:00','help',8,8,8,1,0);
INSERT INTO ejaCommands VALUES(13,1,'0000-00-00 00:00:00','run',2,2,2,0,0);
INSERT INTO ejaCommands VALUES(14,1,'0000-00-00 00:00:00','link',0,3,3,0,1);
INSERT INTO ejaCommands VALUES(15,1,'0000-00-00 00:00:00','unlink',0,6,0,0,1);
INSERT INTO ejaCommands VALUES(17,1,'2007-09-02 20:34:49','download',0,2,2,0,1);
INSERT INTO ejaCommands VALUES(23,1,'2007-09-05 17:22:42','csvExport',2,0,0,0,0);
INSERT INTO ejaCommands VALUES(27,1,'2007-09-13 19:15:58','view',0,1,0,1,1);
INSERT INTO ejaCommands VALUES(29,1,'2007-10-25 16:52:37','xmlExport',10,0,0,0,0);
INSERT INTO ejaCommands VALUES(30,1,'2008-02-20 12:53:14','update',0,2,0,0,0);
INSERT INTO ejaCommands VALUES(32,1,'2008-03-03 16:34:58','runList',0,2,0,0,0);
INSERT INTO ejaCommands VALUES(33,1,'2008-03-03 16:35:16','runSearch',2,0,0,0,0);
INSERT INTO ejaCommands VALUES(34,1,'2008-03-03 16:35:27','runEdit',0,0,2,0,0);
INSERT INTO ejaCommands VALUES(35,1,'2008-05-08 12:06:41','fileZip',0,7,0,0,1);
INSERT INTO ejaCommands VALUES(36,1,'2008-05-08 12:07:05','fileUnzip',0,7,0,0,1);
CREATE TABLE ejaFields (
  ejaId integer NOT NULL primary key,
  ejaOwner integer default 0,
  ejaLog datetime default NULL,
  ejaModuleId integer default 0,
  name varchar(32) default NULL,
  type varchar(32) default NULL,
  value mediumtext,
  powerSearch integer default 0,
  powerList integer default 0,
  powerEdit integer default 0,
  translate integer default 0,
  ejaGroup text,
  matrixUpdate integer default 0
);
ALTER TABLE ejaFields CHANGE ejaId ejaId integer AUTO_INCREMENT;
INSERT INTO ejaFields VALUES(1,1,'0000-00-00 00:00:00',6,'name','text','',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(2,1,'0000-00-00 00:00:00',6,'type','select','boolean
date
dateRange
datetime
datetimeRange
decimal
file
hidden
htmlArea
integer
integerRange
label
password
select
sqlHidden
sqlMatrix
sqlTable
sqlValue
text
textArea
time
timeRange
view
',2,2,2,0,'',0);
INSERT INTO ejaFields VALUES(3,1,'0000-00-00 00:00:00',6,'value','textArea','',0,0,20,0,'',0);
INSERT INTO ejaFields VALUES(5,1,'0000-00-00 00:00:00',6,'powerList','integer','',0,0,7,0,'',0);
INSERT INTO ejaFields VALUES(6,1,'0000-00-00 00:00:00',6,'powerEdit','integer','',0,0,8,0,'',0);
INSERT INTO ejaFields VALUES(20,1,'2007-08-14 17:08:48',6,'powerSearch','integer','',0,0,6,0,'',0);
INSERT INTO ejaFields VALUES(21,1,'2007-08-14 17:25:52',6,'ejaModuleId','sqlMatrix','SELECT ejaId,name FROM ejaModules ORDER BY name;',3,2,2,0,'',0);
INSERT INTO ejaFields VALUES(22,1,'2007-08-16 15:20:12',5,'parentId','sqlMatrix','SELECT ejaId,name FROM ejaModules ORDER BY name;',2,2,2,0,'',0);
INSERT INTO ejaFields VALUES(23,1,'2007-08-16 15:20:59',5,'name','text','',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(24,1,'2007-08-16 15:23:17',5,'power','integer','',0,3,3,0,'',0);
INSERT INTO ejaFields VALUES(27,1,'2007-08-17 12:53:25',5,'sqlCreated','boolean','',0,0,7,0,'',0);
INSERT INTO ejaFields VALUES(28,1,'2007-08-31 16:53:43',14,'name','text','',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(30,1,'2007-08-31 17:16:27',14,'note','textArea','',0,0,2,0,'',0);
INSERT INTO ejaFields VALUES(31,1,'2007-08-31 17:18:33',13,'srcModuleId','sqlMatrix','SELECT ejaId,name FROM ejaModules ORDER BY name;',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(32,1,'2007-08-31 17:18:53',13,'srcFieldId','integer','',0,2,2,0,'',0);
INSERT INTO ejaFields VALUES(33,1,'2007-08-31 17:19:21',13,'dstFieldId','integer','',0,4,4,0,'',0);
INSERT INTO ejaFields VALUES(34,1,'2007-08-31 17:19:34',13,'dstModuleId','sqlMatrix','SELECT ejaId,name FROM ejaModules ORDER BY name;',3,3,3,0,'',0);
INSERT INTO ejaFields VALUES(35,1,'2007-08-31 17:19:43',13,'power','integer','',0,5,5,0,'',0);
INSERT INTO ejaFields VALUES(36,1,'2007-08-31 19:04:07',15,'username','text','',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(37,1,'2007-08-31 19:05:12',15,'password','password','',0,0,2,0,'',0);
INSERT INTO ejaFields VALUES(38,1,'2007-08-31 19:05:36',15,'defaultModuleId','sqlMatrix','SELECT ejaId,name FROM ejaModules ORDER BY name;',0,0,5,0,'',0);
INSERT INTO ejaFields VALUES(40,1,'2007-09-01 09:10:17',16,'ejaModuleId','sqlMatrix','SELECT ejaId,name FROM ejaModules ORDER BY name;',2,2,2,0,'',0);
INSERT INTO ejaFields VALUES(41,1,'2007-09-01 09:10:38',16,'ejaCommandId','sqlMatrix','SELECT ejaId,name FROM ejaCommands ORDER BY name;',3,3,3,0,'',0);
INSERT INTO ejaFields VALUES(44,1,'2007-09-01 11:22:49',17,'name','text','',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(45,1,'2007-09-01 11:23:30',17,'powerSearch','integer','',0,2,2,0,'',0);
INSERT INTO ejaFields VALUES(46,1,'2007-09-01 11:23:41',17,'powerList','integer','',0,3,3,0,'',0);
INSERT INTO ejaFields VALUES(47,1,'2007-09-01 11:23:49',17,'powerEdit','integer','',0,4,4,0,'',0);
INSERT INTO ejaFields VALUES(48,1,'2007-09-01 12:11:38',6,'translate','boolean','',0,0,5,1,'',0);
INSERT INTO ejaFields VALUES(49,1,'2007-09-01 12:18:03',18,'ejaModuleId','sqlMatrix','SELECT ejaId,name FROM ejaModules ORDER BY name;',2,2,2,0,'',0);
INSERT INTO ejaFields VALUES(51,1,'2007-09-01 12:20:26',18,'ejaLanguage','sqlMatrix','SELECT name,nameFull FROM ejaLanguages ORDER BY nameFull;',3,3,4,0,'',0);
INSERT INTO ejaFields VALUES(52,1,'2007-09-01 12:20:52',18,'word','text','',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(53,1,'2007-09-01 12:21:25',18,'translation','htmlArea','',0,2,5,0,'',0);
INSERT INTO ejaFields VALUES(55,1,'2007-09-02 17:44:56',5,'searchLimit','integer','',0,0,5,0,'',0);
INSERT INTO ejaFields VALUES(56,1,'2007-09-03 19:41:55',20,'ejaModuleId','sqlMatrix','SELECT ejaId,name FROM ejaModules ORDER BY name;',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(57,1,'2007-09-03 19:43:02',20,'actionType','select','Search
Edit',2,2,2,0,'',0);
INSERT INTO ejaFields VALUES(58,1,'2007-09-03 19:46:37',20,'ejaLanguage','sqlMatrix','SELECT name,nameFull FROM ejaLanguages ORDER BY nameFull;',3,3,3,0,'',0);
INSERT INTO ejaFields VALUES(59,1,'2007-09-03 19:46:55',20,'text','htmlArea','',0,0,4,0,'',0);
INSERT INTO ejaFields VALUES(60,1,'2007-09-04 09:47:19',21,'name','text','',1,2,1,0,'',0);
INSERT INTO ejaFields VALUES(61,1,'2007-09-04 09:48:07',21,'value','textArea','',0,4,3,0,'',0);
INSERT INTO ejaFields VALUES(70,1,'2007-09-07 12:52:32',15,'ejaOwner','sqlMatrix','SELECT ejaId,username FROM ejaUsers WHERE (ejaId=@ejaOwner OR ejaOwner IN (SELECT value FROM ejaSessions WHERE name=''ejaOwners'' AND ejaOwner=@ejaOwner)) ORDER BY username;',3,3,3,0,'',0);
INSERT INTO ejaFields VALUES(71,1,'2007-09-07 12:54:44',24,'name','text','',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(72,1,'2007-09-07 12:55:54',24,'nameFull','text','',2,2,2,0,'',0);
INSERT INTO ejaFields VALUES(73,1,'2007-09-07 12:56:14',24,'note','textArea','',0,0,3,0,'',0);
INSERT INTO ejaFields VALUES(74,1,'2007-09-07 13:03:38',15,'ejaLanguage','sqlMatrix','SELECT name,nameFull FROM ejaLanguages ORDER BY nameFull;',0,0,5,0,'',0);
INSERT INTO ejaFields VALUES(75,1,'2007-09-07 13:04:56',21,'ejaOwner','sqlMatrix','SELECT ejaId,username FROM ejaUsers ORDER BY username;',1,1,0,0,'',0);
INSERT INTO ejaFields VALUES(76,1,'2007-09-09 18:07:51',27,'query','textArea','',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(79,1,'2007-09-13 19:19:39',17,'defaultCommand','boolean','',2,5,5,0,'',0);
INSERT INTO ejaFields VALUES(100,1,'2007-09-20 09:24:23',21,'sub','text','',0,3,2,0,'',0);
INSERT INTO ejaFields VALUES(101,1,'2007-09-20 18:25:58',15,'ejaSession','text','',0,0,6,0,'',0);
INSERT INTO ejaFields VALUES(102,1,'2007-09-20 19:24:29',6,'ejaGroup','sqlMatrix','SELECT ejaId,name FROM ejaGroups ORDER BY name',0,0,4,0,'',0);
INSERT INTO ejaFields VALUES(105,1,'2007-10-01 15:59:34',17,'linking','boolean','',0,6,6,0,'',0);
INSERT INTO ejaFields VALUES(106,1,'2007-10-02 09:24:17',34,'dstModuleId','sqlMatrix','SELECT ejaId,name FROM ejaModules ORDER BY name;',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(107,1,'2007-10-02 09:26:01',34,'srcModuleId','sqlMatrix','SELECT ejaId,name FROM ejaModules ORDER BY name;',0,2,2,0,'',0);
INSERT INTO ejaFields VALUES(108,1,'2007-10-02 09:26:28',34,'power','integer','',0,5,5,0,'',0);
INSERT INTO ejaFields VALUES(116,1,'2008-01-17 12:09:16',27,'ejaLog','datetimeRange','',2,2,0,0,'',0);
INSERT INTO ejaFields VALUES(178,1,'2008-02-20 12:51:39',6,'matrixUpdate','boolean','',0,0,9,0,'',0);
INSERT INTO ejaFields VALUES(191,1,'2008-04-08 18:18:02',16,'ejaOwner','sqlMatrix','SELECT ejaId,username FROM ejaUsers WHERE (ejaId=@ejaOwner OR ejaOwner IN (SELECT value FROM ejaSessions WHERE name=''ejaOwners'' AND ejaOwner=@ejaOwner)) ORDER BY username;',0,0,1,0,'',0);
INSERT INTO ejaFields VALUES(193,1,'2008-04-10 17:50:19',19,'fileName','text','',20,5,5,0,'',0);
INSERT INTO ejaFields VALUES(194,1,'2008-04-10 17:51:02',19,'fileData','textArea','',0,0,0,0,'',0);
INSERT INTO ejaFields VALUES(211,1,'2008-06-17 10:52:15',19,'ejaModuleId','integer','',0,0,0,0,'',0);
INSERT INTO ejaFields VALUES(213,1,'2008-06-24 16:10:59',34,'srcFieldName','text','',0,4,4,0,'',0);
INSERT INTO ejaFields VALUES(247,1,'2010-01-07 11:58:58',5,'sortList','sqlMatrix','SELECT name AS value, name AS title FROM ejaFields WHERE ejaModuleId=(SELECT value FROM ejaSessions WHERE ejaSessions.ejaOwner=@ejaOwner AND ejaSessions.name=''ejaId'') ORDER BY name;',0,0,20,0,'',0);
INSERT INTO ejaFields VALUES(248,1,'2010-01-07 12:00:13',5,'lua','textArea','',0,0,100,0,'',0);
INSERT INTO ejaFields VALUES(249,1,'2010-01-07 12:50:49',19,'fileSize','integer','',0,10,0,0,'',0);
INSERT INTO ejaFields VALUES(250,1,'2010-01-07 12:55:25',19,'ejaFieldId','integer','',0,0,0,0,'',0);
INSERT INTO ejaFields VALUES(251,1,'2010-01-07 12:56:17',19,'filePath','sqlMatrix','SELECT filePath AS value, filePath AS title FROM ejaFiles WHERE ejaOwner IN (SELECT value FROM ejaSessions WHERE name=''ejaOwners'' AND ejaOwner=1) AND CASE WHEN (SELECT value FROM ejaSessions WHERE name=''ejaLinkModuleId'' AND ejaOwner=1 LIMIT 1) > 1 THEN ejaModuleId=(SELECT value FROM ejaSessions WHERE name=''ejaLinkModuleId'' AND ejaOwner=1 LIMIT 1) ELSE ejaModuleId > 0 END GROUP BY filePath;',3,3,3,0,'',0);
INSERT INTO ejaFields VALUES(252,1,'2010-01-07 12:57:27',19,'ejaDirectory','text','',0,0,3,0,'',0);
INSERT INTO ejaFields VALUES(257,1,'2010-01-07 14:17:23',1,'username','text','',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(258,1,'2010-01-07 14:18:05',1,'password','password','',2,2,2,0,'',0);
INSERT INTO ejaFields VALUES(259,1,'2010-01-07 15:51:05',19,'ejaFile','file','',0,0,100,0,'',0);
INSERT INTO ejaFields VALUES(260,1,'2010-01-14 14:56:29',19,'ejaOwner','sqlMatrix','SELECT ejaId,username FROM ejaUsers WHERE (ejaId=@ejaOwner OR ejaOwner IN (SELECT value FROM ejaSessions WHERE name=''ejaOwners'' AND ejaOwner=@ejaOwner)) ORDER BY username;',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(261,1,'2010-01-14 16:26:59',21,'ejaLog','datetimeRange','',10,10,10,0,'',0);
CREATE TABLE ejaFiles (
  ejaId integer NOT NULL primary key,
  ejaOwner integer default 0,
  ejaLog datetime default NULL,
  fileName char(255) default NULL,
  fileData blob,
  ejaModuleId integer default 0
, fileSize INTEGER, ejaFieldId INTEGER, filePath TEXT, ejaDirectory CHAR(255), ejaFile CHAR(255)
);
ALTER TABLE ejaFiles CHANGE ejaId ejaId integer AUTO_INCREMENT;
CREATE TABLE ejaGroups (
  ejaId integer NOT NULL primary key,
  ejaOwner integer default 0,
  ejaLog datetime default NULL,
  name varchar(255) default NULL,
  note mediumtext
);
ALTER TABLE ejaGroups CHANGE ejaId ejaId integer AUTO_INCREMENT;
CREATE TABLE ejaHelps (
  ejaId integer NOT NULL primary key,
  ejaOwner integer default 0,
  ejaLog datetime default NULL,
  ejaModuleId text,
  actionType text,
  ejaLanguage text,
  text mediumtext
);
ALTER TABLE ejaHelps CHANGE ejaId ejaId integer AUTO_INCREMENT;
CREATE TABLE ejaLanguages (
  ejaId integer NOT NULL primary key,
  ejaOwner integer default 0,
  ejaLog datetime default NULL,
  nameFull varchar(255) default NULL,
  name varchar(255) default NULL,
  note mediumtext
);
ALTER TABLE ejaLanguages CHANGE ejaId ejaId integer AUTO_INCREMENT;
INSERT INTO ejaLanguages VALUES(1,1,'2007-09-07 13:01:05','italiano','it','');
INSERT INTO ejaLanguages VALUES(2,1,'2007-09-07 13:01:29','english','en','');
INSERT INTO ejaLanguages VALUES(3,1,'2008-03-04 15:48:52','deutsch','de','');
CREATE TABLE ejaLinks (
  ejaId integer NOT NULL primary key,
  ejaOwner integer default 0,
  ejaLog datetime default NULL,
  srcModuleId integer default 0,
  srcFieldId integer default 0,
  dstModuleId integer default 0,
  dstFieldId integer default 0,
  power integer default 0
);
ALTER TABLE ejaLinks CHANGE ejaId ejaId integer AUTO_INCREMENT;
INSERT INTO ejaLinks VALUES(69,1,'2007-09-02 17:30:24',16,119,15,1,1);
INSERT INTO ejaLinks VALUES(70,1,'2007-09-02 17:30:24',16,118,15,1,1);
INSERT INTO ejaLinks VALUES(71,1,'2007-09-02 17:30:24',16,117,15,1,1);
INSERT INTO ejaLinks VALUES(72,1,'2007-09-02 17:30:24',16,116,15,1,1);
INSERT INTO ejaLinks VALUES(73,1,'2007-09-02 17:30:24',16,115,15,1,1);
INSERT INTO ejaLinks VALUES(74,1,'2007-09-02 17:30:24',16,114,15,1,1);
INSERT INTO ejaLinks VALUES(75,1,'2007-09-02 17:30:24',16,113,15,1,1);
INSERT INTO ejaLinks VALUES(76,1,'2007-09-02 17:30:24',16,112,15,1,1);
INSERT INTO ejaLinks VALUES(77,1,'2007-09-02 17:30:24',16,111,15,1,1);
INSERT INTO ejaLinks VALUES(78,1,'2007-09-02 17:30:24',16,110,15,1,1);
INSERT INTO ejaLinks VALUES(81,1,'2007-09-02 17:30:24',16,107,15,1,1);
INSERT INTO ejaLinks VALUES(82,1,'2007-09-02 17:30:24',16,106,15,1,1);
INSERT INTO ejaLinks VALUES(83,1,'2007-09-02 17:30:24',16,105,15,1,1);
INSERT INTO ejaLinks VALUES(84,1,'2007-09-02 17:30:24',16,104,15,1,1);
INSERT INTO ejaLinks VALUES(85,1,'2007-09-02 17:30:24',16,103,15,1,1);
INSERT INTO ejaLinks VALUES(86,1,'2007-09-02 17:30:24',16,102,15,1,1);
INSERT INTO ejaLinks VALUES(87,1,'2007-09-02 17:30:24',16,101,15,1,1);
INSERT INTO ejaLinks VALUES(88,1,'2007-09-02 17:30:24',16,100,15,1,1);
INSERT INTO ejaLinks VALUES(89,1,'2007-09-02 17:30:24',16,99,15,1,1);
INSERT INTO ejaLinks VALUES(90,1,'2007-09-02 17:30:24',16,98,15,1,1);
INSERT INTO ejaLinks VALUES(93,1,'2007-09-02 17:30:24',16,95,15,1,1);
INSERT INTO ejaLinks VALUES(94,1,'2007-09-02 17:30:24',16,94,15,1,1);
INSERT INTO ejaLinks VALUES(95,1,'2007-09-02 17:30:24',16,93,15,1,1);
INSERT INTO ejaLinks VALUES(96,1,'2007-09-02 17:30:24',16,92,15,1,1);
INSERT INTO ejaLinks VALUES(97,1,'2007-09-02 17:30:24',16,91,15,1,1);
INSERT INTO ejaLinks VALUES(98,1,'2007-09-02 17:30:24',16,90,15,1,1);
INSERT INTO ejaLinks VALUES(99,1,'2007-09-02 17:30:24',16,89,15,1,1);
INSERT INTO ejaLinks VALUES(100,1,'2007-09-02 17:30:24',16,88,15,1,1);
INSERT INTO ejaLinks VALUES(101,1,'2007-09-02 17:30:24',16,87,15,1,1);
INSERT INTO ejaLinks VALUES(102,1,'2007-09-02 17:30:24',16,86,15,1,1);
INSERT INTO ejaLinks VALUES(106,1,'2007-09-02 17:30:24',16,81,15,1,1);
INSERT INTO ejaLinks VALUES(107,1,'2007-09-02 17:30:24',16,80,15,1,1);
INSERT INTO ejaLinks VALUES(108,1,'2007-09-02 17:30:24',16,79,15,1,1);
INSERT INTO ejaLinks VALUES(109,1,'2007-09-02 17:30:24',16,78,15,1,1);
INSERT INTO ejaLinks VALUES(110,1,'2007-09-02 17:30:24',16,77,15,1,1);
INSERT INTO ejaLinks VALUES(111,1,'2007-09-02 17:30:24',16,76,15,1,1);
INSERT INTO ejaLinks VALUES(112,1,'2007-09-02 17:30:24',16,75,15,1,1);
INSERT INTO ejaLinks VALUES(113,1,'2007-09-02 17:30:24',16,74,15,1,1);
INSERT INTO ejaLinks VALUES(114,1,'2007-09-02 17:30:24',16,73,15,1,1);
INSERT INTO ejaLinks VALUES(115,1,'2007-09-02 17:30:24',16,72,15,1,1);
INSERT INTO ejaLinks VALUES(116,1,'2007-09-02 17:30:24',16,71,15,1,1);
INSERT INTO ejaLinks VALUES(117,1,'2007-09-02 17:30:24',16,70,15,1,1);
INSERT INTO ejaLinks VALUES(120,1,'2007-09-02 17:30:24',16,67,15,1,1);
INSERT INTO ejaLinks VALUES(121,1,'2007-09-02 17:30:24',16,66,15,1,1);
INSERT INTO ejaLinks VALUES(123,1,'2007-09-02 17:30:24',16,64,15,1,1);
INSERT INTO ejaLinks VALUES(124,1,'2007-09-02 17:30:24',16,63,15,1,1);
INSERT INTO ejaLinks VALUES(125,1,'2007-09-02 17:30:24',16,62,15,1,1);
INSERT INTO ejaLinks VALUES(126,1,'2007-09-02 17:30:24',16,61,15,1,1);
INSERT INTO ejaLinks VALUES(127,1,'2007-09-02 17:30:24',16,60,15,1,1);
INSERT INTO ejaLinks VALUES(128,1,'2007-09-02 17:30:24',16,59,15,1,1);
INSERT INTO ejaLinks VALUES(129,1,'2007-09-02 17:30:24',16,58,15,1,1);
INSERT INTO ejaLinks VALUES(130,1,'2007-09-02 17:30:24',16,57,15,1,1);
INSERT INTO ejaLinks VALUES(133,1,'2007-09-02 17:30:24',16,54,15,1,1);
INSERT INTO ejaLinks VALUES(134,1,'2007-09-02 17:30:24',16,53,15,1,1);
INSERT INTO ejaLinks VALUES(135,1,'2007-09-02 17:30:24',16,52,15,1,1);
INSERT INTO ejaLinks VALUES(136,1,'2007-09-02 17:30:24',16,51,15,1,1);
INSERT INTO ejaLinks VALUES(137,1,'2007-09-02 17:30:24',16,50,15,1,1);
INSERT INTO ejaLinks VALUES(138,1,'2007-09-02 17:30:24',16,49,15,1,1);
INSERT INTO ejaLinks VALUES(139,1,'2007-09-02 17:30:24',16,48,15,1,1);
INSERT INTO ejaLinks VALUES(140,1,'2007-09-02 17:30:24',16,47,15,1,1);
INSERT INTO ejaLinks VALUES(141,1,'2007-09-02 17:30:24',16,46,15,1,1);
INSERT INTO ejaLinks VALUES(142,1,'2007-09-02 17:30:24',16,45,15,1,1);
INSERT INTO ejaLinks VALUES(144,1,'2007-09-02 17:30:24',16,43,15,1,1);
INSERT INTO ejaLinks VALUES(145,1,'2007-09-02 17:30:24',16,42,15,1,1);
INSERT INTO ejaLinks VALUES(146,1,'2007-09-02 17:30:24',16,41,15,1,1);
INSERT INTO ejaLinks VALUES(147,1,'2007-09-02 17:30:24',16,40,15,1,1);
INSERT INTO ejaLinks VALUES(148,1,'2007-09-02 17:30:24',16,39,15,1,1);
INSERT INTO ejaLinks VALUES(149,1,'2007-09-02 17:30:24',16,38,15,1,1);
INSERT INTO ejaLinks VALUES(150,1,'2007-09-02 17:30:24',16,37,15,1,1);
INSERT INTO ejaLinks VALUES(151,1,'2007-09-02 17:30:24',16,36,15,1,1);
INSERT INTO ejaLinks VALUES(152,1,'2007-09-02 17:30:24',16,35,15,1,1);
INSERT INTO ejaLinks VALUES(153,1,'2007-09-02 17:30:24',16,34,15,1,1);
INSERT INTO ejaLinks VALUES(154,1,'2007-09-02 17:30:24',16,33,15,1,1);
INSERT INTO ejaLinks VALUES(157,1,'2007-09-02 17:30:24',16,30,15,1,1);
INSERT INTO ejaLinks VALUES(158,1,'2007-09-02 17:30:24',16,29,15,1,1);
INSERT INTO ejaLinks VALUES(159,1,'2007-09-02 17:30:24',16,28,15,1,1);
INSERT INTO ejaLinks VALUES(160,1,'2007-09-02 17:30:24',16,27,15,1,1);
INSERT INTO ejaLinks VALUES(161,1,'2007-09-02 17:30:24',16,26,15,1,1);
INSERT INTO ejaLinks VALUES(162,1,'2007-09-02 17:30:24',16,25,15,1,1);
INSERT INTO ejaLinks VALUES(163,1,'2007-09-02 17:30:24',16,24,15,1,1);
INSERT INTO ejaLinks VALUES(164,1,'2007-09-02 17:30:24',16,23,15,1,1);
INSERT INTO ejaLinks VALUES(165,1,'2007-09-02 17:30:24',16,22,15,1,1);
INSERT INTO ejaLinks VALUES(166,1,'2007-09-02 17:30:24',16,21,15,1,1);
INSERT INTO ejaLinks VALUES(199,1,'2007-09-02 20:55:55',16,122,15,1,1);
INSERT INTO ejaLinks VALUES(210,1,'2007-09-03 20:12:24',16,136,15,1,1);
INSERT INTO ejaLinks VALUES(211,1,'2007-09-04 09:49:50',16,143,15,1,1);
INSERT INTO ejaLinks VALUES(212,1,'2007-09-04 09:49:50',16,142,15,1,1);
INSERT INTO ejaLinks VALUES(213,1,'2007-09-04 09:49:50',16,141,15,1,1);
INSERT INTO ejaLinks VALUES(214,1,'2007-09-04 09:49:50',16,140,15,1,1);
INSERT INTO ejaLinks VALUES(215,1,'2007-09-04 09:49:50',16,139,15,1,1);
INSERT INTO ejaLinks VALUES(216,1,'2007-09-04 09:49:50',16,138,15,1,1);
INSERT INTO ejaLinks VALUES(234,1,'2007-09-07 12:59:41',16,168,15,1,1);
INSERT INTO ejaLinks VALUES(235,1,'2007-09-07 12:59:41',16,167,15,1,1);
INSERT INTO ejaLinks VALUES(236,1,'2007-09-07 12:59:41',16,166,15,1,1);
INSERT INTO ejaLinks VALUES(237,1,'2007-09-07 12:59:41',16,165,15,1,1);
INSERT INTO ejaLinks VALUES(238,1,'2007-09-07 12:59:41',16,164,15,1,1);
INSERT INTO ejaLinks VALUES(239,1,'2007-09-07 12:59:41',16,163,15,1,1);
INSERT INTO ejaLinks VALUES(240,1,'2007-09-07 12:59:41',16,162,15,1,1);
INSERT INTO ejaLinks VALUES(241,1,'2007-09-07 12:59:41',16,161,15,1,1);
INSERT INTO ejaLinks VALUES(242,1,'2007-09-07 12:59:41',16,160,15,1,1);
INSERT INTO ejaLinks VALUES(243,1,'2007-09-07 12:59:41',16,159,15,1,1);
INSERT INTO ejaLinks VALUES(244,1,'2007-09-07 17:15:48',16,171,15,1,1);
INSERT INTO ejaLinks VALUES(245,1,'2007-09-07 17:15:48',16,169,15,1,1);
INSERT INTO ejaLinks VALUES(380,1,'2007-10-02 09:29:00',16,267,15,1,1);
INSERT INTO ejaLinks VALUES(383,1,'2007-10-02 09:29:00',16,276,15,1,1);
INSERT INTO ejaLinks VALUES(384,1,'2007-10-02 09:29:00',16,275,15,1,1);
INSERT INTO ejaLinks VALUES(385,1,'2007-10-02 09:29:00',16,274,15,1,1);
INSERT INTO ejaLinks VALUES(386,1,'2007-10-02 09:29:00',16,273,15,1,1);
INSERT INTO ejaLinks VALUES(387,1,'2007-10-02 09:29:00',16,272,15,1,1);
INSERT INTO ejaLinks VALUES(388,1,'2007-10-02 09:29:00',16,271,15,1,1);
INSERT INTO ejaLinks VALUES(389,1,'2007-10-02 09:29:00',16,270,15,1,1);
INSERT INTO ejaLinks VALUES(390,1,'2007-10-02 09:29:00',16,269,15,1,1);
INSERT INTO ejaLinks VALUES(391,1,'2007-10-02 09:29:00',16,268,15,1,1);
INSERT INTO ejaLinks VALUES(392,1,'2007-10-02 09:29:00',16,279,15,1,1);
INSERT INTO ejaLinks VALUES(393,1,'2007-10-02 17:09:40',16,281,15,1,1);
INSERT INTO ejaLinks VALUES(394,1,'2007-10-25 10:27:38',16,282,15,1,1);
INSERT INTO ejaLinks VALUES(395,1,'2007-10-26 18:09:51',16,293,15,1,1);
INSERT INTO ejaLinks VALUES(396,1,'2007-10-26 18:09:51',16,292,15,1,1);
INSERT INTO ejaLinks VALUES(397,1,'2007-10-26 18:09:51',16,291,15,1,1);
INSERT INTO ejaLinks VALUES(398,1,'2007-10-26 18:09:51',16,290,15,1,1);
INSERT INTO ejaLinks VALUES(399,1,'2007-10-26 18:09:51',16,289,15,1,1);
INSERT INTO ejaLinks VALUES(400,1,'2007-10-26 18:09:51',16,288,15,1,1);
INSERT INTO ejaLinks VALUES(401,1,'2007-10-26 18:09:51',16,287,15,1,1);
INSERT INTO ejaLinks VALUES(402,1,'2007-10-26 18:09:51',16,286,15,1,1);
INSERT INTO ejaLinks VALUES(403,1,'2007-10-26 18:09:51',16,285,15,1,1);
INSERT INTO ejaLinks VALUES(404,1,'2007-10-26 18:09:51',16,284,15,1,1);
INSERT INTO ejaLinks VALUES(407,1,'2007-10-26 18:09:51',16,296,15,1,1);
INSERT INTO ejaLinks VALUES(427,1,'2008-01-17 12:27:46',16,321,15,1,1);
INSERT INTO ejaLinks VALUES(428,1,'2008-01-17 12:27:46',16,320,15,1,1);
INSERT INTO ejaLinks VALUES(429,1,'2008-01-17 12:27:46',16,319,15,1,1);
INSERT INTO ejaLinks VALUES(430,1,'2008-01-17 12:27:46',16,318,15,1,1);
INSERT INTO ejaLinks VALUES(432,1,'2008-01-17 12:27:46',16,316,15,1,1);
INSERT INTO ejaLinks VALUES(433,1,'2008-01-17 12:27:46',16,322,15,1,1);
INSERT INTO ejaLinks VALUES(435,1,'2008-01-17 12:27:46',16,324,15,1,1);
INSERT INTO ejaLinks VALUES(436,1,'2008-01-17 12:27:46',16,325,15,1,1);
INSERT INTO ejaLinks VALUES(451,1,'2008-01-17 12:49:17',16,330,15,1,1);
INSERT INTO ejaLinks VALUES(642,1,'2008-03-04 15:37:56',16,482,15,1,1);
INSERT INTO ejaLinks VALUES(665,1,'2008-04-08 12:05:58',16,481,15,1,1);
INSERT INTO ejaLinks VALUES(666,1,'2008-04-08 12:05:58',16,480,15,1,1);
INSERT INTO ejaLinks VALUES(667,1,'2008-04-08 12:06:22',16,499,15,1,1);
INSERT INTO ejaLinks VALUES(668,1,'2008-04-08 12:06:22',16,498,15,1,1);
INSERT INTO ejaLinks VALUES(671,1,'2008-05-08 12:07:53',16,502,15,1,1);
INSERT INTO ejaLinks VALUES(672,1,'2008-05-08 12:07:53',16,501,15,1,1);
INSERT INTO ejaLinks VALUES(1109,1,'2010-01-07 15:49:37',16,584,15,1,1);
INSERT INTO ejaLinks VALUES(1110,1,'2010-01-07 15:49:37',16,583,15,1,1);
INSERT INTO ejaLinks VALUES(1111,1,'2010-01-07 15:49:37',16,582,15,1,1);
INSERT INTO ejaLinks VALUES(1112,1,'2010-01-07 15:49:37',16,581,15,1,1);
INSERT INTO ejaLinks VALUES(1113,1,'2010-01-07 15:49:37',16,580,15,1,1);
INSERT INTO ejaLinks VALUES(1114,1,'2010-01-07 15:49:37',16,579,15,1,1);
INSERT INTO ejaLinks VALUES(1115,1,'2010-01-07 15:49:37',16,578,15,1,1);
INSERT INTO ejaLinks VALUES(1116,1,'2010-01-07 15:49:37',16,577,15,1,1);
INSERT INTO ejaLinks VALUES(1117,1,'2010-01-07 15:49:37',16,576,15,1,1);
INSERT INTO ejaLinks VALUES(1118,1,'2010-01-14 14:58:42',16,122,15,13,1);
CREATE TABLE ejaModuleLinks (
  ejaId integer NOT NULL primary key,
  ejaOwner integer default 0,
  ejaLog datetime default NULL,
  dstModuleId integer default 0,
  srcModuleId integer default 0,
  power integer default 0,
  srcFieldName char(255) default NULL
);
ALTER TABLE ejaModuleLinks CHANGE ejaId ejaId integer AUTO_INCREMENT;
INSERT INTO ejaModuleLinks VALUES(1,1,'2007-10-02 09:29:23',15,19,1,'');
INSERT INTO ejaModuleLinks VALUES(2,1,'2007-10-02 09:29:46',15,16,2,'');
INSERT INTO ejaModuleLinks VALUES(3,1,'2007-10-02 09:29:54',15,14,3,'');
INSERT INTO ejaModuleLinks VALUES(5,1,'2007-10-02 16:48:19',14,5,1,'');
CREATE TABLE ejaModules (
  ejaId integer NOT NULL primary key,
  ejaOwner integer default 0,
  ejaLog datetime default NULL,
  parentId integer default 0,
  name varchar(32) default NULL,
  power integer default 0,
  sqlCreated integer default 0,
  searchLimit integer default 0, 
  sortList TEXT, lua MEDIUMTEXT
);
ALTER TABLE ejaModules CHANGE ejaId ejaId integer AUTO_INCREMENT;
INSERT INTO ejaModules VALUES(1,1,'0000-00-00 00:00:00',35,'ejaLogin',1,1,0,NULL,NULL);
INSERT INTO ejaModules VALUES(2,1,'2001-06-22 12:00:00',0,'eja',1,0,0,NULL,NULL);
INSERT INTO ejaModules VALUES(5,1,'0000-00-00 00:00:00',25,'ejaModules',1,1,0,'name','');
INSERT INTO ejaModules VALUES(6,1,'0000-00-00 00:00:00',25,'ejaFields',3,1,0,'','');
INSERT INTO ejaModules VALUES(13,1,'2007-08-17 12:10:08',35,'ejaLinks',6,1,20,'srcFieldId','');
INSERT INTO ejaModules VALUES(14,1,'2007-08-31 16:52:16',26,'ejaGroups',2,1,0,NULL,NULL);
INSERT INTO ejaModules VALUES(15,1,'2007-08-31 19:01:42',26,'ejaUsers',1,1,0,NULL,NULL);
INSERT INTO ejaModules VALUES(16,1,'2007-09-01 09:08:32',25,'ejaPermissions',4,1,0,'ejaModuleId','');
INSERT INTO ejaModules VALUES(17,1,'2007-09-01 11:21:52',35,'ejaCommands',3,1,0,'name','');
INSERT INTO ejaModules VALUES(18,1,'2007-09-01 12:16:59',26,'ejaTranslations',6,1,0,NULL,NULL);
INSERT INTO ejaModules VALUES(19,1,'2007-09-02 19:41:23',35,'ejaFiles',2,1,0,'','');
INSERT INTO ejaModules VALUES(20,1,'2007-09-03 19:41:29',26,'ejaHelps',5,1,0,NULL,NULL);
INSERT INTO ejaModules VALUES(21,1,'2007-09-04 09:46:49',35,'ejaSessions',5,1,0,NULL,NULL);
INSERT INTO ejaModules VALUES(24,1,'2007-09-07 12:54:16',35,'ejaLanguages',4,1,0,NULL,NULL);
INSERT INTO ejaModules VALUES(25,1,'2007-09-07 17:12:31',2,'ejaStructure',2,0,0,NULL,NULL);
INSERT INTO ejaModules VALUES(26,1,'2007-09-07 17:13:06',2,'ejaAdministration',1,0,0,NULL,NULL);
INSERT INTO ejaModules VALUES(27,1,'2007-09-09 18:06:53',35,'ejaSql',1,1,0,NULL,NULL);
INSERT INTO ejaModules VALUES(34,1,'2007-10-02 09:19:31',25,'ejaModuleLinks',5,1,0,NULL,NULL);
INSERT INTO ejaModules VALUES(35,1,'2007-10-02 17:00:20',2,'ejaSystem',3,0,0,NULL,NULL);
INSERT INTO ejaModules VALUES(36,1,'2007-10-24 18:41:44',35,'ejaBackups',10,0,0,NULL,NULL);
CREATE TABLE ejaPermissions (
  ejaId integer NOT NULL primary key,
  ejaOwner integer default 0,
  ejaLog datetime default NULL,
  ejaModuleId integer default 0,
  ejaCommandId integer default 0
);
ALTER TABLE ejaPermissions CHANGE ejaId ejaId integer AUTO_INCREMENT;
INSERT INTO ejaPermissions VALUES(21,1,'2007-09-02 16:23:36',18,3);
INSERT INTO ejaPermissions VALUES(22,1,'2007-09-02 16:23:48',18,4);
INSERT INTO ejaPermissions VALUES(23,1,'2007-09-02 16:23:52',18,5);
INSERT INTO ejaPermissions VALUES(24,1,'2007-09-02 16:23:56',18,6);
INSERT INTO ejaPermissions VALUES(25,1,'2007-09-02 16:24:01',18,7);
INSERT INTO ejaPermissions VALUES(26,1,'2007-09-02 16:24:05',18,8);
INSERT INTO ejaPermissions VALUES(27,1,'2007-09-02 16:24:09',18,9);
INSERT INTO ejaPermissions VALUES(28,1,'2007-09-02 16:24:21',18,10);
INSERT INTO ejaPermissions VALUES(29,1,'2007-09-02 16:24:27',18,11);
INSERT INTO ejaPermissions VALUES(30,1,'2007-09-02 16:24:35',18,12);
INSERT INTO ejaPermissions VALUES(33,1,'2007-09-02 16:26:00',16,3);
INSERT INTO ejaPermissions VALUES(34,1,'2007-09-02 16:26:04',16,4);
INSERT INTO ejaPermissions VALUES(35,1,'2007-09-02 16:26:08',16,5);
INSERT INTO ejaPermissions VALUES(36,1,'2007-09-02 16:26:11',16,6);
INSERT INTO ejaPermissions VALUES(37,1,'2007-09-02 16:26:20',16,7);
INSERT INTO ejaPermissions VALUES(38,1,'2007-09-02 16:26:26',16,8);
INSERT INTO ejaPermissions VALUES(39,1,'2007-09-02 16:26:33',16,9);
INSERT INTO ejaPermissions VALUES(40,1,'2007-09-02 16:26:40',16,10);
INSERT INTO ejaPermissions VALUES(41,1,'2007-09-02 16:26:46',16,11);
INSERT INTO ejaPermissions VALUES(42,1,'2007-09-02 16:26:49',16,12);
INSERT INTO ejaPermissions VALUES(43,1,'2007-09-02 16:26:55',16,14);
INSERT INTO ejaPermissions VALUES(45,1,'2007-09-02 16:28:48',17,3);
INSERT INTO ejaPermissions VALUES(46,1,'2007-09-02 16:29:09',17,4);
INSERT INTO ejaPermissions VALUES(47,1,'2007-09-02 16:29:13',17,5);
INSERT INTO ejaPermissions VALUES(48,1,'2007-09-02 16:29:17',17,6);
INSERT INTO ejaPermissions VALUES(49,1,'2007-09-02 16:29:21',17,7);
INSERT INTO ejaPermissions VALUES(50,1,'2007-09-02 16:29:25',17,8);
INSERT INTO ejaPermissions VALUES(51,1,'2007-09-02 16:29:28',17,9);
INSERT INTO ejaPermissions VALUES(52,1,'2007-09-02 16:29:32',17,10);
INSERT INTO ejaPermissions VALUES(53,1,'2007-09-02 16:29:35',17,11);
INSERT INTO ejaPermissions VALUES(54,1,'2007-09-02 16:29:38',17,12);
INSERT INTO ejaPermissions VALUES(57,1,'2007-09-02 16:29:55',5,3);
INSERT INTO ejaPermissions VALUES(58,1,'2007-09-02 16:30:00',5,4);
INSERT INTO ejaPermissions VALUES(59,1,'2007-09-02 16:30:06',5,5);
INSERT INTO ejaPermissions VALUES(60,1,'2007-09-02 16:30:10',5,6);
INSERT INTO ejaPermissions VALUES(61,1,'2007-09-02 16:30:15',5,7);
INSERT INTO ejaPermissions VALUES(62,1,'2007-09-02 16:30:18',5,8);
INSERT INTO ejaPermissions VALUES(63,1,'2007-09-02 16:30:21',5,9);
INSERT INTO ejaPermissions VALUES(64,1,'2007-09-02 16:30:25',5,10);
INSERT INTO ejaPermissions VALUES(66,1,'2007-09-02 16:30:50',5,11);
INSERT INTO ejaPermissions VALUES(67,1,'2007-09-02 16:30:53',5,12);
INSERT INTO ejaPermissions VALUES(70,1,'2007-09-02 16:31:16',2,2);
INSERT INTO ejaPermissions VALUES(71,1,'2007-09-02 16:31:46',2,12);
INSERT INTO ejaPermissions VALUES(72,1,'2007-09-02 16:31:59',6,3);
INSERT INTO ejaPermissions VALUES(73,1,'2007-09-02 16:32:04',6,4);
INSERT INTO ejaPermissions VALUES(74,1,'2007-09-02 16:32:09',6,5);
INSERT INTO ejaPermissions VALUES(75,1,'2007-09-02 16:32:13',6,6);
INSERT INTO ejaPermissions VALUES(76,1,'2007-09-02 16:32:16',6,7);
INSERT INTO ejaPermissions VALUES(77,1,'2007-09-02 16:32:20',6,8);
INSERT INTO ejaPermissions VALUES(78,1,'2007-09-02 16:32:24',6,9);
INSERT INTO ejaPermissions VALUES(79,1,'2007-09-02 16:32:27',6,10);
INSERT INTO ejaPermissions VALUES(80,1,'2007-09-02 16:32:34',6,11);
INSERT INTO ejaPermissions VALUES(81,1,'2007-09-02 16:32:38',6,12);
INSERT INTO ejaPermissions VALUES(86,1,'2007-09-02 16:38:35',13,3);
INSERT INTO ejaPermissions VALUES(87,1,'2007-09-02 16:38:43',13,4);
INSERT INTO ejaPermissions VALUES(88,1,'2007-09-02 16:38:47',13,5);
INSERT INTO ejaPermissions VALUES(89,1,'2007-09-02 16:38:50',13,6);
INSERT INTO ejaPermissions VALUES(90,1,'2007-09-02 16:38:53',13,7);
INSERT INTO ejaPermissions VALUES(91,1,'2007-09-02 16:38:58',13,8);
INSERT INTO ejaPermissions VALUES(92,1,'2007-09-02 16:39:02',13,9);
INSERT INTO ejaPermissions VALUES(93,1,'2007-09-02 16:39:06',13,10);
INSERT INTO ejaPermissions VALUES(94,1,'2007-09-02 16:39:10',13,11);
INSERT INTO ejaPermissions VALUES(95,1,'2007-09-02 16:39:13',13,12);
INSERT INTO ejaPermissions VALUES(98,1,'2007-09-02 16:39:34',14,3);
INSERT INTO ejaPermissions VALUES(99,1,'2007-09-02 16:39:38',14,4);
INSERT INTO ejaPermissions VALUES(100,1,'2007-09-02 16:39:41',14,5);
INSERT INTO ejaPermissions VALUES(101,1,'2007-09-02 16:39:44',14,6);
INSERT INTO ejaPermissions VALUES(102,1,'2007-09-02 16:39:49',14,7);
INSERT INTO ejaPermissions VALUES(103,1,'2007-09-02 16:39:54',14,8);
INSERT INTO ejaPermissions VALUES(104,1,'2007-09-02 16:39:58',14,9);
INSERT INTO ejaPermissions VALUES(105,1,'2007-09-02 16:40:04',14,10);
INSERT INTO ejaPermissions VALUES(106,1,'2007-09-02 16:40:07',14,11);
INSERT INTO ejaPermissions VALUES(107,1,'2007-09-02 16:40:10',14,12);
INSERT INTO ejaPermissions VALUES(110,1,'2007-09-02 16:40:33',15,3);
INSERT INTO ejaPermissions VALUES(111,1,'2007-09-02 16:40:39',15,4);
INSERT INTO ejaPermissions VALUES(112,1,'2007-09-02 16:40:42',15,5);
INSERT INTO ejaPermissions VALUES(113,1,'2007-09-02 16:40:44',15,6);
INSERT INTO ejaPermissions VALUES(114,1,'2007-09-02 16:40:48',15,7);
INSERT INTO ejaPermissions VALUES(115,1,'2007-09-02 16:40:51',15,8);
INSERT INTO ejaPermissions VALUES(116,1,'2007-09-02 16:40:54',15,9);
INSERT INTO ejaPermissions VALUES(117,1,'2007-09-02 16:40:57',15,10);
INSERT INTO ejaPermissions VALUES(118,1,'2007-09-02 16:41:01',15,11);
INSERT INTO ejaPermissions VALUES(119,1,'2007-09-02 16:41:04',15,12);
INSERT INTO ejaPermissions VALUES(122,1,'2007-09-02 20:37:00',19,17);
INSERT INTO ejaPermissions VALUES(136,1,'2007-09-03 20:11:41',19,4);
INSERT INTO ejaPermissions VALUES(138,1,'2007-09-04 09:48:53',21,5);
INSERT INTO ejaPermissions VALUES(139,1,'2007-09-04 09:48:56',21,6);
INSERT INTO ejaPermissions VALUES(140,1,'2007-09-04 09:49:00',21,7);
INSERT INTO ejaPermissions VALUES(141,1,'2007-09-04 09:49:12',21,10);
INSERT INTO ejaPermissions VALUES(142,1,'2007-09-04 09:49:16',21,11);
INSERT INTO ejaPermissions VALUES(143,1,'2007-09-04 09:49:24',21,12);
INSERT INTO ejaPermissions VALUES(159,1,'2007-09-07 12:58:24',24,3);
INSERT INTO ejaPermissions VALUES(160,1,'2007-09-07 12:58:34',24,4);
INSERT INTO ejaPermissions VALUES(161,1,'2007-09-07 12:58:38',24,5);
INSERT INTO ejaPermissions VALUES(162,1,'2007-09-07 12:58:42',24,6);
INSERT INTO ejaPermissions VALUES(163,1,'2007-09-07 12:58:46',24,7);
INSERT INTO ejaPermissions VALUES(164,1,'2007-09-07 12:58:49',24,8);
INSERT INTO ejaPermissions VALUES(165,1,'2007-09-07 12:58:52',24,9);
INSERT INTO ejaPermissions VALUES(166,1,'2007-09-07 12:58:55',24,10);
INSERT INTO ejaPermissions VALUES(167,1,'2007-09-07 12:58:58',24,11);
INSERT INTO ejaPermissions VALUES(168,1,'2007-09-07 12:59:06',24,12);
INSERT INTO ejaPermissions VALUES(169,1,'2007-09-07 17:14:11',25,12);
INSERT INTO ejaPermissions VALUES(171,1,'2007-09-07 17:14:44',26,12);
INSERT INTO ejaPermissions VALUES(267,1,'2007-10-02 09:24:08',34,2);
INSERT INTO ejaPermissions VALUES(268,1,'2007-10-02 09:24:08',34,3);
INSERT INTO ejaPermissions VALUES(269,1,'2007-10-02 09:24:08',34,4);
INSERT INTO ejaPermissions VALUES(270,1,'2007-10-02 09:24:08',34,5);
INSERT INTO ejaPermissions VALUES(271,1,'2007-10-02 09:24:08',34,6);
INSERT INTO ejaPermissions VALUES(272,1,'2007-10-02 09:24:08',34,7);
INSERT INTO ejaPermissions VALUES(273,1,'2007-10-02 09:24:08',34,8);
INSERT INTO ejaPermissions VALUES(274,1,'2007-10-02 09:24:08',34,9);
INSERT INTO ejaPermissions VALUES(275,1,'2007-10-02 09:24:08',34,10);
INSERT INTO ejaPermissions VALUES(276,1,'2007-10-02 09:24:08',34,11);
INSERT INTO ejaPermissions VALUES(279,1,'2007-10-02 09:24:08',34,27);
INSERT INTO ejaPermissions VALUES(281,1,'2007-10-02 17:09:02',35,27);
INSERT INTO ejaPermissions VALUES(282,1,'2007-10-25 10:27:06',36,13);
INSERT INTO ejaPermissions VALUES(284,1,'2007-10-26 18:09:51',20,2);
INSERT INTO ejaPermissions VALUES(285,1,'2007-10-26 18:09:51',20,3);
INSERT INTO ejaPermissions VALUES(286,1,'2007-10-26 18:09:51',20,4);
INSERT INTO ejaPermissions VALUES(287,1,'2007-10-26 18:09:51',20,5);
INSERT INTO ejaPermissions VALUES(288,1,'2007-10-26 18:09:51',20,6);
INSERT INTO ejaPermissions VALUES(289,1,'2007-10-26 18:09:51',20,7);
INSERT INTO ejaPermissions VALUES(290,1,'2007-10-26 18:09:51',20,8);
INSERT INTO ejaPermissions VALUES(291,1,'2007-10-26 18:09:51',20,9);
INSERT INTO ejaPermissions VALUES(292,1,'2007-10-26 18:09:51',20,10);
INSERT INTO ejaPermissions VALUES(293,1,'2007-10-26 18:09:51',20,11);
INSERT INTO ejaPermissions VALUES(296,1,'2007-10-26 18:09:51',20,27);
INSERT INTO ejaPermissions VALUES(316,1,'2008-01-17 12:27:46',27,2);
INSERT INTO ejaPermissions VALUES(318,1,'2008-01-17 12:27:46',27,4);
INSERT INTO ejaPermissions VALUES(319,1,'2008-01-17 12:27:46',27,5);
INSERT INTO ejaPermissions VALUES(320,1,'2008-01-17 12:27:46',27,6);
INSERT INTO ejaPermissions VALUES(321,1,'2008-01-17 12:27:46',27,7);
INSERT INTO ejaPermissions VALUES(322,1,'2008-01-17 12:27:46',27,8);
INSERT INTO ejaPermissions VALUES(324,1,'2008-01-17 12:27:46',27,10);
INSERT INTO ejaPermissions VALUES(325,1,'2008-01-17 12:27:46',27,11);
INSERT INTO ejaPermissions VALUES(330,1,'2008-01-17 12:44:50',27,13);
INSERT INTO ejaPermissions VALUES(480,1,'2008-03-04 12:42:47',14,14);
INSERT INTO ejaPermissions VALUES(481,1,'2008-03-04 12:43:05',14,15);
INSERT INTO ejaPermissions VALUES(482,1,'2008-03-04 15:37:08',16,15);
INSERT INTO ejaPermissions VALUES(498,1,'2008-04-08 12:04:59',5,14);
INSERT INTO ejaPermissions VALUES(499,1,'2008-04-08 12:05:17',5,15);
INSERT INTO ejaPermissions VALUES(501,1,'2008-05-08 12:07:19',19,35);
INSERT INTO ejaPermissions VALUES(502,1,'2008-05-08 12:07:35',19,36);
INSERT INTO ejaPermissions VALUES(576,1,'2010-01-07 15:47:20',19,5);
INSERT INTO ejaPermissions VALUES(577,1,'2010-01-07 15:47:24',19,10);
INSERT INTO ejaPermissions VALUES(578,1,'2010-01-07 15:47:28',19,3);
INSERT INTO ejaPermissions VALUES(579,1,'2010-01-07 15:47:32',19,2);
INSERT INTO ejaPermissions VALUES(580,1,'2010-01-07 15:47:38',19,7);
INSERT INTO ejaPermissions VALUES(581,1,'2010-01-07 15:47:53',19,9);
INSERT INTO ejaPermissions VALUES(582,1,'2010-01-07 15:47:58',19,8);
INSERT INTO ejaPermissions VALUES(583,1,'2010-01-07 15:48:03',19,11);
INSERT INTO ejaPermissions VALUES(584,1,'2010-01-07 15:48:24',19,6);
CREATE TABLE ejaSessions (
  ejaId integer NOT NULL primary key,
  ejaOwner integer default 0,
  ejaLog datetime default NULL,
  name varchar(255) default NULL,
  value mediumtext,
  sub varchar(255) default NULL
);
ALTER TABLE ejaSessions CHANGE ejaId ejaId integer AUTO_INCREMENT;
CREATE TABLE ejaSql (
  ejaId integer NOT NULL primary key,
  ejaOwner integer default 0,
  ejaLog datetime default NULL,
  query mediumtext
);
ALTER TABLE ejaSql CHANGE ejaId ejaId integer AUTO_INCREMENT;
CREATE TABLE ejaUsers (
  ejaId integer NOT NULL primary key,
  ejaOwner integer default 0,
  ejaLog datetime default NULL,
  ejaSession varchar(64) default NULL,
  username varchar(32) default NULL,
  password varchar(64) default NULL,
  defaultModuleId integer default 0,
  ejaLanguage text
);
ALTER TABLE ejaUsers CHANGE ejaId ejaId integer AUTO_INCREMENT;
INSERT INTO ejaUsers VALUES(1,1,'0000-00-00 00:00:00','','admin','eja.it',5,'en');
INSERT INTO ejaUsers VALUES(13,1,'2010-01-14 14:55:24','','user','eja.it',2,'en');
CREATE TABLE ejaLogin (
  ejaId INTEGER  PRIMARY KEY, 
  ejaOwner INTEGER, 
  ejaLog DATETIME, 
  username CHAR(255), 
  password CHAR(255)
);
ALTER TABLE ejaLogin CHANGE ejaId ejaId integer AUTO_INCREMENT;
CREATE TABLE ejaTranslations (
  ejaId integer NOT NULL primary key,
  ejaOwner integer default 0,
  ejaLog datetime default NULL,
  ejaLanguage char(3) default NULL,
  ejaModuleId integer default 0,
  word text,
  translation text
);
ALTER TABLE ejaTranslations CHANGE ejaId ejaId integer AUTO_INCREMENT;
INSERT INTO ejaTranslations VALUES(10,1,'2007-09-10 18:20:27','it',0,'ejaSystem','Sistema');
INSERT INTO ejaTranslations VALUES(11,1,'2007-09-10 18:21:14','it',0,'ejaTools','Strumenti');
INSERT INTO ejaTranslations VALUES(12,1,'2007-09-10 18:22:00','it',0,'ejaHelps','Aiuto');
INSERT INTO ejaTranslations VALUES(13,1,'2007-09-10 18:22:13','it',0,'ejaTranslations','Traduzioni');
INSERT INTO ejaTranslations VALUES(14,1,'2007-09-10 18:22:32','it',0,'ejaLanguages','Lingue');
INSERT INTO ejaTranslations VALUES(15,1,'2007-09-10 18:22:43','it',0,'ejaFiles','Allegati');
INSERT INTO ejaTranslations VALUES(16,1,'2007-09-10 18:22:49','it',0,'ejaSql','Sql');
INSERT INTO ejaTranslations VALUES(17,1,'2007-09-10 18:22:58','it',0,'ejaSessions','Sessioni');
INSERT INTO ejaTranslations VALUES(18,1,'2007-09-10 18:29:45','it',0,'ejaModules','Moduli');
INSERT INTO ejaTranslations VALUES(19,1,'2007-09-10 18:30:31','it',0,'ejaFields','Campi');
INSERT INTO ejaTranslations VALUES(20,1,'2007-09-10 18:30:42','it',0,'ejaCommands','Comandi');
INSERT INTO ejaTranslations VALUES(21,1,'2007-09-10 18:30:55','it',0,'ejaPermissions','Permessi');
INSERT INTO ejaTranslations VALUES(22,1,'2007-09-10 18:31:02','it',0,'ejaGroups','Gruppi');
INSERT INTO ejaTranslations VALUES(23,1,'2007-09-10 18:31:10','it',0,'ejaUsers','Utenti');
INSERT INTO ejaTranslations VALUES(24,1,'2007-09-10 18:31:23','it',0,'ejaLinks','Collegamenti');
INSERT INTO ejaTranslations VALUES(25,1,'2007-09-10 18:31:57','it',0,'ejaAdministration','Amministrazione');
INSERT INTO ejaTranslations VALUES(26,1,'2007-09-10 18:35:07','it',5,'name','nome');
INSERT INTO ejaTranslations VALUES(27,1,'2007-09-10 18:35:54','it',5,'parentId','radice');
INSERT INTO ejaTranslations VALUES(28,1,'2007-09-10 18:36:10','it',5,'power','cardinalità');
INSERT INTO ejaTranslations VALUES(29,1,'2007-09-10 18:36:49','it',5,'searchLimit','risultati per pagina');
INSERT INTO ejaTranslations VALUES(30,1,'2007-09-10 18:37:12','it',5,'sqlCreated','sql');
INSERT INTO ejaTranslations VALUES(31,1,'2007-09-10 18:37:53','it',17,'name','nome');
INSERT INTO ejaTranslations VALUES(32,1,'2007-09-10 18:39:44','it',17,'powerSearch','cardinalità di ricerca');
INSERT INTO ejaTranslations VALUES(33,1,'2007-09-10 18:39:54','it',17,'powerEdit','cardinalità  di modifica');
INSERT INTO ejaTranslations VALUES(34,1,'2007-09-10 18:40:02','it',17,'powerList','cardinalità di visualizzazione');
INSERT INTO ejaTranslations VALUES(35,1,'2007-09-10 18:40:34','it',6,'ejaModuleId','modulo');
INSERT INTO ejaTranslations VALUES(36,1,'2007-09-10 18:40:48','it',6,'type','tipo');
INSERT INTO ejaTranslations VALUES(37,1,'2007-09-10 18:41:02','it',6,'value','valori');
INSERT INTO ejaTranslations VALUES(38,1,'2007-09-10 18:41:17','it',6,'powerEdit','cardinalità di modifica');
INSERT INTO ejaTranslations VALUES(39,1,'2007-09-10 18:41:26','it',6,'powerList','cardinalità di visualizzazione');
INSERT INTO ejaTranslations VALUES(40,1,'2007-09-10 18:41:44','it',6,'powerSearch','cardinalità di ricerca');
INSERT INTO ejaTranslations VALUES(41,1,'2007-09-10 18:41:58','it',6,'sqlType','sql');
INSERT INTO ejaTranslations VALUES(42,1,'2007-09-10 18:42:16','it',6,'translate','traduzione');
INSERT INTO ejaTranslations VALUES(43,1,'2007-09-10 18:43:26','it',6,'name','nome');
INSERT INTO ejaTranslations VALUES(44,1,'2007-09-10 18:43:44','it',14,'name','nome');
INSERT INTO ejaTranslations VALUES(46,1,'2007-09-10 18:45:14','it',14,'note','note');
INSERT INTO ejaTranslations VALUES(47,1,'2007-09-10 18:46:05','it',20,'ejaModuleId','modulo');
INSERT INTO ejaTranslations VALUES(48,1,'2007-09-10 18:46:29','it',20,'actionType','categoria');
INSERT INTO ejaTranslations VALUES(49,1,'2007-09-10 18:46:42','it',20,'ejaLanguage','lingua');
INSERT INTO ejaTranslations VALUES(50,1,'2007-09-10 18:46:52','it',20,'text','testo');
INSERT INTO ejaTranslations VALUES(51,1,'2007-09-10 18:47:09','it',24,'name','acronimo');
INSERT INTO ejaTranslations VALUES(52,1,'2007-09-10 18:47:22','it',24,'nameFull','nome originale');
INSERT INTO ejaTranslations VALUES(53,1,'2007-09-10 18:48:08','it',24,'note','note');
INSERT INTO ejaTranslations VALUES(54,1,'2007-09-10 18:48:57','it',13,'dstModuleId','modulo');
INSERT INTO ejaTranslations VALUES(55,1,'2007-09-10 18:49:35','it',13,'dstFieldId','campo');
INSERT INTO ejaTranslations VALUES(56,1,'2007-09-10 18:49:43','it',13,'srcFieldId','campo collegato');
INSERT INTO ejaTranslations VALUES(57,1,'2007-09-10 18:50:27','it',13,'srcModuleId','modulo collegato');
INSERT INTO ejaTranslations VALUES(58,1,'2007-09-10 18:50:39','it',13,'power','cardinalità');
INSERT INTO ejaTranslations VALUES(59,1,'2007-09-10 18:51:05','it',16,'ejaModuleId','modulo');
INSERT INTO ejaTranslations VALUES(60,1,'2007-09-10 18:51:17','it',16,'ejaCommandId','comando');
INSERT INTO ejaTranslations VALUES(61,1,'2007-09-10 18:51:45','it',21,'name','nome');
INSERT INTO ejaTranslations VALUES(62,1,'2007-09-10 18:51:51','it',21,'value','valore');
INSERT INTO ejaTranslations VALUES(63,1,'2007-09-10 18:52:10','it',18,'word','parola');
INSERT INTO ejaTranslations VALUES(64,1,'2007-09-10 18:52:22','it',18,'translation','traduzione');
INSERT INTO ejaTranslations VALUES(65,1,'2007-09-10 18:52:31','it',18,'ejaLanguage','lingua');
INSERT INTO ejaTranslations VALUES(66,1,'2007-09-10 18:52:40','it',18,'ejaModuleId','modulo');
INSERT INTO ejaTranslations VALUES(67,1,'2007-09-10 18:53:04','it',15,'defaultModuleId','modulo preimpostato');
INSERT INTO ejaTranslations VALUES(68,1,'2007-09-10 18:53:49','it',15,'ejaSession','sessione');
INSERT INTO ejaTranslations VALUES(69,1,'2007-09-10 18:54:05','it',15,'ejaOwner','proprietario');
INSERT INTO ejaTranslations VALUES(70,1,'2007-09-10 18:54:20','it',15,'username','utente');
INSERT INTO ejaTranslations VALUES(71,1,'2007-09-10 18:54:26','it',15,'password','codice');
INSERT INTO ejaTranslations VALUES(72,1,'2007-09-10 18:54:43','it',15,'ejaLanguage','lingua');
INSERT INTO ejaTranslations VALUES(73,1,'2007-09-10 18:55:59','it',19,'ejaFileUpload','allegato');
INSERT INTO ejaTranslations VALUES(74,1,'2007-09-10 18:56:49','it',19,'name','nome cartella');
INSERT INTO ejaTranslations VALUES(75,1,'2007-09-10 18:57:04','it',21,'ejaOwner','proprietario');
INSERT INTO ejaTranslations VALUES(76,1,'2007-09-10 18:58:36','it',0,'new','nuovo');
INSERT INTO ejaTranslations VALUES(77,1,'2007-09-10 18:58:54','it',0,'edit','modifica');
INSERT INTO ejaTranslations VALUES(78,1,'2007-09-10 18:59:05','it',0,'previous','precedente');
INSERT INTO ejaTranslations VALUES(79,1,'2007-09-10 18:59:16','it',0,'next','successivo');
INSERT INTO ejaTranslations VALUES(80,1,'2007-09-10 18:59:33','it',0,'search','trova');
INSERT INTO ejaTranslations VALUES(81,1,'2007-09-10 18:59:41','it',0,'save','salva');
INSERT INTO ejaTranslations VALUES(82,1,'2007-09-10 18:59:52','it',0,'copy','copia');
INSERT INTO ejaTranslations VALUES(83,1,'2007-09-10 18:59:59','it',0,'list','lista');
INSERT INTO ejaTranslations VALUES(84,1,'2007-09-10 19:00:09','it',0,'delete','elimina');
INSERT INTO ejaTranslations VALUES(85,1,'2007-09-10 19:00:19','it',0,'help','aiuto');
INSERT INTO ejaTranslations VALUES(86,1,'2007-09-10 19:00:30','it',0,'link','collega');
INSERT INTO ejaTranslations VALUES(87,1,'2007-09-10 19:00:40','it',0,'unlink','scollega');
INSERT INTO ejaTranslations VALUES(93,1,'2007-09-10 19:02:23','it',0,'csvExport','csv');
INSERT INTO ejaTranslations VALUES(95,1,'2007-09-10 19:03:05','it',0,'logout','esci');
INSERT INTO ejaTranslations VALUES(96,1,'2007-09-10 19:05:36','en',0,'alertSearch',' ');
INSERT INTO ejaTranslations VALUES(97,1,'2007-09-10 19:06:14','it',0,'alertEdit',' ');
INSERT INTO ejaTranslations VALUES(98,1,'2007-09-10 19:06:19','it',0,'alertListSearch',' ');
INSERT INTO ejaTranslations VALUES(99,1,'2007-09-10 19:07:05','it',0,'alertListList',' ');
INSERT INTO ejaTranslations VALUES(100,1,'2007-09-10 19:15:34','it',0,'alertEditNew','creata una nuova scheda');
INSERT INTO ejaTranslations VALUES(101,1,'2007-09-10 19:15:34','it',0,'alertSearchNew','creato');
INSERT INTO ejaTranslations VALUES(102,1,'2007-09-10 19:15:34','it',0,'alertListNew','creato');
INSERT INTO ejaTranslations VALUES(103,1,'2007-09-10 19:15:34','it',0,'alertEditEdit',' ');
INSERT INTO ejaTranslations VALUES(104,1,'2007-09-10 19:15:34','it',0,'alertSearchEdit',' ');
INSERT INTO ejaTranslations VALUES(105,1,'2007-09-10 19:15:34','it',0,'alertListEdit',' ');
INSERT INTO ejaTranslations VALUES(106,1,'2007-09-10 19:15:34','it',0,'alertEditPrevious',' ');
INSERT INTO ejaTranslations VALUES(107,1,'2007-09-10 19:15:34','it',0,'alertSearchPrevious',' ');
INSERT INTO ejaTranslations VALUES(108,1,'2007-09-10 19:15:34','it',0,'alertListPrevious',' ');
INSERT INTO ejaTranslations VALUES(109,1,'2007-09-10 19:15:34','it',0,'alertEditNext',' ');
INSERT INTO ejaTranslations VALUES(110,1,'2007-09-10 19:15:34','it',0,'alertSearchNext',' ');
INSERT INTO ejaTranslations VALUES(111,1,'2007-09-10 19:15:34','it',0,'alertListNext',' ');
INSERT INTO ejaTranslations VALUES(112,1,'2007-09-10 19:15:34','it',0,'alertEditSearch',' ');
INSERT INTO ejaTranslations VALUES(113,1,'2007-09-10 19:15:34','it',0,'alertSearchSearch',' ');
INSERT INTO ejaTranslations VALUES(114,1,'2007-09-10 19:15:34','it',0,'alertListSearch',' ');
INSERT INTO ejaTranslations VALUES(115,1,'2007-09-10 19:15:34','it',0,'alertEditSave','scheda salvata');
INSERT INTO ejaTranslations VALUES(116,1,'2007-09-10 19:15:34','it',0,'alertSearchSave',' ');
INSERT INTO ejaTranslations VALUES(117,1,'2007-09-10 19:15:34','it',0,'alertListSave',' ');
INSERT INTO ejaTranslations VALUES(118,1,'2007-09-10 19:15:34','it',0,'alertEditCopy','scheda copiata');
INSERT INTO ejaTranslations VALUES(119,1,'2007-09-10 19:15:34','it',0,'alertSearchCopy',' ');
INSERT INTO ejaTranslations VALUES(120,1,'2007-09-10 19:15:34','it',0,'alertListCopy',' ');
INSERT INTO ejaTranslations VALUES(121,1,'2007-09-10 19:15:34','it',0,'alertEditList',' ');
INSERT INTO ejaTranslations VALUES(122,1,'2007-09-10 19:15:34','it',0,'alertSearchList',' ');
INSERT INTO ejaTranslations VALUES(123,1,'2007-09-10 19:15:34','it',0,'alertListList',' ');
INSERT INTO ejaTranslations VALUES(124,1,'2007-09-10 19:15:34','it',0,'alertEditDelete','scheda eliminata');
INSERT INTO ejaTranslations VALUES(125,1,'2007-09-10 19:15:34','it',0,'alertSearchDelete','schede eliminate');
INSERT INTO ejaTranslations VALUES(126,1,'2007-09-10 19:15:34','it',0,'alertListDelete','schede eliminate');
INSERT INTO ejaTranslations VALUES(127,1,'2007-09-10 19:15:34','it',0,'alertEditHelp',' ');
INSERT INTO ejaTranslations VALUES(128,1,'2007-09-10 19:15:34','it',0,'alertSearchHelp',' ');
INSERT INTO ejaTranslations VALUES(129,1,'2007-09-10 19:15:34','it',0,'alertListHelp',' ');
INSERT INTO ejaTranslations VALUES(130,1,'2007-09-10 19:15:34','it',0,'alertEditSql','sql eseguito');
INSERT INTO ejaTranslations VALUES(131,1,'2007-09-10 19:15:34','it',0,'alertSearchSql',' ');
INSERT INTO ejaTranslations VALUES(132,1,'2007-09-10 19:15:34','it',0,'alertListSql',' ');
INSERT INTO ejaTranslations VALUES(133,1,'2007-09-10 19:15:34','it',0,'alertEditLink',' ');
INSERT INTO ejaTranslations VALUES(134,1,'2007-09-10 19:15:34','it',0,'alertSearchLink',' ');
INSERT INTO ejaTranslations VALUES(135,1,'2007-09-10 19:15:34','it',0,'alertListLink','collegato');
INSERT INTO ejaTranslations VALUES(136,1,'2007-09-10 19:15:34','it',0,'alertEditUnlink',' ');
INSERT INTO ejaTranslations VALUES(137,1,'2007-09-10 19:15:34','it',0,'alertSearchUnlink',' ');
INSERT INTO ejaTranslations VALUES(138,1,'2007-09-10 19:15:34','it',0,'alertListUnlink','scollegato');
INSERT INTO ejaTranslations VALUES(139,1,'2007-09-10 19:15:34','it',0,'alertEditFileDownload',' ');
INSERT INTO ejaTranslations VALUES(140,1,'2007-09-10 19:15:34','it',0,'alertSearchFileDownload',' ');
INSERT INTO ejaTranslations VALUES(141,1,'2007-09-10 19:15:34','it',0,'alertListFileDownload',' ');
INSERT INTO ejaTranslations VALUES(142,1,'2007-09-10 19:15:34','it',0,'alertEditFileUpload',' ');
INSERT INTO ejaTranslations VALUES(143,1,'2007-09-10 19:15:34','it',0,'alertSearchFileUpload',' ');
INSERT INTO ejaTranslations VALUES(144,1,'2007-09-10 19:15:34','it',0,'alertListFileUpload',' ');
INSERT INTO ejaTranslations VALUES(145,1,'2007-09-10 19:15:34','it',0,'alertEditFileDelete','eliminato');
INSERT INTO ejaTranslations VALUES(146,1,'2007-09-10 19:15:34','it',0,'alertSearchFileDelete',' ');
INSERT INTO ejaTranslations VALUES(147,1,'2007-09-10 19:15:34','it',0,'alertListFileDelete',' ');
INSERT INTO ejaTranslations VALUES(148,1,'2007-09-10 19:15:34','it',0,'alertEditFileMove','spostamento eseguito');
INSERT INTO ejaTranslations VALUES(149,1,'2007-09-10 19:15:34','it',0,'alertSearchFileMove',' ');
INSERT INTO ejaTranslations VALUES(150,1,'2007-09-10 19:15:34','it',0,'alertListFileMove',' ');
INSERT INTO ejaTranslations VALUES(151,1,'2007-09-10 19:15:34','it',0,'alertEditFileNew','cartella creata');
INSERT INTO ejaTranslations VALUES(152,1,'2007-09-10 19:15:34','it',0,'alertSearchFileNew',' ');
INSERT INTO ejaTranslations VALUES(153,1,'2007-09-10 19:15:34','it',0,'alertListFileNew',' ');
INSERT INTO ejaTranslations VALUES(154,1,'2007-09-10 19:15:34','it',0,'alertEditCsvExport',' ');
INSERT INTO ejaTranslations VALUES(155,1,'2007-09-10 19:15:34','it',0,'alertSearchCsvExport',' ');
INSERT INTO ejaTranslations VALUES(156,1,'2007-09-10 19:15:34','it',0,'alertListCsvExport',' ');
INSERT INTO ejaTranslations VALUES(158,1,'2007-09-10 19:22:29','it',0,'confirm?','confermi?');
INSERT INTO ejaTranslations VALUES(164,1,'2007-09-10 19:31:08','it',19,'ejaUp','cartella superiore');
INSERT INTO ejaTranslations VALUES(165,1,'2007-09-10 19:33:35','it',0,'alertListSearchLink',' ');
INSERT INTO ejaTranslations VALUES(166,1,'2007-09-10 19:42:16','it',0,'alertSearchLogin',' ');
INSERT INTO ejaTranslations VALUES(167,1,'2007-09-10 19:42:42','it',19,'fileName','allegati');
INSERT INTO ejaTranslations VALUES(168,1,'2007-09-11 12:16:00','it',0,'alertSearchLogout',' ');
INSERT INTO ejaTranslations VALUES(169,1,'2007-09-11 13:09:10','it',0,'back','indietro');
INSERT INTO ejaTranslations VALUES(170,1,'2007-09-11 16:50:26','it',0,'linkBack','chiudi collegamento');
INSERT INTO ejaTranslations VALUES(173,1,'2007-09-12 19:31:36','it',0,'alertSearchSearchLink',' ');
INSERT INTO ejaTranslations VALUES(174,1,'2007-09-17 10:17:58','it',1,'login','login');
INSERT INTO ejaTranslations VALUES(175,1,'2007-09-17 10:18:26','it',1,'username','utente');
INSERT INTO ejaTranslations VALUES(176,1,'2007-09-17 10:18:32','it',1,'password','codice');
INSERT INTO ejaTranslations VALUES(200,1,'2007-09-18 15:35:45','it',1,'ejaLogin','intranet');
INSERT INTO ejaTranslations VALUES(201,1,'2007-09-20 18:24:42','it',0,'sql','sql');
INSERT INTO ejaTranslations VALUES(202,1,'2007-09-20 18:32:09','it',17,'defaultCommand','pre attivato');
INSERT INTO ejaTranslations VALUES(203,1,'2007-09-20 19:44:06','it',6,'ejaGroup','gruppo di modifica');
INSERT INTO ejaTranslations VALUES(204,1,'2007-09-26 15:54:47','it',21,'sub','sub');
INSERT INTO ejaTranslations VALUES(207,1,'0000-00-00 00:00:00','en',0,'ejaSystem','System');
INSERT INTO ejaTranslations VALUES(208,1,'0000-00-00 00:00:00','en',0,'ejaTools','Tools');
INSERT INTO ejaTranslations VALUES(209,1,'0000-00-00 00:00:00','en',0,'ejaHelps','Helps');
INSERT INTO ejaTranslations VALUES(210,1,'0000-00-00 00:00:00','en',0,'ejaTranslations','Translations');
INSERT INTO ejaTranslations VALUES(211,1,'0000-00-00 00:00:00','en',0,'ejaLanguages','Languages');
INSERT INTO ejaTranslations VALUES(212,1,'0000-00-00 00:00:00','en',0,'ejaFiles','Files');
INSERT INTO ejaTranslations VALUES(213,1,'0000-00-00 00:00:00','en',0,'ejaSql','Sql');
INSERT INTO ejaTranslations VALUES(214,1,'0000-00-00 00:00:00','en',0,'ejaSessions','Sessions');
INSERT INTO ejaTranslations VALUES(215,1,'0000-00-00 00:00:00','en',0,'ejaModules','Modules');
INSERT INTO ejaTranslations VALUES(216,1,'0000-00-00 00:00:00','en',0,'ejaFields','Fields');
INSERT INTO ejaTranslations VALUES(217,1,'0000-00-00 00:00:00','en',0,'ejaCommands','Commands');
INSERT INTO ejaTranslations VALUES(218,1,'0000-00-00 00:00:00','en',0,'ejaPermissions','Permissions');
INSERT INTO ejaTranslations VALUES(219,1,'0000-00-00 00:00:00','en',0,'ejaGroups','Groups');
INSERT INTO ejaTranslations VALUES(220,1,'0000-00-00 00:00:00','en',0,'ejaUsers','Users');
INSERT INTO ejaTranslations VALUES(221,1,'0000-00-00 00:00:00','en',0,'ejaLinks','Links');
INSERT INTO ejaTranslations VALUES(222,1,'0000-00-00 00:00:00','en',0,'ejaAdministration','Administration');
INSERT INTO ejaTranslations VALUES(223,1,'0000-00-00 00:00:00','en',5,'name','name');
INSERT INTO ejaTranslations VALUES(224,1,'0000-00-00 00:00:00','en',5,'parentId','parent');
INSERT INTO ejaTranslations VALUES(225,1,'0000-00-00 00:00:00','en',17,'name','name');
INSERT INTO ejaTranslations VALUES(226,1,'0000-00-00 00:00:00','en',5,'power','power');
INSERT INTO ejaTranslations VALUES(227,1,'0000-00-00 00:00:00','en',5,'searchLimit','page results');
INSERT INTO ejaTranslations VALUES(228,1,'0000-00-00 00:00:00','en',5,'sqlCreated','sql');
INSERT INTO ejaTranslations VALUES(229,1,'0000-00-00 00:00:00','en',17,'powerSearch','search power');
INSERT INTO ejaTranslations VALUES(230,1,'0000-00-00 00:00:00','en',17,'powerEdit','edit power');
INSERT INTO ejaTranslations VALUES(231,1,'0000-00-00 00:00:00','en',17,'powerList','list power');
INSERT INTO ejaTranslations VALUES(232,1,'0000-00-00 00:00:00','en',6,'ejaModuleId','module');
INSERT INTO ejaTranslations VALUES(233,1,'0000-00-00 00:00:00','en',6,'type','type');
INSERT INTO ejaTranslations VALUES(234,1,'0000-00-00 00:00:00','en',6,'value','values');
INSERT INTO ejaTranslations VALUES(235,1,'0000-00-00 00:00:00','en',6,'powerEdit','edit power');
INSERT INTO ejaTranslations VALUES(236,1,'0000-00-00 00:00:00','en',6,'powerList','list power');
INSERT INTO ejaTranslations VALUES(237,1,'0000-00-00 00:00:00','en',6,'powerSearch','search power');
INSERT INTO ejaTranslations VALUES(238,1,'0000-00-00 00:00:00','en',6,'sqlType','sql type');
INSERT INTO ejaTranslations VALUES(239,1,'0000-00-00 00:00:00','en',6,'translate','translate');
INSERT INTO ejaTranslations VALUES(240,1,'0000-00-00 00:00:00','en',6,'name','name');
INSERT INTO ejaTranslations VALUES(241,1,'0000-00-00 00:00:00','en',14,'name','name');
INSERT INTO ejaTranslations VALUES(242,1,'0000-00-00 00:00:00','en',14,'note','note');
INSERT INTO ejaTranslations VALUES(243,1,'0000-00-00 00:00:00','en',20,'ejaModuleId','module');
INSERT INTO ejaTranslations VALUES(244,1,'0000-00-00 00:00:00','en',20,'actionType','category');
INSERT INTO ejaTranslations VALUES(245,1,'0000-00-00 00:00:00','en',20,'ejaLanguage','language');
INSERT INTO ejaTranslations VALUES(246,1,'0000-00-00 00:00:00','en',20,'text','content');
INSERT INTO ejaTranslations VALUES(247,1,'0000-00-00 00:00:00','en',24,'name','acronym');
INSERT INTO ejaTranslations VALUES(248,1,'0000-00-00 00:00:00','en',24,'nameFull','full name');
INSERT INTO ejaTranslations VALUES(249,1,'0000-00-00 00:00:00','en',24,'note','note');
INSERT INTO ejaTranslations VALUES(250,1,'0000-00-00 00:00:00','en',13,'dstModuleId','linked module');
INSERT INTO ejaTranslations VALUES(251,1,'0000-00-00 00:00:00','en',13,'dstFieldId','linked field');
INSERT INTO ejaTranslations VALUES(252,1,'0000-00-00 00:00:00','en',13,'srcFieldId','field');
INSERT INTO ejaTranslations VALUES(253,1,'0000-00-00 00:00:00','en',13,'srcModuleId','module');
INSERT INTO ejaTranslations VALUES(254,1,'0000-00-00 00:00:00','en',13,'power','power');
INSERT INTO ejaTranslations VALUES(255,1,'0000-00-00 00:00:00','en',16,'ejaModuleId','module');
INSERT INTO ejaTranslations VALUES(256,1,'0000-00-00 00:00:00','en',16,'ejaCommandId','command');
INSERT INTO ejaTranslations VALUES(257,1,'0000-00-00 00:00:00','en',21,'name','name');
INSERT INTO ejaTranslations VALUES(258,1,'0000-00-00 00:00:00','en',21,'value','value');
INSERT INTO ejaTranslations VALUES(259,1,'0000-00-00 00:00:00','en',18,'word','word');
INSERT INTO ejaTranslations VALUES(260,1,'0000-00-00 00:00:00','en',18,'translation','translation');
INSERT INTO ejaTranslations VALUES(261,1,'0000-00-00 00:00:00','en',18,'ejaLanguage','language');
INSERT INTO ejaTranslations VALUES(262,1,'0000-00-00 00:00:00','en',18,'ejaModuleId','module');
INSERT INTO ejaTranslations VALUES(263,1,'0000-00-00 00:00:00','en',15,'defaultModuleId','default module');
INSERT INTO ejaTranslations VALUES(264,1,'0000-00-00 00:00:00','en',15,'ejaSession','session');
INSERT INTO ejaTranslations VALUES(265,1,'0000-00-00 00:00:00','en',15,'ejaOwner','owner');
INSERT INTO ejaTranslations VALUES(266,1,'0000-00-00 00:00:00','en',15,'username','username');
INSERT INTO ejaTranslations VALUES(267,1,'0000-00-00 00:00:00','en',15,'password','password');
INSERT INTO ejaTranslations VALUES(268,1,'0000-00-00 00:00:00','en',15,'ejaLanguage','language');
INSERT INTO ejaTranslations VALUES(269,1,'0000-00-00 00:00:00','en',19,'ejaFileUpload','file name');
INSERT INTO ejaTranslations VALUES(270,1,'0000-00-00 00:00:00','en',19,'name','directory name');
INSERT INTO ejaTranslations VALUES(271,1,'0000-00-00 00:00:00','en',21,'ejaOwner','owner');
INSERT INTO ejaTranslations VALUES(272,1,'0000-00-00 00:00:00','en',0,'new','new');
INSERT INTO ejaTranslations VALUES(273,1,'0000-00-00 00:00:00','en',0,'edit','edit');
INSERT INTO ejaTranslations VALUES(274,1,'0000-00-00 00:00:00','en',0,'previous','<');
INSERT INTO ejaTranslations VALUES(275,1,'0000-00-00 00:00:00','en',0,'next','>');
INSERT INTO ejaTranslations VALUES(276,1,'0000-00-00 00:00:00','en',0,'search','search');
INSERT INTO ejaTranslations VALUES(277,1,'0000-00-00 00:00:00','en',0,'save','save');
INSERT INTO ejaTranslations VALUES(278,1,'0000-00-00 00:00:00','en',0,'copy','copy');
INSERT INTO ejaTranslations VALUES(279,1,'0000-00-00 00:00:00','en',0,'list','list');
INSERT INTO ejaTranslations VALUES(280,1,'0000-00-00 00:00:00','en',0,'delete','delete');
INSERT INTO ejaTranslations VALUES(281,1,'0000-00-00 00:00:00','en',0,'help','help');
INSERT INTO ejaTranslations VALUES(282,1,'0000-00-00 00:00:00','en',0,'link','link');
INSERT INTO ejaTranslations VALUES(283,1,'0000-00-00 00:00:00','en',0,'unlink','unlink');
INSERT INTO ejaTranslations VALUES(289,1,'0000-00-00 00:00:00','en',0,'csvExport','csv');
INSERT INTO ejaTranslations VALUES(291,1,'0000-00-00 00:00:00','en',0,'logout','logout');
INSERT INTO ejaTranslations VALUES(292,1,'0000-00-00 00:00:00','en',0,'alertEdit',' ');
INSERT INTO ejaTranslations VALUES(293,1,'0000-00-00 00:00:00','en',0,'alertListSearch',' ');
INSERT INTO ejaTranslations VALUES(294,1,'0000-00-00 00:00:00','en',0,'alertListList',' ');
INSERT INTO ejaTranslations VALUES(295,1,'0000-00-00 00:00:00','en',0,'alertEditNew','new card created');
INSERT INTO ejaTranslations VALUES(296,1,'0000-00-00 00:00:00','en',0,'alertSearchNew','created');
INSERT INTO ejaTranslations VALUES(297,1,'0000-00-00 00:00:00','en',0,'alertListNew','created');
INSERT INTO ejaTranslations VALUES(298,1,'0000-00-00 00:00:00','en',0,'alertEditEdit',' ');
INSERT INTO ejaTranslations VALUES(299,1,'0000-00-00 00:00:00','en',0,'alertSearchEdit',' ');
INSERT INTO ejaTranslations VALUES(300,1,'0000-00-00 00:00:00','en',0,'alertListEdit',' ');
INSERT INTO ejaTranslations VALUES(301,1,'0000-00-00 00:00:00','en',0,'alertEditPrevious',' ');
INSERT INTO ejaTranslations VALUES(302,1,'0000-00-00 00:00:00','en',0,'alertSearchPrevious',' ');
INSERT INTO ejaTranslations VALUES(303,1,'0000-00-00 00:00:00','en',0,'alertListPrevious',' ');
INSERT INTO ejaTranslations VALUES(304,1,'0000-00-00 00:00:00','en',0,'alertEditNext',' ');
INSERT INTO ejaTranslations VALUES(305,1,'0000-00-00 00:00:00','en',0,'alertSearchNext',' ');
INSERT INTO ejaTranslations VALUES(306,1,'0000-00-00 00:00:00','en',0,'alertListNext',' ');
INSERT INTO ejaTranslations VALUES(307,1,'0000-00-00 00:00:00','en',0,'alertEditSearch',' ');
INSERT INTO ejaTranslations VALUES(308,1,'0000-00-00 00:00:00','en',0,'alertSearchSearch',' ');
INSERT INTO ejaTranslations VALUES(309,1,'0000-00-00 00:00:00','en',0,'alertListSearch',' ');
INSERT INTO ejaTranslations VALUES(310,1,'0000-00-00 00:00:00','en',0,'alertEditSave','card saved');
INSERT INTO ejaTranslations VALUES(311,1,'0000-00-00 00:00:00','en',0,'alertSearchSave',' ');
INSERT INTO ejaTranslations VALUES(312,1,'0000-00-00 00:00:00','en',0,'alertListSave',' ');
INSERT INTO ejaTranslations VALUES(313,1,'0000-00-00 00:00:00','en',0,'alertEditCopy','card copied');
INSERT INTO ejaTranslations VALUES(314,1,'0000-00-00 00:00:00','en',0,'alertSearchCopy',' ');
INSERT INTO ejaTranslations VALUES(315,1,'0000-00-00 00:00:00','en',0,'alertListCopy',' ');
INSERT INTO ejaTranslations VALUES(316,1,'0000-00-00 00:00:00','en',0,'alertEditList',' ');
INSERT INTO ejaTranslations VALUES(317,1,'0000-00-00 00:00:00','en',0,'alertSearchList',' ');
INSERT INTO ejaTranslations VALUES(318,1,'0000-00-00 00:00:00','en',0,'alertListList',' ');
INSERT INTO ejaTranslations VALUES(319,1,'0000-00-00 00:00:00','en',0,'alertEditDelete','card removed');
INSERT INTO ejaTranslations VALUES(320,1,'0000-00-00 00:00:00','en',0,'alertSearchDelete','card removed');
INSERT INTO ejaTranslations VALUES(321,1,'0000-00-00 00:00:00','en',0,'alertListDelete','card removed');
INSERT INTO ejaTranslations VALUES(322,1,'0000-00-00 00:00:00','en',0,'alertEditHelp',' ');
INSERT INTO ejaTranslations VALUES(323,1,'0000-00-00 00:00:00','en',0,'alertSearchHelp',' ');
INSERT INTO ejaTranslations VALUES(324,1,'0000-00-00 00:00:00','en',0,'alertListHelp',' ');
INSERT INTO ejaTranslations VALUES(325,1,'0000-00-00 00:00:00','en',0,'alertEditSql','sql done');
INSERT INTO ejaTranslations VALUES(326,1,'0000-00-00 00:00:00','en',0,'alertSearchSql',' ');
INSERT INTO ejaTranslations VALUES(327,1,'0000-00-00 00:00:00','en',0,'alertListSql',' ');
INSERT INTO ejaTranslations VALUES(328,1,'0000-00-00 00:00:00','en',0,'alertEditLink',' ');
INSERT INTO ejaTranslations VALUES(329,1,'0000-00-00 00:00:00','en',0,'alertSearchLink',' ');
INSERT INTO ejaTranslations VALUES(330,1,'0000-00-00 00:00:00','en',0,'alertListLink','linked');
INSERT INTO ejaTranslations VALUES(331,1,'0000-00-00 00:00:00','en',0,'alertEditUnlink',' ');
INSERT INTO ejaTranslations VALUES(332,1,'0000-00-00 00:00:00','en',0,'alertSearchUnlink',' ');
INSERT INTO ejaTranslations VALUES(333,1,'0000-00-00 00:00:00','en',0,'alertListUnlink','unlinked');
INSERT INTO ejaTranslations VALUES(334,1,'0000-00-00 00:00:00','en',0,'alertEditFileDownload',' ');
INSERT INTO ejaTranslations VALUES(335,1,'0000-00-00 00:00:00','en',0,'alertSearchFileDownload',' ');
INSERT INTO ejaTranslations VALUES(336,1,'0000-00-00 00:00:00','en',0,'alertListFileDownload',' ');
INSERT INTO ejaTranslations VALUES(337,1,'0000-00-00 00:00:00','en',0,'alertEditFileUpload',' ');
INSERT INTO ejaTranslations VALUES(338,1,'0000-00-00 00:00:00','en',0,'alertSearchFileUpload',' ');
INSERT INTO ejaTranslations VALUES(339,1,'0000-00-00 00:00:00','en',0,'alertListFileUpload',' ');
INSERT INTO ejaTranslations VALUES(340,1,'0000-00-00 00:00:00','en',0,'alertEditFileDelete','removed');
INSERT INTO ejaTranslations VALUES(341,1,'0000-00-00 00:00:00','en',0,'alertSearchFileDelete',' ');
INSERT INTO ejaTranslations VALUES(342,1,'0000-00-00 00:00:00','en',0,'alertListFileDelete',' ');
INSERT INTO ejaTranslations VALUES(343,1,'0000-00-00 00:00:00','en',0,'alertEditFileMove','moved');
INSERT INTO ejaTranslations VALUES(344,1,'0000-00-00 00:00:00','en',0,'alertSearchFileMove',' ');
INSERT INTO ejaTranslations VALUES(345,1,'0000-00-00 00:00:00','en',0,'alertListFileMove',' ');
INSERT INTO ejaTranslations VALUES(346,1,'0000-00-00 00:00:00','en',0,'alertEditFileNew','directory created');
INSERT INTO ejaTranslations VALUES(347,1,'0000-00-00 00:00:00','en',0,'alertSearchFileNew',' ');
INSERT INTO ejaTranslations VALUES(348,1,'0000-00-00 00:00:00','en',0,'alertListFileNew',' ');
INSERT INTO ejaTranslations VALUES(349,1,'0000-00-00 00:00:00','en',0,'alertEditCsvExport',' ');
INSERT INTO ejaTranslations VALUES(350,1,'0000-00-00 00:00:00','en',0,'alertSearchCsvExport',' ');
INSERT INTO ejaTranslations VALUES(351,1,'0000-00-00 00:00:00','en',0,'alertListCsvExport',' ');
INSERT INTO ejaTranslations VALUES(352,1,'0000-00-00 00:00:00','en',0,'confirm?','confirm?');
INSERT INTO ejaTranslations VALUES(353,1,'0000-00-00 00:00:00','en',19,'ejaUp','[back]');
INSERT INTO ejaTranslations VALUES(354,1,'0000-00-00 00:00:00','en',0,'alertListSearchLink',' ');
INSERT INTO ejaTranslations VALUES(355,1,'0000-00-00 00:00:00','en',0,'alertSearchLogin',' ');
INSERT INTO ejaTranslations VALUES(356,1,'0000-00-00 00:00:00','en',19,'fileName','files ');
INSERT INTO ejaTranslations VALUES(357,1,'0000-00-00 00:00:00','en',0,'alertSearchLogout',' ');
INSERT INTO ejaTranslations VALUES(358,1,'0000-00-00 00:00:00','en',0,'back','back');
INSERT INTO ejaTranslations VALUES(359,1,'0000-00-00 00:00:00','en',0,'linkBack','close linking');
INSERT INTO ejaTranslations VALUES(360,1,'0000-00-00 00:00:00','en',0,'alertSearchSearchLink',' ');
INSERT INTO ejaTranslations VALUES(361,1,'0000-00-00 00:00:00','en',1,'login','login');
INSERT INTO ejaTranslations VALUES(362,1,'0000-00-00 00:00:00','en',1,'username','username');
INSERT INTO ejaTranslations VALUES(363,1,'0000-00-00 00:00:00','en',1,'password','password');
INSERT INTO ejaTranslations VALUES(385,1,'0000-00-00 00:00:00','en',1,'ejaLogin','intranet');
INSERT INTO ejaTranslations VALUES(387,1,'0000-00-00 00:00:00','en',0,'sql','sql');
INSERT INTO ejaTranslations VALUES(388,1,'0000-00-00 00:00:00','en',17,'defaultCommand','default');
INSERT INTO ejaTranslations VALUES(389,1,'0000-00-00 00:00:00','en',6,'ejaGroup','edit group');
INSERT INTO ejaTranslations VALUES(390,1,'0000-00-00 00:00:00','en',21,'sub','sub');
INSERT INTO ejaTranslations VALUES(393,1,'2007-09-26 16:33:07','it',27,'query','query');
INSERT INTO ejaTranslations VALUES(394,1,'2007-09-26 16:33:22','en',27,'query','query');
INSERT INTO ejaTranslations VALUES(396,1,'2007-09-27 16:51:32','en',0,'view','view');
INSERT INTO ejaTranslations VALUES(397,1,'2007-09-27 16:52:01','en',0,'alertEditView',' ');
INSERT INTO ejaTranslations VALUES(398,1,'2007-10-02 09:35:09','en',0,'ejaModuleLinks','Module Links');
INSERT INTO ejaTranslations VALUES(399,1,'2007-10-02 09:36:04','en',34,'dstModuleId','module');
INSERT INTO ejaTranslations VALUES(400,1,'2007-10-02 09:36:12','en',34,'srcModuleId','link');
INSERT INTO ejaTranslations VALUES(401,1,'2007-10-02 09:36:25','en',34,'power','order');
INSERT INTO ejaTranslations VALUES(402,1,'2007-10-02 17:07:45','en',0,'ejaStructure','Structure');
INSERT INTO ejaTranslations VALUES(403,1,'2007-10-02 17:08:07','en',0,'eja','Tibula');
INSERT INTO ejaTranslations VALUES(405,1,'2007-10-25 10:29:59','en',0,'run','run');
INSERT INTO ejaTranslations VALUES(406,1,'2007-10-25 10:30:14','en',0,'ejaBackups','Backups');
INSERT INTO ejaTranslations VALUES(407,1,'2007-10-26 18:11:12','en',0,'xmlExport','xml');
INSERT INTO ejaTranslations VALUES(408,1,'2007-10-26 18:11:35','en',36,'run','xml');
INSERT INTO ejaTranslations VALUES(409,1,'2007-10-26 18:15:28','en',36,'ejaBackupImportOk','xml imported.');
INSERT INTO ejaTranslations VALUES(410,1,'2007-10-26 18:16:58','en',36,'ejaBackupImportError','xml <b>not</b> imported.');
INSERT INTO ejaTranslations VALUES(411,1,'2007-10-26 18:17:21','en',36,'ejaFileUpload','xml file');
INSERT INTO ejaTranslations VALUES(412,1,'2007-10-29 11:33:19','en',0,'alertSearchRun',' ');
INSERT INTO ejaTranslations VALUES(413,1,'2007-10-29 11:33:47','en',36,'import','Import');
INSERT INTO ejaTranslations VALUES(414,1,'2007-10-29 11:33:55','en',36,'export','Export');
INSERT INTO ejaTranslations VALUES(415,1,'2007-10-29 11:34:06','en',36,'name','module name');
INSERT INTO ejaTranslations VALUES(416,1,'2007-10-29 11:34:23','en',36,'changeEjaId','append');
INSERT INTO ejaTranslations VALUES(417,1,'2007-10-29 11:34:36','en',36,'changeEjaOwner','owner reset');
INSERT INTO ejaTranslations VALUES(418,1,'2007-10-29 12:58:57','en',36,'moduleStructure','module structure');
INSERT INTO ejaTranslations VALUES(419,1,'2007-10-29 15:48:49','en',0,'alertSearchLinkBack',' ');
INSERT INTO ejaTranslations VALUES(421,1,'2007-11-05 14:59:40','en',0,'ejaSqlTableCreate','Sql table created. ');
INSERT INTO ejaTranslations VALUES(422,1,'2007-11-05 14:59:54','en',0,'ejaSqlTableAlter','Sql table altered. ');
INSERT INTO ejaTranslations VALUES(423,1,'2007-11-05 15:00:31','en',0,'ejaSqlFieldCreate','Sql field added. ');
INSERT INTO ejaTranslations VALUES(433,1,'2008-01-17 12:10:48','en',27,'ejaLogTo','to');
INSERT INTO ejaTranslations VALUES(434,1,'2008-01-17 12:11:26','en',27,'ejaLogFrom','from');
INSERT INTO ejaTranslations VALUES(435,1,'2008-01-17 12:28:00','en',5,'ejaSqlTableCreated','sql table created. ');
INSERT INTO ejaTranslations VALUES(436,1,'2008-01-17 12:29:09','en',6,'ejaSqlFieldCreated','sql field created. ');
INSERT INTO ejaTranslations VALUES(437,1,'2008-01-17 12:46:40','en',0,'powerLink','linked');
INSERT INTO ejaTranslations VALUES(518,1,'2008-02-20 12:53:57','en',6,'matrixUpdate','update matrix');
INSERT INTO ejaTranslations VALUES(519,1,'2008-02-20 12:54:51','en',0,'update','update');
INSERT INTO ejaTranslations VALUES(525,1,'2008-03-03 11:54:33','en',17,'linking','linkable');
INSERT INTO ejaTranslations VALUES(526,1,'2008-03-03 11:57:36','en',0,'send','send');
INSERT INTO ejaTranslations VALUES(528,1,'2008-03-03 16:36:10','en',0,'runEdit','run');
INSERT INTO ejaTranslations VALUES(529,1,'2008-03-03 16:36:30','en',0,'runSearch','run');
INSERT INTO ejaTranslations VALUES(530,1,'2008-03-03 16:36:34','en',0,'runList','run');
INSERT INTO ejaTranslations VALUES(533,1,'2008-03-05 10:34:30','en',27,'ejaLog','log');
INSERT INTO ejaTranslations VALUES(544,1,'2008-03-27 15:49:29','en',0,'ejaSqlTableAlterError','table not altered.');
INSERT INTO ejaTranslations VALUES(545,1,'2008-03-28 17:03:53','en',0,'alertEditSearchLink',' ');
INSERT INTO ejaTranslations VALUES(546,1,'2008-03-28 19:17:53','en',0,'ejaTo','to');
INSERT INTO ejaTranslations VALUES(547,1,'2008-03-28 19:18:53','en',0,'ejaFrom','from');
INSERT INTO ejaTranslations VALUES(548,1,'2008-03-29 20:00:59','en',0,'ejaRoot','Home');
INSERT INTO ejaTranslations VALUES(549,1,'2008-04-04 12:34:17','en',0,'alertEditRunEdit',' ');
INSERT INTO ejaTranslations VALUES(552,1,'2008-04-09 20:19:52','de',0,'alertEditRunEdit','ProgrammAlarm');
INSERT INTO ejaTranslations VALUES(553,1,'2008-04-09 20:20:49','de',0,'ejaRoot','<');
INSERT INTO ejaTranslations VALUES(554,1,'2008-04-09 20:21:24','de',0,'ejaFrom','von');
INSERT INTO ejaTranslations VALUES(555,1,'2008-04-09 20:21:41','de',0,'ejaTo','bis');
INSERT INTO ejaTranslations VALUES(556,1,'2008-04-09 20:22:07','de',0,'alertEditSearchLink','Fehlender Link');
INSERT INTO ejaTranslations VALUES(557,1,'2008-04-09 20:22:59','de',0,'ejaSqlTableAlterError','Tabelle NICHT geändert');
INSERT INTO ejaTranslations VALUES(568,1,'2008-04-09 20:36:04','de',27,'ejaLog','Log');
INSERT INTO ejaTranslations VALUES(571,1,'2008-04-09 20:37:21','de',0,'send','absenden');
INSERT INTO ejaTranslations VALUES(572,1,'2008-04-09 20:37:48','de',17,'linking','verknüpfbar');
INSERT INTO ejaTranslations VALUES(578,1,'2008-04-09 20:40:26','de',0,'update','aktualisieren');
INSERT INTO ejaTranslations VALUES(579,1,'2008-04-09 20:41:41','de',6,'matrixUpdate','Tabelle aktualisieren');
INSERT INTO ejaTranslations VALUES(597,1,'2008-04-09 20:49:25','de',0,'powerLink','verknüpfen');
INSERT INTO ejaTranslations VALUES(598,1,'2008-04-09 20:59:31','de',6,'ejaSqlFieldCreated','sql field created. ');
INSERT INTO ejaTranslations VALUES(599,1,'2008-04-09 20:59:42','de',5,'ejaSqlTableCreated','sql table created. ');
INSERT INTO ejaTranslations VALUES(657,1,'2008-04-15 14:38:15','de',0,'ejaSqlFieldCreate','Sql field added. ');
INSERT INTO ejaTranslations VALUES(658,1,'2008-04-15 14:38:24','de',0,'ejaSqlTableAlter','Sql table altered. ');
INSERT INTO ejaTranslations VALUES(659,1,'2008-04-15 14:38:32','de',0,'ejaSqlTableCreate','Sql table created. ');
INSERT INTO ejaTranslations VALUES(661,1,'2008-04-15 14:38:53','de',0,'alertSearchLinkBack',' ');
INSERT INTO ejaTranslations VALUES(662,1,'2008-04-15 14:39:02','de',36,'moduleStructure','module structure');
INSERT INTO ejaTranslations VALUES(663,1,'2008-04-15 14:39:11','de',36,'changeEjaOwner','owner reset');
INSERT INTO ejaTranslations VALUES(664,1,'2008-04-15 14:39:19','de',36,'changeEjaId','append');
INSERT INTO ejaTranslations VALUES(665,1,'2008-04-15 14:39:33','de',36,'changeEjaId','append');
INSERT INTO ejaTranslations VALUES(666,1,'2008-04-15 14:39:44','de',36,'name','module name');
INSERT INTO ejaTranslations VALUES(667,1,'2008-04-15 14:39:53','de',36,'export','Export');
INSERT INTO ejaTranslations VALUES(668,1,'2008-04-15 14:40:02','de',36,'import','Import');
INSERT INTO ejaTranslations VALUES(669,1,'2008-04-15 14:40:10','de',0,'alertSearchRun',' ');
INSERT INTO ejaTranslations VALUES(670,1,'2008-04-15 14:40:19','de',36,'ejaFileUpload','xml file');
INSERT INTO ejaTranslations VALUES(671,1,'2008-04-15 14:40:28','de',36,'ejaBackupImportError','xml <b>not</b> imported.');
INSERT INTO ejaTranslations VALUES(672,1,'2008-04-15 14:40:38','de',36,'ejaBackupImportOk','xml imported.');
INSERT INTO ejaTranslations VALUES(673,1,'2008-04-15 14:40:48','de',36,'run','xml');
INSERT INTO ejaTranslations VALUES(674,1,'2008-04-15 14:40:58','de',0,'xmlExport','xml');
INSERT INTO ejaTranslations VALUES(675,1,'2008-04-15 14:41:05','de',0,'ejaBackups','Backups');
INSERT INTO ejaTranslations VALUES(676,1,'2008-04-15 14:41:14','de',0,'run','run');
INSERT INTO ejaTranslations VALUES(678,1,'2008-04-15 14:41:34','de',0,'eja','Tibula');
INSERT INTO ejaTranslations VALUES(679,1,'2008-04-15 14:41:44','de',0,'ejaStructure','Struktur');
INSERT INTO ejaTranslations VALUES(680,1,'2008-04-15 14:41:58','de',34,'power','Reihenfolge');
INSERT INTO ejaTranslations VALUES(681,1,'2008-04-15 14:42:20','de',34,'srcModuleId','link');
INSERT INTO ejaTranslations VALUES(682,1,'2008-04-15 14:42:33','de',34,'dstModuleId','module');
INSERT INTO ejaTranslations VALUES(683,1,'2008-04-15 14:42:45','de',0,'ejaModuleLinks','Module Links');
INSERT INTO ejaTranslations VALUES(684,1,'2008-04-15 21:26:55','de',0,'alertEditView',' ');
INSERT INTO ejaTranslations VALUES(685,1,'2008-04-15 21:27:04','de',0,'view','Ansicht');
INSERT INTO ejaTranslations VALUES(687,1,'2008-04-15 21:27:41','de',27,'query','Abfrage');
INSERT INTO ejaTranslations VALUES(688,1,'2008-04-15 21:27:55','de',0,'alertSearch',' ');
INSERT INTO ejaTranslations VALUES(689,1,'2008-04-15 21:28:03','de',0,'ejaSystem','System');
INSERT INTO ejaTranslations VALUES(690,1,'2008-04-15 21:28:14','de',0,'ejaTools','Werkzeuge');
INSERT INTO ejaTranslations VALUES(691,1,'2008-04-15 21:28:37','de',0,'ejaHelps','Hilfen');
INSERT INTO ejaTranslations VALUES(692,1,'2008-04-15 21:28:56','de',0,'ejaTranslations','&Uuml;bersetzung');
INSERT INTO ejaTranslations VALUES(693,1,'2008-04-15 21:29:32','de',0,'ejaLanguages','Sprachen');
INSERT INTO ejaTranslations VALUES(694,1,'2008-04-15 21:29:51','de',0,'ejaFiles','Dateien');
INSERT INTO ejaTranslations VALUES(695,1,'2008-04-15 21:30:20','de',0,'ejaSql','Sql');
INSERT INTO ejaTranslations VALUES(696,1,'2008-04-15 21:30:32','de',0,'ejaSessions','Sitzungen');
INSERT INTO ejaTranslations VALUES(697,1,'2008-04-15 21:30:51','de',0,'ejaModules','Module');
INSERT INTO ejaTranslations VALUES(698,1,'2008-04-15 21:31:03','de',0,'ejaFields','Felder');
INSERT INTO ejaTranslations VALUES(699,1,'2008-04-15 21:31:17','de',0,'ejaCommands','Kommandos');
INSERT INTO ejaTranslations VALUES(700,1,'2008-04-15 21:31:32','de',0,'ejaPermissions','Berechtigungen');
INSERT INTO ejaTranslations VALUES(701,1,'2008-04-15 21:31:50','de',0,'ejaGroups','Gruppen');
INSERT INTO ejaTranslations VALUES(702,1,'2008-04-15 21:32:08','de',0,'ejaUsers','Benutzer');
INSERT INTO ejaTranslations VALUES(703,1,'2008-04-15 21:32:27','de',0,'ejaLinks','Verlinkungen');
INSERT INTO ejaTranslations VALUES(704,1,'2008-04-15 21:32:45','de',0,'ejaAdministration','Administration');
INSERT INTO ejaTranslations VALUES(705,1,'2008-04-15 21:32:57','de',5,'name','Name');
INSERT INTO ejaTranslations VALUES(706,1,'2008-04-15 21:33:11','de',5,'parentId','Vater');
INSERT INTO ejaTranslations VALUES(707,1,'2008-04-15 21:33:37','de',17,'name','Name');
INSERT INTO ejaTranslations VALUES(708,1,'2008-04-15 21:33:49','de',5,'power','Reihenfolge');
INSERT INTO ejaTranslations VALUES(709,1,'2008-04-15 21:34:25','de',5,'searchLimit','Ergebniszeilen');
INSERT INTO ejaTranslations VALUES(710,1,'2008-04-15 21:34:58','de',5,'sqlCreated','SQL');
INSERT INTO ejaTranslations VALUES(711,1,'2008-04-15 21:35:12','de',17,'powerSearch','Suchfolge');
INSERT INTO ejaTranslations VALUES(712,1,'2008-04-15 21:35:55','de',17,'powerEdit','Bearbeitungsfolge');
INSERT INTO ejaTranslations VALUES(713,1,'2008-04-15 21:36:20','de',17,'powerList','Ansichtenfolge');
INSERT INTO ejaTranslations VALUES(714,1,'2008-04-15 21:36:42','de',6,'ejaModuleId','Modul');
INSERT INTO ejaTranslations VALUES(715,1,'2008-04-15 21:36:55','de',6,'type','Typ');
INSERT INTO ejaTranslations VALUES(716,1,'2008-04-15 21:37:39','de',6,'value','Werte');
INSERT INTO ejaTranslations VALUES(717,1,'2008-04-15 22:43:30','de',6,'powerEdit','Bearbeitungsfolge');
INSERT INTO ejaTranslations VALUES(718,1,'2008-04-15 22:43:59','de',6,'powerList','Ansichtenfolge');
INSERT INTO ejaTranslations VALUES(719,1,'2008-04-15 22:44:19','de',6,'powerSearch','Suchfolge');
INSERT INTO ejaTranslations VALUES(720,1,'2008-04-15 22:44:49','de',6,'sqlType','sql type');
INSERT INTO ejaTranslations VALUES(721,1,'2008-04-15 22:45:04','de',6,'translate','übersetzen');
INSERT INTO ejaTranslations VALUES(722,1,'2008-04-15 22:45:25','de',6,'name','Name');
INSERT INTO ejaTranslations VALUES(723,1,'2008-04-15 22:45:40','de',14,'name','Name');
INSERT INTO ejaTranslations VALUES(724,1,'2008-04-15 22:45:56','de',14,'note','Anmerkung');
INSERT INTO ejaTranslations VALUES(725,1,'2008-04-15 22:46:14','de',20,'ejaModuleId','Modul');
INSERT INTO ejaTranslations VALUES(726,1,'2008-04-15 22:46:48','de',20,'actionType','Gruppe');
INSERT INTO ejaTranslations VALUES(727,1,'2008-04-15 22:47:20','de',20,'ejaLanguage','Sprache');
INSERT INTO ejaTranslations VALUES(728,1,'2008-04-15 22:47:57','de',20,'text','Inhalt');
INSERT INTO ejaTranslations VALUES(729,1,'2008-04-15 22:48:34','de',24,'name','Kurzwort');
INSERT INTO ejaTranslations VALUES(730,1,'2008-04-15 22:49:33','de',24,'nameFull','Name');
INSERT INTO ejaTranslations VALUES(731,1,'2008-04-15 22:49:51','de',24,'note','Anmerkung');
INSERT INTO ejaTranslations VALUES(732,1,'2008-04-15 22:50:35','de',13,'dstModuleId','verknüpftes Modul');
INSERT INTO ejaTranslations VALUES(733,1,'2008-04-15 22:50:55','de',13,'dstFieldId','verknüpftes Feld');
INSERT INTO ejaTranslations VALUES(734,1,'2008-04-15 22:51:16','de',13,'srcFieldId','Feld');
INSERT INTO ejaTranslations VALUES(735,1,'2008-04-15 22:51:33','de',13,'srcModuleId','Modul');
INSERT INTO ejaTranslations VALUES(736,1,'2008-04-15 22:51:47','de',13,'power','Reihenfolge');
INSERT INTO ejaTranslations VALUES(737,1,'2008-04-15 22:52:16','de',16,'ejaModuleId','Modul');
INSERT INTO ejaTranslations VALUES(738,1,'2008-04-15 22:52:38','de',16,'ejaCommandId','Befehl');
INSERT INTO ejaTranslations VALUES(739,1,'2008-04-15 22:52:52','de',21,'name','Name');
INSERT INTO ejaTranslations VALUES(740,1,'2008-04-15 22:53:43','de',21,'value','Wert');
INSERT INTO ejaTranslations VALUES(741,1,'2008-04-15 22:54:01','de',18,'word','Begriff');
INSERT INTO ejaTranslations VALUES(742,1,'2008-04-15 22:54:42','de',18,'translation','Übersetzung');
INSERT INTO ejaTranslations VALUES(743,1,'2008-04-15 22:55:07','de',18,'ejaLanguage','Sprache');
INSERT INTO ejaTranslations VALUES(744,1,'2008-04-15 22:55:21','de',18,'ejaModuleId','Modul');
INSERT INTO ejaTranslations VALUES(745,1,'2008-04-15 22:55:53','de',15,'defaultModuleId','Standardmodul');
INSERT INTO ejaTranslations VALUES(746,1,'2008-04-15 22:57:16','de',15,'ejaSession','Sitzung');
INSERT INTO ejaTranslations VALUES(747,1,'2008-04-15 22:57:48','de',15,'ejaOwner','Eigentümer');
INSERT INTO ejaTranslations VALUES(748,1,'2008-04-15 22:58:04','de',15,'username','Benutzername');
INSERT INTO ejaTranslations VALUES(749,1,'2008-04-15 22:58:18','de',15,'password','Kennwort');
INSERT INTO ejaTranslations VALUES(750,1,'2008-04-15 22:58:35','de',15,'ejaLanguage','Sprache');
INSERT INTO ejaTranslations VALUES(751,1,'2008-04-15 22:58:48','de',19,'ejaFileUpload','Dateiname');
INSERT INTO ejaTranslations VALUES(752,1,'2008-04-15 23:00:14','de',19,'name','Verzeichnisname');
INSERT INTO ejaTranslations VALUES(753,1,'2008-04-15 23:00:37','de',21,'ejaOwner','Eigentümer');
INSERT INTO ejaTranslations VALUES(754,1,'2008-04-15 23:00:56','de',0,'new','neu');
INSERT INTO ejaTranslations VALUES(755,1,'2008-04-15 23:01:10','de',0,'edit','bearbeiten');
INSERT INTO ejaTranslations VALUES(756,1,'2008-04-15 23:01:41','de',0,'previous','<');
INSERT INTO ejaTranslations VALUES(757,1,'2008-04-15 23:02:16','de',0,'next','>');
INSERT INTO ejaTranslations VALUES(758,1,'2008-04-15 23:02:31','de',0,'search','Suche');
INSERT INTO ejaTranslations VALUES(759,1,'2008-04-15 23:02:47','de',0,'save','speichern');
INSERT INTO ejaTranslations VALUES(760,1,'2008-04-15 23:03:45','de',0,'copy','kopieren');
INSERT INTO ejaTranslations VALUES(761,1,'2008-04-15 23:04:12','de',0,'list','Liste');
INSERT INTO ejaTranslations VALUES(762,1,'2008-04-15 23:06:00','de',0,'delete','löschen');
INSERT INTO ejaTranslations VALUES(763,1,'2008-04-15 23:06:11','de',0,'help','Hilfe');
INSERT INTO ejaTranslations VALUES(764,1,'2008-04-15 23:06:27','de',0,'link','Verknüpfung');
INSERT INTO ejaTranslations VALUES(765,1,'2008-04-15 23:07:10','de',0,'unlink','trennen');
INSERT INTO ejaTranslations VALUES(771,1,'2008-04-15 23:15:01','de',0,'logout','abmelden');
INSERT INTO ejaTranslations VALUES(772,1,'2008-04-15 23:15:25','de',0,'alertEditNew','Datensatz angelegt');
INSERT INTO ejaTranslations VALUES(773,1,'2008-04-15 23:16:05','de',0,'alertSearchNew','angelegt');
INSERT INTO ejaTranslations VALUES(774,1,'2008-04-15 23:16:27','de',0,'alertListNew','angelegt');
INSERT INTO ejaTranslations VALUES(775,1,'2008-04-15 23:16:52','de',0,'alertEditSave','Datensatz gespeichert');
INSERT INTO ejaTranslations VALUES(776,1,'2008-04-15 23:17:10','de',0,'alertEditCopy','Datensatz kopiert');
INSERT INTO ejaTranslations VALUES(777,1,'2008-04-15 23:17:55','de',0,'alertEditDelete','Datensatz gelöscht');
INSERT INTO ejaTranslations VALUES(778,1,'2008-04-15 23:18:12','de',0,'alertSearchDelete','Datensatz gelöscht');
INSERT INTO ejaTranslations VALUES(779,1,'2008-04-15 23:20:01','de',0,'alertListDelete','Datensatz gelöscht');
INSERT INTO ejaTranslations VALUES(780,1,'2008-04-15 23:21:21','de',0,'alertEditSql','sql ausgeführt');
INSERT INTO ejaTranslations VALUES(781,1,'2008-04-15 23:22:07','de',0,'alertListLink','verknüpft');
INSERT INTO ejaTranslations VALUES(782,1,'2008-04-15 23:22:47','de',0,'alertListUnlink','Verknüpfung getrennt');
INSERT INTO ejaTranslations VALUES(783,1,'2008-04-15 23:23:22','de',0,'alertEditFileDelete','gelöscht');
INSERT INTO ejaTranslations VALUES(784,1,'2008-04-15 23:23:35','en',0,'alertEditFileMove','moved');
INSERT INTO ejaTranslations VALUES(785,1,'2008-04-15 23:34:17','de',0,'alertEditFileMove','verschoben');
INSERT INTO ejaTranslations VALUES(786,1,'2008-04-15 23:35:34','de',0,'alertEditFileNew','Verzeichnis erstellt');
INSERT INTO ejaTranslations VALUES(787,1,'2008-04-15 23:36:04','de',0,'confirm?','Bestätigung?');
INSERT INTO ejaTranslations VALUES(788,1,'2008-04-15 23:36:21','de',19,'ejaUp','Vater');
INSERT INTO ejaTranslations VALUES(789,1,'2008-04-15 23:37:22','de',19,'fileName','Datei');
INSERT INTO ejaTranslations VALUES(790,1,'2008-04-15 23:37:48','de',0,'back','zurück');
INSERT INTO ejaTranslations VALUES(791,1,'2008-04-15 23:38:29','de',0,'linkBack','Verknüpfung beenden');
INSERT INTO ejaTranslations VALUES(792,1,'2008-04-15 23:39:22','de',1,'login','Anmeldung');
INSERT INTO ejaTranslations VALUES(793,1,'2008-04-15 23:39:36','de',1,'username','Benutzername');
INSERT INTO ejaTranslations VALUES(794,1,'2008-04-15 23:39:49','de',1,'password','Kennwort');
INSERT INTO ejaTranslations VALUES(817,1,'2008-04-15 23:53:57','de',1,'ejaLogin','Intranet');
INSERT INTO ejaTranslations VALUES(819,1,'2008-04-15 23:54:29','de',0,'sql','SQL');
INSERT INTO ejaTranslations VALUES(820,1,'2008-04-15 23:55:24','de',17,'defaultCommand','Vorgabe');
INSERT INTO ejaTranslations VALUES(821,1,'2008-04-15 23:55:44','de',6,'ejaGroup','Gruppe editieren');
INSERT INTO ejaTranslations VALUES(822,1,'2008-04-15 23:56:03','de',21,'sub','unter');
INSERT INTO ejaTranslations VALUES(824,1,'2008-04-16 00:07:50','de',0,'alertSearchLogin',' ');
INSERT INTO ejaTranslations VALUES(825,1,'2008-04-16 00:09:49','de',0,'alertListSearch',' ');
INSERT INTO ejaTranslations VALUES(826,1,'2008-04-16 00:10:12','de',0,'alertListList',' ');
INSERT INTO ejaTranslations VALUES(827,1,'2008-04-16 00:11:05','de',0,'alertSearchLogout',' ');
INSERT INTO ejaTranslations VALUES(828,1,'2008-04-16 00:12:47','de',0,'alertSearchSearch',' ');
INSERT INTO ejaTranslations VALUES(829,1,'2008-04-16 00:13:57','de',0,'alertEditEdit',' ');
INSERT INTO ejaTranslations VALUES(830,1,'2008-04-16 00:14:55','de',0,'alertListNext',' ');
INSERT INTO ejaTranslations VALUES(831,1,'2008-04-16 00:15:26','de',0,'alertListPrevious',' ');
INSERT INTO ejaTranslations VALUES(832,1,'2008-04-16 00:16:05','de',0,'alertListSave',' ');
INSERT INTO ejaTranslations VALUES(833,1,'2008-04-16 00:18:44','de',0,'runEdit','los');
INSERT INTO ejaTranslations VALUES(835,1,'2008-04-18 17:09:45','de',0,'alertListSearchLink',' ');
INSERT INTO ejaTranslations VALUES(851,1,'2008-05-08 12:11:20','en',19,'fileZip','zip');
INSERT INTO ejaTranslations VALUES(852,1,'2008-05-08 12:11:42','en',19,'fileUnzip','unzip');
INSERT INTO ejaTranslations VALUES(853,1,'2008-05-08 12:53:31','en',19,'ejaFilesZipAlert',' ');
INSERT INTO ejaTranslations VALUES(854,1,'2008-05-08 12:53:57','en',19,'ejaFilesUnzipAlert',' ');
INSERT INTO ejaTranslations VALUES(855,1,'2010-01-28 09:46:07','en',0,'ejaDateFrom','from');
INSERT INTO ejaTranslations VALUES(856,1,'2010-01-28 09:46:07','en',0,'ejaDateTo','to');
COMMIT;

/* change password update */
INSERT INTO ejaFields VALUES(NULL,1,'2016-01-28 10:54:03',2,'passwordOld','password','',10,0,0,0,'',0);
INSERT INTO ejaFields VALUES(NULL,1,'2016-01-28 10:54:30',2,'passwordNew','password','',20,0,0,0,'',0);
INSERT INTO ejaFields VALUES(NULL,1,'2016-01-28 10:54:46',2,'passwordNewRepeat','password','',30,0,0,0,'',0);
INSERT INTO ejaLinks VALUES(NULL,1,'2016-01-28 10:05:40',16,70,15,13,1);
INSERT INTO ejaLinks VALUES(NULL,1,'2016-01-28 10:05:40',16,71,15,13,1);
UPDATE ejaModules SET lua='if ejaNumber(tibulaModuleLuaStep)==0 and ejaNumber(tibula.ejaOwner) > 0 and ejaString(tibula.ejaAction)=="run" then
  if ejaString(tibula.ejaValues.passwordOld)~="" and ejaString(tibula.ejaValues.passwordNew)~="" and ejaString(tibula.ejaValues.passwordNew)==ejaString(tibula.ejaValues.passwordNewRepeat) then
   if ejaSqlRun("UPDATE ejaUsers SET password=''%s'' WHERE ejaId=%d AND (password=''%s'' OR password=''%s'');",ejaSha256(tibula.ejaValues.passwordNew),tibula.ejaOwner,ejaSha256(tibula.ejaValues.passwordOld),tibula.ejaValues.passwordOld) then
    tibulaInfo("Password changed")
   end
  else
   tibulaInfo("Password problem")
  end
 end
 ' WHERE ejaId=2;
UPDATE ejaPermissions SET ejaCommandId=13 where ejaId=71;

