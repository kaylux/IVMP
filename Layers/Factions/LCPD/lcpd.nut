/********************************************************************************
*                 Copyright © 2011 - Valhalla Gaming                            *
*                                 LCPD Script   2                               *
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
	log("*     Valhalla Script | LCPD 1 Loaded             *");
	log("***************************************************");
}

addEvent("scriptInit", onScriptInit);



function onScriptExit( )
{
	log("***************************************************");
	log("*     Valhalla Script | LCPD 2 Un-Loaded           *");
	log("***************************************************");
}
addEvent("scriptExit", onScriptExit);
function onPlayerCommand(playerid, command)
{
	local cmd = split(command, " ");
	local str;
	if(player.isACop(playerid))
	{
		if(cmd[0] == "/lcpdhelp")
		{
			sendPlayerMessage(playerid, "______________________LCPD Commands______________________", COLOR_WHITE);
			sendPlayerMessage(playerid, "[GENERAL] /duty, /ticket, /jail, /release, /su", COLOR_YELLOW);
			sendPlayerMessage(playerid, "[GENERAL] /taze /roadcone /roadblock1 /roadblock2", COLOR_YELLOW);
			sendPlayerMessage(playerid, "[CHAT] /(r)adio, /(m)egaphone, /dr, /(f)actionchat", COLOR_YELLOW);
			if(pData[playerid].leader == 1)
			{
				sendPlayerMessage(playerid, "[CHAT] /gov", COLOR_YELLOW);
				sendPlayerMessage(playerid, "[ROSTER] /hire, /fire, /crank", COLOR_YELLOW);
			}
		}
		if(cmd[0] == "/roadcone")
		{
			local pos = getPlayerCoordinates (playerid);
			if(pData[player].faction == 1 || pData[player].faction == 2)
			{
				createObject (529682743, pos[0], pos[1], pos[2] -1, 0.0, 0.0, 0.0 );
			}
			else
			{
				sendPlayerMessage(player, "You are not part of the LCPD or FBI", 0xFFFFFFFF);
			}

		}
		if(cmd[0] == "/roadblock1")
		{
			local pos = getPlayerCoordinates (playerid);
			local rot = getPlayerHeading (playerid);
	
			if(pData[player].faction == 1 || pData[player].faction == 2)
			{
				createObject (1733222020, pos[0], pos[1], pos[2] -1, 0.0, 0.0, rot );	
			}
			else
			{
				sendPlayerMessage(player, "You are not part of the LCPD or the FBI", 0xFFFFFFFF);
	
			}
		}
		if(cmd[0] == "/roadblock2")
		{
			local pos = getPlayerCoordinates (playerid);
			local rot = getPlayerHeading (playeri);
		
			if(pData[player].faction == 1 || pData[player].faction == 2)
			{
				createObject (3604960817, pos[0], pos[1], pos[2] -1, 0.0, 0.0, rot );
			}
			else
			{
				sendPlayerMessage(player, "You are not part of the LCPD or the FBI", 0xFFFFFFFF);
	
			}
		}
		if(cmd[0] == "/duty")
		{
			if(pData[playerid].PDduty == 0)
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
							sendPlayerMessage(i, "[RADIO: " + ranktext + " " + getPlayerName(playerid) + "]:" + "Signing On Duty", COLOR_TEAL);
							pData[playerid].PDduty = 1;
							return 1;
						}
					}
				}
			}
			if(pData[playerid].PDduty == 1)
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
							sendPlayerMessage(i, "[RADIO: " + ranktext + " " + getPlayerName(playerid) + "]:" + "Signing Off", COLOR_TEAL);
							pData[playerid].PDduty = 0;
							return 1;
						}
					}
				}
			}
		}
		if(cmd[0] == "/ticket")
		{
			if(command.len() > cmd[0].len()+1)
			{
				if(returnUser(cmd[1]))
				{
					local target = returnUser(cmd[1]);
					if(command.len() > cmd[1].len()+1)
					{
						if(isNumeric(cmd[2]))
						{
							local ticket = cmd[2].tointeger;
							pData[target].ticket <- ticket;
							pData[target].ticketer <- playerid;
							sendPlayerMessage(target, "Ticket Recived From" + " " + getPlayerName(playerid) + " " + "For:" + " " + ticket + "To Accept The Ticket, Type /acceptticket", COLOR_YELLOW);
							sendPlayerMessage(playerid, "Ticket Sent to" + " " + getPlayerName(target) + " " + "For:" + " " + ticket, COLOR_YELLOW);
						}
						else
						{
							sendPlayerMessage(playerid, "[vG]: Invalid Ticket Price.", COLOR_YELLOW);
						}
					}
					else
					{
						sendPlayerMessage(playerid, "[vG]: Please provide a ammount.", COLOR_YELLOW);
					}
				}
				else
				{
					sendPlayerMessage(playerid, "[vG]: Invalid player.", COLOR_YELLOW);
				}				
			}
			else
			{
				sendPlayerMessage(playerid, "SYNTAX: /ticket [Player] [Amount]",  COLOR_GRAY);
			}
		}
		if(cmd[0] == "/acceptticket")
		{
			if(pData[playerid].ticket > 0)
			{
				if(pData[playerid].cash >= pData[playerid].ticket)
				{
					local target = pData[playerid].ticketer;
					pData[playerid].ticket = pData[playerid].cash - pData[playerid].ticket;
					sendPlayerMessage(playerid, "Ticket For: $" + pData[playerid].ticket " Payed", COLOR_YELLOW);
					sendPlayerMessage(target, "Player " + getPlayerName(playerid) + " Accepted And Payed Your Ticket", COLOR_YELLOW);
					pData[playerid].ticket = 0;
					pData[playerid].ticketer = "None";
					
				}
				else
				{
					sendPlayerMessage(playerid, "[vG] You Do Not Have Enough Money To Pay For The Ticket", COLOR_YELLOW);
				}
			}
			else
			{
				sendPlayerMessage(playerid, "[vG] You Do Not Have A Ticket", COLOR_YELLOW);
			}
		
		}
	}
	else
	{
		sendPlayerMessage(playerid, "[vG] You Are Not A Cop", COLOR_YELLOW);
	}
}
addEvent("playerCommand", onPlayerCommand);