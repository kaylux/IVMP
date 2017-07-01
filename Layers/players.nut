/********************************************************************************
*                 Copyright © 2011 - Valhalla Gaming                            *
*                          Player Script                                         *
*                      Original Authors: 	Broski - James                      *
*                             Created: 	19/03/11                                *
*                       Title:		Valhalla Gaming : IV                        *
*                              Version:	0.0.5e	                                *
*                                                                               *
*____________________________________Change Log_________________________________*
*                   James -        Created                                      *
*********************************************************************************/


local pData = { }; // Player Data Table

local pReg = array(MAX_PLAYERS, 0); // Reg
local pLog = array(MAX_PLAYERS, 0); //Log
local pReport = { }; //Report Handler

function onScriptInit()
{
	log("***************************************************");
	log("*   Running Valhalla Gaming | Player Script       *");
	log("***************************************************");
}

addEvent("scriptInit", onScriptInit);

function onScriptExit( )
{
	log("***************************************************");
	log("*    Valhalla Gaming Script | Players Un-Loaded   *");
	log("***************************************************");
	for (local i = 0; i < MAX_PLAYERS; i++)
	{
		local pos = getPlayerCoordinates(i);
		pData[i].lastpos <- pos[0], pos[1], pos[2];
		account.save(getPlayerName(playerid), vData[i]);
		log("*           All Players Saved             *");
	}
}
addEvent("scriptExit", onScriptExit);


function onPlayerConnect(playerid)
{
	pData[playerid] <- { };
	pReport[playerid] <- { };
	pData[playerid].char <- 0;
	pData[playerid].ooc <- 1
	pData[playerid].openreport <- 0;
	pData[playerid].pm <- 1;
	pData[playerid].job <- 0;
	pData[playerid].admin <- 0;
	pData[playerid].aod <- 0;
	pData[playerid].faction <- 0;
	pData[playerid].tutorial <- 0;
	pData[playerid].model <- 0;
	pData[playerid].lastpos <- 0;
	pData[playerid].packages <- 0;
	pData[playerid].drugs <- 0;
	pData[playerid].respect <- 0;
	pData[playerid].driver <- 0;
	pData[playerid].leader <- 0;
	pData[playerid].seatbelt <- 0;
	pData[playerid].warns <- 0;
	pData[playerid].jailtime <- 0;
	pData[playerid].report <- 0;

	pData[playerid].PDduty <- 0; //PD On Duty

	

	togglePlayerRadar(playerid, true);
	togglePlayerHud(playerid, false);
	togglePlayerAutoAim(playerid, true);
	togglePlayerFrozen(playerid, true);
	if(isRPName(getPlayerName(playerid)))
	{
		local ip = getPlayerIp(playerid);
		local bancheck = sql.query_assoc_single( "SELECT * FROM bans WHERE IP = '" + ip + "'" );
		if( bancheck )
		{
			sendPlayerMessage(playerid, "[vG]: You Are Banned From This Server.",  COLOR_YELLOW);
			sendPlayerMessage(playerid, "[vG] To Appeal Your Ban Go To. www.valhallagaming.net", COLOR_GRAY);
			log(getPlayerName(playerid) + "Attempted To Connect While Banned:" + ip);
			kickPlayer(playerid, true);
		}
		else
		{
			pLog[playerid] = 0;
			if(account.load(getPlayerName(playerid), pData[playerid]))
			{
				sendPlayerMessage(playerid, "[vG]: Welcome to Valhalla Gaming IV-MP Server! Please log in.",  COLOR_YELLOW);
				sendPlayerMessage(playerid, "SYNTAX: /login [password]", COLOR_GRAY);
				pReg[playerid] = 1;
				log("Registered:" + getPlayerName(playerid) + " Connected");
			}
			else
			{
				sendPlayerMessage(playerid, "[vG]: Welcome to Valhalla Gaming IV-MP Server! You Are Not Registered",  COLOR_YELLOW);
				sendPlayerMessage(playerid, "SYNTAX: /register [password]", COLOR_GRAY);			
			}
		}
	}
	else
	{
		sendPlayerMessage(playerid, "[vG]: Sorry, Please Re-Connect Using An RP Name. Like James_Walker",  COLOR_YELLOW);	
	}
	return 1;
	
}
addEvent("playerConnect", onPlayerConnect);

function onPlayerSpawn(playerid)
{
		setPlayerCoordinates(playerid,  385.374939, 1636.597900, 26.912529);
		//setPlayerColor(playerid, COLOR_GRAY);
		//togglePlayerRadar(playerid, true);
		//togglePlayerHud(playerid, true);
		return 1;
}
addEvent("playerSpawn", onPlayerSpawn);

function onPlayerDisconnect(playerid, reason)
{
	if( pLog[playerid] == 1 )
	{
		local pos = getPlayerCoordinates(playerid);
		local str = pos[0]+","+pos[1]+","+pos[2]
		pData[playerid].lastpos <- str;
		if( account.save(getPlayerName(playerid), pData[playerid]) )
		{
			log("[MYSQL]: Player "+getPlayerName(playerid)+" saved.");
			return 1;
		}
		else
		{
			log("[MYSQL]: Player "+getPlayerName(playerid)+" failed to save.");
			return 1;
		}
		delete pData[playerid];
	}
	return 0;
}
addEvent("playerDisconnect", onPlayerDisconnect);

function onPlayerText(playerid,text)
{
	if(pLog[playerid] == 1)
	{
		ProxDetector(20.0, playerid, getPlayerName(playerid)+" says: " + text,0xE6E6E6E6,0xC8C8C8C8,0xAAAAAAAA,0x8C8C8C8C,0x6E6E6E6E);
		log("[CHAT]: "+getPlayerName(playerid)+" "+text);
	}
	else
	{
		sendPlayerMessage(playerid, "[vG]: Please log in.", COLOR_YELLOW);
	}
	return 0;
}
addEvent("playertext", onPlayerText);

function onPlayerEnterCheckpoint(playerid, checkpointId)
{
    if(checkpointId == checkpoint)
    {
        sendPlayerMessage(playerid, "You entered the checkpoint!", 0xFF0000FF, false);
    }
    return 1;
}
addEvent("playerEnterCheckpoint", onPlayerEnterCheckpoint);


local player = {
	function isAdmin(playerid)
	{
		if( pData[playerid].admin >= 0 || pData[playerid].admin.tointeger() >= 0 )
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
	function isAdminLevel(playerid, level)
	{
		if( pData[playerid].admin >= level || pData[playerid].admin.tointeger() >= level )
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
	function isACop(playerid)
	{
		if( pData[playerid].faction == "1" || pData[playerid].faction.tointeger() == 1 )
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
	function isRank(playerid, rank)
	{
		if(pData[playerid].rank >= rank || pData[playerid].rank.tointeger() >= rank)
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
	function isNearLocation(rad, playerid, x, y, z)
	{
		if(isPlayerConnected(playerid))
	   {
		  local oldpos = getPlayerCoordinates(playerid);
		  local tempposx = (oldpos[0] -x);
		  local tempposy = (oldpos[1] -y);
		  local tempposz = (oldpos[2] -z);
		  if (((tempposx < rad) && (tempposx > -rad)) && ((tempposy < rad) && (tempposy > -rad)) && ((tempposz < rad) && (tempposz > -rad)))
		  {
			 return 1;
		  }
	   }
	   return 0;
	}
	function isDriver(playerid)
	{
		for(local i = 0; i < MAX_VEHICLES; i++)
		{
			if(isVehicleValid(i))
			{
				if(isPlayerInVehicle(playerid, i))
				{
					return 1;
				}
			}
			return 0;
		}
		return 0;
	}
}


local account = {
    function create(name, password)
	{
		local result = sql.query("INSERT INTO users (name, password) VALUES ('" + sql.escape(name) + "', '" + whirlpool(password) + "')");
		if(!result)
		{
			log(name + "|MySQL Registration Error");
			return 0;
		}
		else
		{
			log(name + "| MySQL Registration Success!!");
			return 1;
		}
	}
    function save(name, pt)
    {
		local update = sql.query_affected_rows("UPDATE users SET name='" + pt.name + "',  password='" + pt.password + "', admin='" + pt.admin + "', warns='" + pt.warns + "', jailtime='" + pt.jailtime + "', age='" + pt.age + "', level='" + pt.level + "', tutorial='" + pt.tutorial + "', model='" + pt.model + "', bank='" + pt.bank + "', cash='" + pt.cash + "', faction='" + pt.faction + "', rank='" + pt.rank + "', respect='" + pt.respect + "', lastpos='" + pt.lastpos + "', packages='"+pt.packages+"', job='"+pt.job+"', drugs='"+pt.drugs+"' , leader='"+pt.leader+"' , donator='"+pt.donator+"' , contime='"+pt.contime+"', reg='"+pt.reg+"' , sex='"+pt.sex+"' , pdjail='"+pt.pdjail+"' , carlic='"+pt.carlic+"' , flylic='"+pt.flylic+"' , gunlic='"+pt.gunlic+"' , suslic='"+pt.suslic+"' WHERE name='" + sql.escape(name) + "'" )
		if(update)
		{	
			log( name + "|Account Saved Successfully!");
			return 1;
		}
		else
		{
			log( name + " |Error Saving Account!");
			return 0;
		}
    }

    function load(name, pt)
    {
		local stat = sql.query_assoc_single( "SELECT * FROM users WHERE name = '" + name + "'" );
		if( stat )
		{
		
			pt.name <- stat.name;
			pt.password <- stat.password;
			pt.admin <- stat.admin;	
			pt.warns <- stat.warns;
			pt.jailtime <- stat.jailtime;			
			pt.age <- stat.age;
			pt.level <- stat.level;
			pt.tutorial <- stat.tutorial;
			pt.bank <- stat.bank;
			pt.cash <- stat.cash;
			pt.faction <- stat.faction;
			pt.rank <- stat.rank;
			pt.respect <- stat.respect;
			pt.model <- stat.model;
			pt.lastpos <- stat.lastpos
			pt.packages <- stat.packages;
			pt.job <- stat.job;
			pt.drugs <- stat.drugs;
			pt.leader <- stat.leader;
			
			pt.donator <- stat.donator;
			pt.contime <- stat.contime;
			pt.reg <- stat.reg;
			pt.sex <- stat.sex;
			pt.pdjail <- stat.pdjail;
			pt.carlic <- stat.carlic;
			pt.flylic <- stat.flylic;
			pt.gunlic <- stat.gunlic;
			pt.suslic <- stat.suslic;
			
			pt.driver <- 0;
			log(name + "|Account Loaded Successfully!");
			return 1;
		}
		else
		{
			log(name + "|Error Loading Account");
			return 0;
		}
	}
}
