/********************************************************************************
*                 Copyright © 2011 - Valhalla Gaming                            *
*                                 Function Script                               *
*                      Original Authors: 	Broski - James                      *
*                             Created: 	19/03/11                                *
*                       Title:		Valhalla Gaming : IV                        *
*                              Version:	0.0.5e	                                *
*                                                                               *
*____________________________________Change Log_________________________________*
*                   James - Created                                             *
********************************************************************************/

function onScriptInit()
{
	log("***************************************************");
	log("*     Valhalla Script | Custom Functions Loaded   *");
	log("***************************************************");
}

addEvent("scriptInit", onScriptInit);



function onScriptExit( )
{
	log("***************************************************");
	log("*  Valhalla Script | Custom Functions Un-Loaded   *");
	log("***************************************************");
}
addEvent("scriptExit", onScriptExit);


function returnSplit(playerid)
{
	local name = getPlayerName(playerid);
	local names = split(name, "_");
	return names;
}



function returnWeapon(str, level) //bat cue knife nade molotov rocket pistol deagle shotgun beretta uzi mp5 ak m4 snipe m40a1 rpg
{
	local lvl = level.tointeger();
	if(str == "bat" || str == "baseball bat") { return 1; }
	if(str == "cue" || str == "pool cue" && lvl >= 2) { return 2; }
	if(str == "knife" && lvl >= 3) { return 3; }
	if(str == "nade" || str == "grenade" && lvl >= 15) { return 4; }
	if(str == "molotov" && lvl >= 15) { return 5; }
	if(str == "pistol" || str == "glock" && lvl >= 4) { return 7; }
	if(str == "deagle" || str == "desert" || str == "desert eagle" || str == "eagle" && lvl >= 6) { return 8; }
	if(str == "shotgun" && lvl >= 10) { return 9; }
	if(str == "beretta" && lvl >= 10) { return 10; }
	if(str == "uzi" && lvl >= 11) { return 11; }
	if(str == "mp5" && lvl >= 11) { return 12; }
	if(str == "ak" || str == "ak-47" && lvl >= 12) { return 13; }
	if(str == "m4" || str == "m4-a1" && lvl >= 13) { return 14; }
	if(str == "sniper" || str == "rifle" && lvl >= 15) { return 15; }
	if(str == "m40a1" && lvl >= 15) { return 16; }
	if(str == "rpg" && lvl >= 15) { return 17; }
	else { return -1; }
}



function isNumeric(string)
{
   try
   {
      string.tointeger();
   }
   catch(string)
   {
      return 0;
   }
   return 1;
}



function returnUser(string, playerid = INVALID_PLAYER_ID)
{
	if(isNumeric(string))
	{
		if(!isPlayerConnected(string.tointeger()))
		{
			if(playerid != INVALID_PLAYER_ID) sendPlayerMessage(playerid, "Invalid playerID (" + string + ").", COLOR_GRAY);
			return INVALID_PLAYER_ID;
		}
			
		return string.tointeger();
	}
	
	local targetid = INVALID_PLAYER_ID;
	string = string.tolower();
	foreach(i,name in getPlayers())
	{
		name = name.tolower();
		if(name.len() < string.len()) // i.e. If string is "Adam_G", will skip players named "Adam", but not players name "Adam_Green", "Adam_Gee", etc..
			continue;
		
		local idx = name.find(string); // Find the search string in the players name
		
		log("returnUser(\"" + string + "\") comparing to: \"" + name + "\", full name = \"" + getPlayerName(i) + "\"");
		
		if(idx != null) // match
		{
			if(targetid == INVALID_PLAYER_ID)
			{
				log("returnUser(\"" + string + "\") match found: \"" + name + "\", full name = \"" + getPlayerName(i) + "\" at idx: " + idx);
				targetid = i;
			}
			else
			{
				if(playerid != INVALID_PLAYER_ID) sendPlayerMessage(playerid, "Multiple matches found for name \"" + string + "\".", COLOR_GRAY);
				return INVALID_PLAYER_ID; // multiple matches
			}
		}
	}
	if(playerid != INVALID_PLAYER_ID && targetid == INVALID_PLAYER_ID) sendPlayerMessage(playerid, "No matches found for name \"" + string + "\".", COLOR_GRAY);
	
	log("returnUser(\"" + string + "\") resulting targetID = " + targetid);
	return targetid;
}



function ProxDetector(radi, playerid, string,col1,col2,col3,col4,col5)
{
	if(isPlayerConnected(playerid))
	{
		local oldpos = getPlayerCoordinates(playerid);
		for(local i = 0; i < MAX_PLAYERS; i++)
		{
			if(isPlayerConnected(i))
			{
				local pos = getPlayerCoordinates(i);
				local tempposx = (oldpos[0] -pos[0]);
				local tempposy = (oldpos[1] -pos[1]);
				local tempposz = (oldpos[2] -pos[2]);
				if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
				{
					sendPlayerMessage(i, string, col1);
				}
				else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
				{
					sendPlayerMessage(i, string, col2);
				}
				else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
				{
					sendPlayerMessage(i, string, col3);
				}
				else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
				{
					sendPlayerMessage(i, string,col4);
				}
				else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				{
					sendPlayerMessage(i, string, col5);
				}
			}
			else
			{
				sendPlayerMessage(i, string, col1);
			}
		}
	}
	return 1;
}


function isRPName(name)
{ 
    local test = regexp("^[A-Z][a-z]*_[A-Z][a-z]*$");
    return test.match(name);
}



function reciveClientStreetAreaName(street, area)
{
	streetName = street;
	areaName = area;
}
addEvent("playerStreetAreaName", reciveClientStreetAreaName);



function PlayerToPoint(playerid, radius, x, y, z)
{
    local playerpos = getPlayerCoordinates(playerid);
    return isPointInBall(x, y, z, playerpos[0], playerpos[1], playerpos[2], radius);
} 



function getSpeed(vehicleid)
{
    local velocity = getVehicleVelocity(vehicleid);
    return sqrt(pow(velocity[0], 2) + pow(velocity[1], 2) + pow(velocity[2], 2))*5;
}



function round(number, digits = 0)
{
	return (pow(10, digits) * number + 0.5).tointeger() / pow(10, digits);
}


function adminMessage(string, color)
{
	for(local i = 0; i < MAX_PLAYERS; i++)
	{
		if(pData[i].admin >= 1)
		{
			sendPlayerMessage(i, string, color);
		}
	}
}


function random(min, max) { return (rand() % ((max + 1) - min)) + min; }
