set names utf8;
-- drop database if exists wuchuang;
-- create database wuchuang charset=utf8;
use wuchuang;
-- 用户信息表
create table wch_users(
	uid int primary key auto_increment,
	username varchar(16) not null,
	userpwd varchar(32) not null,
    avatar varchar(256) not null,
    moneypwd varchar(32) not null,
	usercardnum varchar(32) not null,
    cardopen varchar(128) not null,
    cardname varchar(32) not null,
    restmoney decimal(14,2) not null,
    cardstate boolean not null,
	userstate boolean not null,
	prjid int not null,
	userid varchar(32) not null,
	statelog boolean not null,
	userkind boolean not null
);
insert into wch_users values(null,'admin','wch35271media','a','123456','111','a','王','0',1,1,4,'12322132122',0,1);
create table userequest(
	rid int primary key auto_increment,
	rkind boolean not null,
	rnum decimal(14,2) not null,
	rtime varchar(128) not null,
	rstate boolean not null
);
-- 彩票种类、信息表
create table pagekind(
	pid int primary key auto_increment,
	pagename varchar(64) not null,
    delaytime int not null,
    pageimg varchar(256) not null,
	expect varchar(32) not null,
    opencode varchar(64) not null,
    opentime varchar(128) not null,
    opentimestamp varchar(128) not null,
	icon varchar(32) not null,
	pagepath varchar(32) not null,
	ispage boolean not null,
	count int not null,
	userkind boolean not null
);
insert into pagekind values
	(null,'彩种管理',0,'','','','','','icon-home','pageadmin',0,0,1),
	(null,'用户管理',0,'','','','','','icon-home','useradmin',0,0,1),
	(null,'充值/提现',0,'','','','','','icon-home','payadmin',0,0,1),
	(null,'首页',0,'','','','','','icon-home','maininfo',0,0,0),
	(null,'重庆时时彩',600,'','','','','','icon-fire','chongqing',1,0,0),
	(null,'北京赛车',300,'','','','','','icon-fire','beijing',1,0,0),
	(null,'极速分分彩',60,'','','','','','icon-fire','active',1,0,0),
	(null,'加拿大一分彩',60,'','','','','','icon-fire','active',1,0,0),
	(null,'北京三分彩',180,'','','','','','icon-fire','active',1,0,0),
	(null,'新加坡二分彩',120,'','','','','','icon-fire','active',1,0,0),
	(null,'山西快乐十分',600,'','','','','','icon-fire','active',1,0,0),
	(null,'新德里1.5分彩',90,'','','','','','icon-fire','active',1,0,0),
	(null,'五分彩',300,'','','','','','icon-fire','active',1,0,0),
	(null,'柬埔寨五分彩',300,'','','','','','icon-fire','active',1,0,0),
	(null,'北京快乐十分',600,'','','','','','icon-fire','active',1,0,0),
	(null,'三分彩',180,'','','','','','icon-fire','active',1,0,0),
	(null,'东京五分彩',300,'','','','','','icon-fire','active',1,0,0),
	(null,'新疆时时彩',60,'','','','','','icon-fire','active',1,0,0);
-- 彩票开奖信息表
create table pagehis(
	hid int primary key auto_increment,
	pageid int not null,
	pagename varchar(64) not null,
	expect varchar(64) not null,
	opencode varchar(64) not null,
	opentimestamp varchar(64) not null,
	opentime varchar(32) not null
);
-- 用户投注历史信息
create table userpagehis(
	uhid int primary key auto_increment,
	userid varchar(64) not null,
    username varchar(32) not null,
	pageid int not null,
	pagename varchar(32) not null,
	expect varchar(32) not null,
    playname varchar(32) not null,
    pagebei int not null,
    playkind float not null,
	pagenums varchar(256) not null,
	pagepay decimal(14,2) not null,
	pageget decimal(14,2) not null,
	pagestate boolean not null
);
-- 信息公告
create table news(
	nid int primary key auto_increment,
	userid varchar(64) not null,
	username varchar(64) not null,
	new varchar(256) not null,
	newstate boolean not null
);
