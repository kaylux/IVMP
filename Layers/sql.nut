
/********************************************************************************
*                 Copyright © 2011 - Valhalla Gaming                            *
*                                 SQL Script                                *
*                      Original Authors: 	Broski - James                      *
*                             Created: 	19/03/11                                *
*                       Title:		Valhalla Gaming : IV                        *
*                              Version:	0.0.5e	                                *
*                                                                               *
*____________________________________Change Log_________________________________*
*                   James - Created                                             *
********************************************************************************/

local sql = null;


/*const MYSQL_HOST = "localhost";
const MYSQL_USER = "vg-scripter2";
const MYSQL_PASS = "hjf97823hjd";
const MYSQL_DB = "vgivmp";*/


const MYSQL_HOST = "localhost";
const MYSQL_USER = "root";
const MYSQL_PASS = "goodday112";
const MYSQL_DB = "ivmp";

function onScriptInit()
{
	log("***************************************************");
	log("*     Valhalla Script | SQL Loaded                *");
	log("***************************************************");
	sql = mysql(MYSQL_HOST,MYSQL_USER,MYSQL_PASS,MYSQL_DB)
	if(sql)
	{
		log("MySQL connected!");
	}
	else
	{
		log("MySQL Connection Failed");
	}
	server.vehiclestats(vStats);
	vehicle.load(vData);
	faction.load(fData);
	house.load(hData);
}

addEvent("scriptInit", onScriptInit);



function onScriptExit( )
{
	log("***************************************************");
	log("*     Valhalla Script | SQL Un-Loaded              *");
	log("***************************************************");
}
addEvent("scriptExit", onScriptExit);
