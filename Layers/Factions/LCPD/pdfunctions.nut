/********************************************************************************
*                 Copyright © 2011 - Valhalla Gaming                            *
*                                LCPD Script 2                                  *
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
	log("*     Valhalla Script | LCPD 2 Loaded             *");
	log("***************************************************");
}

addEvent("scriptInit", onScriptInit);



function onScriptExit( )
{
	log("***************************************************");
	log("*     Valhalla Script | LCPD 2 Loaded             *");
	log("***************************************************");
}
addEvent("scriptExit", onScriptExit);

function PDRadio(playerid, string,col1)
{
	if(isPlayerConnected(playerid))
	{
		for(local i = 0; i < MAX_PLAYERS; i++)
		{
			if(isPlayerConnected(i))
			{
				if(pData[i].faction == 1)
				{
					local ranktext;
					if(pData[playerid].rank == 1) { ranktext = "Cadet" }
					if(pData[playerid].rank == 2) { ranktext = "Officer" }
					if(pData[playerid].rank == 3) { ranktext = "Corporal" }
					if(pData[playerid].rank == 4) { ranktext = "Seargant" }
					if(pData[playerid].rank == 5) { ranktext = "Lieutenant" }
					if(pData[playerid].rank == 6) { ranktext = "Captain" }
					if(pData[playerid].rank == 7) { ranktext = "Commander" }
					if(pData[playerid].rank == 8) { ranktext = "Asst. Cheif" }
					if(pData[playerid].rank == 9) { ranktext = "Cheif" }
					sendPlayerMessage(i, "[RADIO: " + ranktext + " " + getPlayerName(playerid) + "]:" + string, col1);
				}
			}
		}
	}
	return 1;
}

