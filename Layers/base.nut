/*
* base.nut
* 	Base Layer
* 		 Valhalla Gaming 2011
*/
log("VAL|-|ALLA-GAMING IV:MP SCRIPT");
dofile( "scripts/mysql.nut");
dofile( "scripts/mysql_login.nut");
dofile(	"scripts/banking.nut");

colour <-
{
	white = 0xFFFFFFFF,
	error = 0xFF0000FF,
	info  = 0xFFAADDFF,
}

function PlayerToPoint(playerid,radi, x, y, z)
{    if(isPlayerConnected(playerid))	
	{		local oldposx, oldposy, oldposz;		
			local tempposx, tempposy, tempposz;		
			local oldpos = getPlayerCoordinates(playerid);		
			tempposx = (oldpos[0] -x);		
			tempposy = (oldpos[1] -y);		
			tempposz = (oldpos[2] -z);		
			if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))	
			{			
			return 1;		
			}	
		}	
return 0;
}

function onPlayerConnect(playerid)
{
	sendPlayerMessage(playerid, "Welcome to VAL|-|ALLA-GAMING's testing ground", colour.info);
	log("Info: " +getPlayerName(playerid) + " has joined our server");
	setPlayerSpawnLocation(playerid, 937.4, -554.7, 14.1, 0.0);
}
addEvent("playerConnect", onPlayerConnect);

function onPlayerCommand(playerid, command)
{
	local cmd = split( command, " " );
	
	if (cmd[0] == "/clearchat")
	{
	for( local i = 0; i < 10; i++ )
	sendPlayerMessage(playerid, " " );
	}
	

}
addEvent("playerCommand", onPlayerCommand);