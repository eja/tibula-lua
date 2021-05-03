BEGIN;
CREATE TABLE ejaCommands (
  ejaId INTEGER NOT NULL PRIMARY KEY,
  ejaOwner int default 0,
  ejaLog datetime default NULL,
  name varchar(32) default NULL,
  powerSearch integer default 0,
  powerList integer default 0,
  powerEdit integer default 0,
  defaultCommand integer default 0,
  linking integer default 0
);
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
INSERT INTO ejaCommands VALUES(13,1,'0000-00-00 00:00:00','run',2,2,2,0,0);
INSERT INTO ejaCommands VALUES(14,1,'0000-00-00 00:00:00','link',0,3,3,0,1);
INSERT INTO ejaCommands VALUES(15,1,'0000-00-00 00:00:00','unlink',0,6,0,0,1);
INSERT INTO ejaCommands VALUES(30,1,'2008-02-20 12:53:14','update',0,2,0,0,0);
INSERT INTO ejaCommands VALUES(32,1,'2008-03-03 16:34:58','runList',0,2,0,0,0);
INSERT INTO ejaCommands VALUES(33,1,'2008-03-03 16:35:16','runSearch',2,0,0,0,0);
INSERT INTO ejaCommands VALUES(34,1,'2008-03-03 16:35:27','runEdit',0,0,2,0,0);
CREATE TABLE ejaFields (
  ejaId INTEGER NOT NULL PRIMARY KEY,
  ejaOwner int default 0,
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
INSERT INTO ejaFields VALUES(60,1,'2007-09-04 09:47:19',21,'name','text','',1,2,1,0,'',0);
INSERT INTO ejaFields VALUES(61,1,'2007-09-04 09:48:07',21,'value','textArea','',0,4,3,0,'',0);
INSERT INTO ejaFields VALUES(70,1,'2007-09-07 12:52:32',15,'ejaOwner','sqlMatrix','SELECT ejaId,username FROM ejaUsers WHERE (ejaId=@ejaOwner OR ejaOwner IN (SELECT value FROM ejaSessions WHERE name=''ejaOwners'' AND ejaOwner=@ejaOwner)) ORDER BY username;',3,3,3,0,'',0);
INSERT INTO ejaFields VALUES(71,1,'2007-09-07 12:54:44',24,'name','text','',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(72,1,'2007-09-07 12:55:54',24,'nameFull','text','',2,2,2,0,'',0);
INSERT INTO ejaFields VALUES(73,1,'2007-09-07 12:56:14',24,'note','textArea','',0,0,3,0,'',0);
INSERT INTO ejaFields VALUES(74,1,'2007-09-07 13:03:38',15,'ejaLanguage','sqlMatrix','SELECT name,nameFull FROM ejaLanguages ORDER BY nameFull;',0,0,5,0,'',0);
INSERT INTO ejaFields VALUES(75,1,'2007-09-07 13:04:56',21,'ejaOwner','sqlMatrix','SELECT ejaId,username FROM ejaUsers ORDER BY username;',1,1,0,0,'',0);
INSERT INTO ejaFields VALUES(79,1,'2007-09-13 19:19:39',17,'defaultCommand','boolean','',2,5,5,0,'',0);
INSERT INTO ejaFields VALUES(100,1,'2007-09-20 09:24:23',21,'sub','text','',0,3,2,0,'',0);
INSERT INTO ejaFields VALUES(101,1,'2007-09-20 18:25:58',15,'ejaSession','text','',0,0,6,0,'',0);
INSERT INTO ejaFields VALUES(102,1,'2007-09-20 19:24:29',6,'ejaGroup','sqlMatrix','SELECT ejaId,name FROM ejaGroups ORDER BY name',0,0,4,0,'',0);
INSERT INTO ejaFields VALUES(105,1,'2007-10-01 15:59:34',17,'linking','boolean','',0,6,6,0,'',0);
INSERT INTO ejaFields VALUES(106,1,'2007-10-02 09:24:17',34,'dstModuleId','sqlMatrix','SELECT ejaId,name FROM ejaModules ORDER BY name;',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(107,1,'2007-10-02 09:26:01',34,'srcModuleId','sqlMatrix','SELECT ejaId,name FROM ejaModules ORDER BY name;',0,2,2,0,'',0);
INSERT INTO ejaFields VALUES(108,1,'2007-10-02 09:26:28',34,'power','integer','',0,5,5,0,'',0);
INSERT INTO ejaFields VALUES(178,1,'2008-02-20 12:51:39',6,'matrixUpdate','boolean','',0,0,9,0,'',0);
INSERT INTO ejaFields VALUES(191,1,'2008-04-08 18:18:02',16,'ejaOwner','sqlMatrix','SELECT ejaId,username FROM ejaUsers WHERE (ejaId=@ejaOwner OR ejaOwner IN (SELECT value FROM ejaSessions WHERE name=''ejaOwners'' AND ejaOwner=@ejaOwner)) ORDER BY username;',0,0,1,0,'',0);
INSERT INTO ejaFields VALUES(213,1,'2008-06-24 16:10:59',34,'srcFieldName','text','',0,4,4,0,'',0);
INSERT INTO ejaFields VALUES(247,1,'2010-01-07 11:58:58',5,'sortList','sqlMatrix','SELECT name AS value, name AS title FROM ejaFields WHERE ejaModuleId=(SELECT value FROM ejaSessions WHERE ejaSessions.ejaOwner=@ejaOwner AND ejaSessions.name=''ejaId'') ORDER BY name;',0,0,20,0,'',0);
INSERT INTO ejaFields VALUES(248,1,'2010-01-07 12:00:13',5,'lua','textArea','',0,0,100,0,'',0);
INSERT INTO ejaFields VALUES(257,1,'2010-01-07 14:17:23',1,'username','text','',1,1,1,0,'',0);
INSERT INTO ejaFields VALUES(258,1,'2010-01-07 14:18:05',1,'password','password','',2,2,2,0,'',0);
INSERT INTO ejaFields VALUES(261,1,'2010-01-14 16:26:59',21,'ejaLog','datetimeRange','',10,10,10,0,'',0);
CREATE TABLE ejaGroups (
  ejaId INTEGER NOT NULL PRIMARY KEY,
  ejaOwner int default 0,
  ejaLog datetime default NULL,
  name varchar(255) default NULL,
  note mediumtext
);
CREATE TABLE ejaLanguages (
  ejaId INTEGER NOT NULL PRIMARY KEY,
  ejaOwner int default 0,
  ejaLog datetime default NULL,
  nameFull varchar(255) default NULL,
  name varchar(255) default NULL,
  note mediumtext
);
INSERT INTO ejaLanguages VALUES(1,1,'2007-09-07 13:01:05','italiano','it','');
INSERT INTO ejaLanguages VALUES(2,1,'2007-09-07 13:01:29','english','en','');
INSERT INTO ejaLanguages VALUES(3,1,'2008-03-04 15:48:52','deutsch','de','');
CREATE TABLE ejaLinks (
  ejaId INTEGER NOT NULL PRIMARY KEY,
  ejaOwner int default 0,
  ejaLog datetime default NULL,
  srcModuleId int default 0,
  srcFieldId int default 0,
  dstModuleId int default 0,
  dstFieldId int default 0,
  power integer default 0
);
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
INSERT INTO ejaLinks VALUES(1118,1,'2010-01-14 14:58:42',16,122,15,2,1);
CREATE TABLE ejaModuleLinks (
  ejaId INTEGER NOT NULL PRIMARY KEY,
  ejaOwner int default 0,
  ejaLog datetime default NULL,
  dstModuleId integer default 0,
  srcModuleId integer default 0,
  power integer default 0,
  srcFieldName char(255) default NULL
);
INSERT INTO ejaModuleLinks VALUES(2,1,'2007-10-02 09:29:46',15,16,2,'');
INSERT INTO ejaModuleLinks VALUES(3,1,'2007-10-02 09:29:54',15,14,3,'');
INSERT INTO ejaModuleLinks VALUES(5,1,'2007-10-02 16:48:19',14,5,1,'');
INSERT INTO ejaModuleLinks VALUES(6,1,'2021-05-03 10:03:29',14,16,1,'');
CREATE TABLE ejaModules (
  ejaId INTEGER NOT NULL PRIMARY KEY,
  ejaOwner int default 0,
  ejaLog datetime default NULL,
  parentId integer default 0,
  name varchar(32) default NULL,
  power integer default 0,
  sqlCreated integer default 0,
  searchLimit integer default 0, 
  sortList TEXT, lua MEDIUMTEXT
);
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
INSERT INTO ejaModules VALUES(21,1,'2007-09-04 09:46:49',35,'ejaSessions',5,1,0,NULL,NULL);
INSERT INTO ejaModules VALUES(24,1,'2007-09-07 12:54:16',35,'ejaLanguages',4,1,0,NULL,NULL);
INSERT INTO ejaModules VALUES(25,1,'2007-09-07 17:12:31',2,'ejaStructure',2,0,0,NULL,NULL);
INSERT INTO ejaModules VALUES(26,1,'2007-09-07 17:13:06',2,'ejaAdministration',1,0,0,NULL,NULL);
INSERT INTO ejaModules VALUES(34,1,'2007-10-02 09:19:31',25,'ejaModuleLinks',5,1,0,NULL,NULL);
INSERT INTO ejaModules VALUES(35,1,'2007-10-02 17:00:20',2,'ejaSystem',3,0,0,NULL,NULL);
INSERT INTO ejaModules VALUES(36,1,'2007-10-24 18:41:44',35,'ejaBackups',10,0,0,NULL,NULL);
CREATE TABLE ejaPermissions (
  ejaId INTEGER NOT NULL PRIMARY KEY,
  ejaOwner int default 0,
  ejaLog datetime default NULL,
  ejaModuleId integer default 0,
  ejaCommandId integer default 0
);
INSERT INTO ejaPermissions VALUES (21,1,'2007-09-02 16:23:36',18,3);
INSERT INTO ejaPermissions VALUES (22,1,'2007-09-02 16:23:48',18,4);
INSERT INTO ejaPermissions VALUES (23,1,'2007-09-02 16:23:52',18,5);
INSERT INTO ejaPermissions VALUES (24,1,'2007-09-02 16:23:56',18,6);
INSERT INTO ejaPermissions VALUES (25,1,'2007-09-02 16:24:01',18,7);
INSERT INTO ejaPermissions VALUES (26,1,'2007-09-02 16:24:05',18,8);
INSERT INTO ejaPermissions VALUES (27,1,'2007-09-02 16:24:09',18,9);
INSERT INTO ejaPermissions VALUES (28,1,'2007-09-02 16:24:21',18,10);
INSERT INTO ejaPermissions VALUES (29,1,'2007-09-02 16:24:27',18,11);
INSERT INTO ejaPermissions VALUES (30,1,'2007-09-02 16:24:35',18,2);
INSERT INTO ejaPermissions VALUES (33,1,'2007-09-02 16:26:00',16,3);
INSERT INTO ejaPermissions VALUES (34,1,'2007-09-02 16:26:04',16,4);
INSERT INTO ejaPermissions VALUES (35,1,'2007-09-02 16:26:08',16,5);
INSERT INTO ejaPermissions VALUES (36,1,'2007-09-02 16:26:11',16,6);
INSERT INTO ejaPermissions VALUES (37,1,'2007-09-02 16:26:20',16,7);
INSERT INTO ejaPermissions VALUES (38,1,'2007-09-02 16:26:26',16,8);
INSERT INTO ejaPermissions VALUES (39,1,'2007-09-02 16:26:33',16,9);
INSERT INTO ejaPermissions VALUES (40,1,'2007-09-02 16:26:40',16,10);
INSERT INTO ejaPermissions VALUES (41,1,'2007-09-02 16:26:46',16,11);
INSERT INTO ejaPermissions VALUES (42,1,'2007-09-02 16:26:49',16,2);
INSERT INTO ejaPermissions VALUES (43,1,'2007-09-02 16:26:55',16,14);
INSERT INTO ejaPermissions VALUES (45,1,'2007-09-02 16:28:48',17,3);
INSERT INTO ejaPermissions VALUES (46,1,'2007-09-02 16:29:09',17,4);
INSERT INTO ejaPermissions VALUES (47,1,'2007-09-02 16:29:13',17,5);
INSERT INTO ejaPermissions VALUES (48,1,'2007-09-02 16:29:17',17,6);
INSERT INTO ejaPermissions VALUES (49,1,'2007-09-02 16:29:21',17,7);
INSERT INTO ejaPermissions VALUES (50,1,'2007-09-02 16:29:25',17,8);
INSERT INTO ejaPermissions VALUES (51,1,'2007-09-02 16:29:28',17,9);
INSERT INTO ejaPermissions VALUES (52,1,'2007-09-02 16:29:32',17,10);
INSERT INTO ejaPermissions VALUES (53,1,'2007-09-02 16:29:35',17,11);
INSERT INTO ejaPermissions VALUES (54,1,'2007-09-02 16:29:38',17,2);
INSERT INTO ejaPermissions VALUES (57,1,'2007-09-02 16:29:55',5,3);
INSERT INTO ejaPermissions VALUES (58,1,'2007-09-02 16:30:00',5,4);
INSERT INTO ejaPermissions VALUES (59,1,'2007-09-02 16:30:06',5,5);
INSERT INTO ejaPermissions VALUES (60,1,'2007-09-02 16:30:10',5,6);
INSERT INTO ejaPermissions VALUES (61,1,'2007-09-02 16:30:15',5,7);
INSERT INTO ejaPermissions VALUES (62,1,'2007-09-02 16:30:18',5,8);
INSERT INTO ejaPermissions VALUES (63,1,'2007-09-02 16:30:21',5,9);
INSERT INTO ejaPermissions VALUES (64,1,'2007-09-02 16:30:25',5,10);
INSERT INTO ejaPermissions VALUES (66,1,'2007-09-02 16:30:50',5,11);
INSERT INTO ejaPermissions VALUES (67,1,'2007-09-02 16:30:53',5,2);
INSERT INTO ejaPermissions VALUES (70,1,'2007-09-02 16:31:16',2,2);
INSERT INTO ejaPermissions VALUES (71,1,'2007-09-02 16:31:46',2,13);
INSERT INTO ejaPermissions VALUES (72,1,'2007-09-02 16:31:59',6,3);
INSERT INTO ejaPermissions VALUES (73,1,'2007-09-02 16:32:04',6,4);
INSERT INTO ejaPermissions VALUES (74,1,'2007-09-02 16:32:09',6,5);
INSERT INTO ejaPermissions VALUES (75,1,'2007-09-02 16:32:13',6,6);
INSERT INTO ejaPermissions VALUES (76,1,'2007-09-02 16:32:16',6,7);
INSERT INTO ejaPermissions VALUES (77,1,'2007-09-02 16:32:20',6,8);
INSERT INTO ejaPermissions VALUES (78,1,'2007-09-02 16:32:24',6,9);
INSERT INTO ejaPermissions VALUES (79,1,'2007-09-02 16:32:27',6,10);
INSERT INTO ejaPermissions VALUES (80,1,'2007-09-02 16:32:34',6,11);
INSERT INTO ejaPermissions VALUES (81,1,'2007-09-02 16:32:38',6,2);
INSERT INTO ejaPermissions VALUES (86,1,'2007-09-02 16:38:35',13,3);
INSERT INTO ejaPermissions VALUES (87,1,'2007-09-02 16:38:43',13,4);
INSERT INTO ejaPermissions VALUES (88,1,'2007-09-02 16:38:47',13,5);
INSERT INTO ejaPermissions VALUES (89,1,'2007-09-02 16:38:50',13,6);
INSERT INTO ejaPermissions VALUES (90,1,'2007-09-02 16:38:53',13,7);
INSERT INTO ejaPermissions VALUES (91,1,'2007-09-02 16:38:58',13,8);
INSERT INTO ejaPermissions VALUES (92,1,'2007-09-02 16:39:02',13,9);
INSERT INTO ejaPermissions VALUES (93,1,'2007-09-02 16:39:06',13,10);
INSERT INTO ejaPermissions VALUES (94,1,'2007-09-02 16:39:10',13,11);
INSERT INTO ejaPermissions VALUES (95,1,'2007-09-02 16:39:13',13,2);
INSERT INTO ejaPermissions VALUES (98,1,'2007-09-02 16:39:34',14,3);
INSERT INTO ejaPermissions VALUES (99,1,'2007-09-02 16:39:38',14,4);
INSERT INTO ejaPermissions VALUES (100,1,'2007-09-02 16:39:41',14,5);
INSERT INTO ejaPermissions VALUES (101,1,'2007-09-02 16:39:44',14,6);
INSERT INTO ejaPermissions VALUES (102,1,'2007-09-02 16:39:49',14,7);
INSERT INTO ejaPermissions VALUES (103,1,'2007-09-02 16:39:54',14,8);
INSERT INTO ejaPermissions VALUES (104,1,'2007-09-02 16:39:58',14,9);
INSERT INTO ejaPermissions VALUES (105,1,'2007-09-02 16:40:04',14,10);
INSERT INTO ejaPermissions VALUES (106,1,'2007-09-02 16:40:07',14,11);
INSERT INTO ejaPermissions VALUES (107,1,'2007-09-02 16:40:10',14,2);
INSERT INTO ejaPermissions VALUES (110,1,'2007-09-02 16:40:33',15,3);
INSERT INTO ejaPermissions VALUES (111,1,'2007-09-02 16:40:39',15,4);
INSERT INTO ejaPermissions VALUES (112,1,'2007-09-02 16:40:42',15,5);
INSERT INTO ejaPermissions VALUES (113,1,'2007-09-02 16:40:44',15,6);
INSERT INTO ejaPermissions VALUES (114,1,'2007-09-02 16:40:48',15,7);
INSERT INTO ejaPermissions VALUES (115,1,'2007-09-02 16:40:51',15,8);
INSERT INTO ejaPermissions VALUES (116,1,'2007-09-02 16:40:54',15,9);
INSERT INTO ejaPermissions VALUES (117,1,'2007-09-02 16:40:57',15,10);
INSERT INTO ejaPermissions VALUES (118,1,'2007-09-02 16:41:01',15,11);
INSERT INTO ejaPermissions VALUES (119,1,'2007-09-02 16:41:04',15,2);
INSERT INTO ejaPermissions VALUES (138,1,'2007-09-04 09:48:53',21,5);
INSERT INTO ejaPermissions VALUES (139,1,'2007-09-04 09:48:56',21,6);
INSERT INTO ejaPermissions VALUES (140,1,'2007-09-04 09:49:00',21,7);
INSERT INTO ejaPermissions VALUES (141,1,'2007-09-04 09:49:12',21,10);
INSERT INTO ejaPermissions VALUES (142,1,'2007-09-04 09:49:16',21,11);
INSERT INTO ejaPermissions VALUES (143,1,'2007-09-04 09:49:24',21,2);
INSERT INTO ejaPermissions VALUES (159,1,'2007-09-07 12:58:24',24,3);
INSERT INTO ejaPermissions VALUES (160,1,'2007-09-07 12:58:34',24,4);
INSERT INTO ejaPermissions VALUES (161,1,'2007-09-07 12:58:38',24,5);
INSERT INTO ejaPermissions VALUES (162,1,'2007-09-07 12:58:42',24,6);
INSERT INTO ejaPermissions VALUES (163,1,'2007-09-07 12:58:46',24,7);
INSERT INTO ejaPermissions VALUES (164,1,'2007-09-07 12:58:49',24,8);
INSERT INTO ejaPermissions VALUES (165,1,'2007-09-07 12:58:52',24,9);
INSERT INTO ejaPermissions VALUES (166,1,'2007-09-07 12:58:55',24,10);
INSERT INTO ejaPermissions VALUES (167,1,'2007-09-07 12:58:58',24,11);
INSERT INTO ejaPermissions VALUES (168,1,'2007-09-07 12:59:06',24,2);
INSERT INTO ejaPermissions VALUES (169,1,'2007-09-07 17:14:11',25,2);
INSERT INTO ejaPermissions VALUES (171,1,'2007-09-07 17:14:44',26,2);
INSERT INTO ejaPermissions VALUES (267,1,'2007-10-02 09:24:08',34,2);
INSERT INTO ejaPermissions VALUES (268,1,'2007-10-02 09:24:08',34,3);
INSERT INTO ejaPermissions VALUES (269,1,'2007-10-02 09:24:08',34,4);
INSERT INTO ejaPermissions VALUES (270,1,'2007-10-02 09:24:08',34,5);
INSERT INTO ejaPermissions VALUES (271,1,'2007-10-02 09:24:08',34,6);
INSERT INTO ejaPermissions VALUES (272,1,'2007-10-02 09:24:08',34,7);
INSERT INTO ejaPermissions VALUES (273,1,'2007-10-02 09:24:08',34,8);
INSERT INTO ejaPermissions VALUES (274,1,'2007-10-02 09:24:08',34,9);
INSERT INTO ejaPermissions VALUES (275,1,'2007-10-02 09:24:08',34,10);
INSERT INTO ejaPermissions VALUES (276,1,'2007-10-02 09:24:08',34,11);
INSERT INTO ejaPermissions VALUES (281,1,'2007-10-02 17:09:02',35,2);
INSERT INTO ejaPermissions VALUES (282,1,'2007-10-25 10:27:06',36,13);
INSERT INTO ejaPermissions VALUES (480,1,'2008-03-04 12:42:47',14,14);
INSERT INTO ejaPermissions VALUES (481,1,'2008-03-04 12:43:05',14,15);
INSERT INTO ejaPermissions VALUES (482,1,'2008-03-04 15:37:08',16,15);
INSERT INTO ejaPermissions VALUES (498,1,'2008-04-08 12:04:59',5,14);
INSERT INTO ejaPermissions VALUES (499,1,'2008-04-08 12:05:17',5,15);
CREATE TABLE ejaSessions (
  ejaId INTEGER NOT NULL PRIMARY KEY,
  ejaOwner int default 0,
  ejaLog datetime default NULL,
  name varchar(255) default NULL,
  value mediumtext,
  sub varchar(255) default NULL
);
CREATE TABLE ejaUsers (
  ejaId INTEGER NOT NULL PRIMARY KEY,
  ejaOwner int default 0,
  ejaLog datetime default NULL,
  ejaSession varchar(64) default NULL,
  username varchar(32) default NULL,
  password varchar(64) default NULL,
  defaultModuleId integer default 0,
  ejaLanguage text
);
INSERT INTO ejaUsers VALUES(1,1,'0000-00-00 00:00:00','','admin','eja.it',5,'en');
INSERT INTO ejaUsers VALUES(2,1,'2010-01-14 14:55:24','','user','eja.it',2,'en');
CREATE TABLE ejaLogin (
  ejaId INTEGER NOT NULL PRIMARY KEY, 
  ejaOwner INTEGER, 
  ejaLog DATETIME, 
  username CHAR(255), 
  password CHAR(255)
);
CREATE TABLE ejaTranslations (
  ejaId INTEGER NOT NULL PRIMARY KEY,
  ejaOwner int default 0,
  ejaLog datetime default NULL,
  ejaLanguage char(3) default NULL,
  ejaModuleId integer default 0,
  word text,
  translation text
);
INSERT INTO ejaTranslations VALUES(96,1,'2007-09-10 19:05:36','en',0,'alertSearch',' ');
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
INSERT INTO ejaTranslations VALUES(354,1,'0000-00-00 00:00:00','en',0,'alertListSearchLink',' ');
INSERT INTO ejaTranslations VALUES(355,1,'0000-00-00 00:00:00','en',0,'alertSearchLogin',' ');
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
INSERT INTO ejaTranslations VALUES(412,1,'2007-10-29 11:33:19','en',0,'alertSearchRun',' ');
INSERT INTO ejaTranslations VALUES(419,1,'2007-10-29 15:48:49','en',0,'alertSearchLinkBack',' ');
INSERT INTO ejaTranslations VALUES(421,1,'2007-11-05 14:59:40','en',0,'ejaSqlTableCreate','Sql table created. ');
INSERT INTO ejaTranslations VALUES(422,1,'2007-11-05 14:59:54','en',0,'ejaSqlTableAlter','Sql table altered. ');
INSERT INTO ejaTranslations VALUES(423,1,'2007-11-05 15:00:31','en',0,'ejaSqlFieldCreate','Sql field added. ');
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
INSERT INTO ejaTranslations VALUES(544,1,'2008-03-27 15:49:29','en',0,'ejaSqlTableAlterError','table not altered.');
INSERT INTO ejaTranslations VALUES(545,1,'2008-03-28 17:03:53','en',0,'alertEditSearchLink',' ');
INSERT INTO ejaTranslations VALUES(546,1,'2008-03-28 19:17:53','en',0,'ejaTo','to');
INSERT INTO ejaTranslations VALUES(547,1,'2008-03-28 19:18:53','en',0,'ejaFrom','from');
INSERT INTO ejaTranslations VALUES(548,1,'2008-03-29 20:00:59','en',0,'ejaRoot','Home');
INSERT INTO ejaTranslations VALUES(549,1,'2008-04-04 12:34:17','en',0,'alertEditRunEdit',' ');
INSERT INTO ejaTranslations VALUES(784,1,'2008-04-15 23:23:35','en',0,'alertEditFileMove','moved');
INSERT INTO ejaTranslations VALUES(855,1,'2010-01-28 09:46:07','en',0,'ejaDateFrom','from');
INSERT INTO ejaTranslations VALUES(856,1,'2010-01-28 09:46:07','en',0,'ejaDateTo','to');

COMMIT;


/* mysql auto increment */
ALTER TABLE ejaCommands CHANGE ejaId ejaId INTEGER AUTO_INCREMENT;
ALTER TABLE ejaFields CHANGE ejaId ejaId INTEGER AUTO_INCREMENT;
ALTER TABLE ejaGroups CHANGE ejaId ejaId INTEGER AUTO_INCREMENT;
ALTER TABLE ejaLanguages CHANGE ejaId ejaId INTEGER AUTO_INCREMENT;
ALTER TABLE ejaLinks CHANGE ejaId ejaId INTEGER AUTO_INCREMENT;
ALTER TABLE ejaLogin CHANGE ejaId ejaId INTEGER AUTO_INCREMENT;
ALTER TABLE ejaModuleLinks CHANGE ejaId ejaId INTEGER AUTO_INCREMENT;
ALTER TABLE ejaModules CHANGE ejaId ejaId INTEGER AUTO_INCREMENT;
ALTER TABLE ejaPermissions CHANGE ejaId ejaId INTEGER AUTO_INCREMENT;
ALTER TABLE ejaSessions CHANGE ejaId ejaId INTEGER AUTO_INCREMENT;
ALTER TABLE ejaTranslations CHANGE ejaId ejaId INTEGER AUTO_INCREMENT;
ALTER TABLE ejaUsers CHANGE ejaId ejaId INTEGER AUTO_INCREMENT;


/* change password update */
INSERT INTO ejaFields VALUES(NULL,1,'2016-01-28 10:54:03',2,'passwordOld','password','',10,0,0,0,'',0);
INSERT INTO ejaFields VALUES(NULL,1,'2016-01-28 10:54:30',2,'passwordNew','password','',20,0,0,0,'',0);
INSERT INTO ejaFields VALUES(NULL,1,'2016-01-28 10:54:46',2,'passwordNewRepeat','password','',30,0,0,0,'',0);
INSERT INTO ejaLinks VALUES(NULL,1,'2016-01-28 10:05:40',16,70,15,2,1);
INSERT INTO ejaLinks VALUES(NULL,1,'2016-01-28 10:05:40',16,71,15,2,1);
INSERT INTO ejaTranslations VALUES(NULL,1,'2019-11-14 13:21:07','en',2,'passwordChangeSuccess','Password changed');
INSERT INTO ejaTranslations VALUES(NULL,1,'2019-11-14 13:21:07','en',2,'passwordChangeError','Password change error');
UPDATE ejaModules SET lua='
 if ejaNumber(tibulaModuleLuaStep)==0 and ejaNumber(tibula.ejaOwner) > 0 and ejaString(tibula.ejaAction)=="run" then
  if ejaString(tibula.ejaValues.passwordOld)~="" and ejaString(tibula.ejaValues.passwordNew)~="" and ejaString(tibula.ejaValues.passwordNew)==ejaString(tibula.ejaValues.passwordNewRepeat) then
   if tibulaSqlRun("UPDATE ejaUsers SET password=''%s'' WHERE ejaId=%d AND (password=''%s'' OR password=''%s'');",ejaSha256(tibula.ejaValues.passwordNew),tibula.ejaOwner,ejaSha256(tibula.ejaValues.passwordOld),tibula.ejaValues.passwordOld) then
    tibulaInfo("passwordChangeSuccess")
   end
  else
   tibulaInfo("passwordChangeError")
  end
 end
 ' WHERE name="eja";
UPDATE ejaPermissions SET ejaCommandId=13 where ejaId=71;

/* backup import/export */
INSERT INTO ejaFields VALUES(NULL,1,'2019-11-14 12:38:13',36,'ejaModuleName','sqlMatrix','SELECT name AS value,name AS title FROM ejaModules ORDER BY name;',10,0,0,0,'',0);
INSERT INTO ejaFields VALUES(NULL,1,'2019-11-14 12:39:06',36,'data','textArea','',100,0,0,0,'',0);
INSERT INTO ejaFields VALUES(NULL,1,'2019-11-14 12:40:38',36,'action','select','import
export',5,0,0,0,'',0);
INSERT INTO ejaTranslations VALUES(NULL,1,'2019-11-14 13:21:07','en',36,'ejaModuleName','Module');
INSERT INTO ejaTranslations VALUES(NULL,1,'2019-11-14 13:21:07','en',36,'backupExportSuccess','Data Exported');
INSERT INTO ejaTranslations VALUES(NULL,1,'2019-11-14 13:21:07','en',36,'backupExportError','Data Export Problem');
INSERT INTO ejaTranslations VALUES(NULL,1,'2019-11-14 13:21:07','en',36,'backupImportSuccess','Module Imported');
INSERT INTO ejaTranslations VALUES(NULL,1,'2019-11-14 13:21:07','en',36,'backupImportError','Module Import problem');
UPDATE ejaModules SET lua='
 if ejaNumber(tibulaModuleLuaStep)==0 and ejaNumber(tibula.ejaOwner) > 0 and ejaString(tibula.ejaAction)=="run" then
  if ejaString(tibula.ejaValues.action) == "export" then
   if ejaString(tibula.ejaValues.ejaModuleName) ~= "" then
    tibula.ejaValues.data=ejaJsonEncode(tibulaModuleExport(tibula.ejaValues.ejaModuleName))
    tibulaInfo("backupExportSuccess")
   else
    tibulaInfo("backupExportError")
   end
  end
  if ejaString(tibula.ejaValues.action) == "import" then
   local dd=ejaJsonDecode(tibula.ejaValues.data)
   if dd and tibulaModuleImport(dd) then
    tibulaInfo("backupImportSuccess")       
   else
    tibulaInfo("backupImportError")      
   end
  end
 end
' WHERE name="ejaBackups";


