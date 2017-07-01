/********************************************************************************
*                 Copyright © 2011 - Valhalla Gaming                            *
*                              Job Script                                       *
*                      Original Authors: 	Broski - James                      *
*                             Created: 	19/03/11                                *
*                       Title:		Valhalla Gaming : IV                        *
*                              Version:	0.0.5e	                                *
*                                                                               *
*____________________________________Change Log_________________________________*
*                          James - Created                                      *
*********************************************************************************
*________________________Static Jobs____________________________________________*
*                                                                               *
*                    J ID 1: Oil                                                *
*                    J ID 2: Taxi                                               *
*                    J ID 3: None                                               *
*                                                                               *
*______________________________Misc.____________________________________________*
********************************************************************************/

function onScriptInit()
{
	log("***************************************************");
	log("*     Valhalla Script | Jobs Loaded                *");
	log("***************************************************");
}

addEvent("scriptInit", onScriptInit);



function onScriptExit( )
{
	log("***************************************************");
	log("*     Valhalla Script | Jobs Un-Loaded            *");
	log("***************************************************");
}
addEvent("scriptExit", onScriptExit);

local oil = array(MAX_PLAYERS, 0); // Oil Trucker Array
local PayDay = array(MAX_PLAYERS, 0); // Pay Day Array



function onPlayerCommand(playerid, command)
{
	local cmd = split(command, " ");
	local str;
		
	if(cmd[0] == "/job")
	{	
		if(command.len() > cmd[0].len() + 2)
		{
			if(cmd[1] == "help")
			{
				if(PlayerToPoint(playerid, 5, 813.508545, 1577.552612, 18.216736)) //Trucker
				{
					sendPlayerMessage(playerid, "To start your trucking shift. Get into a truck a use /job start", COLOR_GREEN);
				}
			}
			if(cmd[1] == "get")
			{
				if(pData[playerid].job == 0)
				{
					if(PlayerToPoint(playerid, 5, 813.508545, 1577.552612, 18.216736)) //Trucker
					{
						sendPlayerMessage(playerid, "You are now a trucker!", COLOR_GREEN);
						pData[playerid].job = 1;
					}
				}
			}
			if(cmd[1] == "quit")
			{
				if(pData[playerid].job > 0) //All
				{
					pData[playerid].job = 0;
					sendPlayerMessage(playerid, "You have quit your job!", COLOR_GREEN);
				}
			}
			else
			{
				sendPlayerMessage(playerid, "/job help|get|quit", COLOR_GREEN);
			}
		}
		else
		{
			sendPlayerMessage(playerid, "/job help|get|quit", COLOR_GREEN);
		}
	}
	if(cmd[0] == "/pickup")
	{
		if(command.len() > cmd[0].len() + 2)
		{
			if(cmd[1] == "fuel")
			{
				if(pData[playerid].job == 1)
				{
					if(Oil[playerid] < 200)
					{
						if(getVehicleModel(getPlayerVehicleId(playerid)) == 55)
						{
							if(PlayerToPoint(playerid, 5, 813.508545, 1577.552612, 18.216736))
							{
								local fuel = 200 - Oil[playerid];
								Oil[playerid] = Oil[playerid] + fuel;
								sendPlayerMessage(playerid, "Truck Filled With "+ fuel + " Gallons of fuel", COLOR_GREEN);
							}
							else
							{
								sendPlayerMessage(playerid, "You Must Be At The Fill Location", COLOR_GREEN);
							}
						}
						else
						{
							sendPlayerMessage(playerid, "You Must Be In A Tanker!", COLOR_GREEN);
						}
					}
				}
			}
			else
			{
				sendPlayerMessage(playerid, "/pickup fuel", COLOR_GREEN);
			}
		}
		else
		{
			sendPlayerMessage(playerid, "/pickup fuel", COLOR_GREEN);
		}
	}
	if(cmd[0] == "/dropoff")
	{	
		if(command.len() > cmd[0].len() + 2)
		{
			if(cmd[1] == "fuel")
			{
				if(pData[playerid].job == 1)
				{
					if(getVehicleModel(getPlayerVehicleId(playerid)) == 50)
					{
						if(PlayerToPoint(playerid, 5, 107.619843, 1138.559448, 14.882010) || PlayerToPoint(playerid, 5, -479.977081, -206.760300, 8.072400))
						{
							Oil[playerid] = 0;
							sendPlayerMessage(playerid, "You sold 200 galons of fuel to the station. $30 will be added to your paycheck", COLOR_GREEN);
							PayDay[playerid] = PayDay[playerid] + 30;
						}
						else
						{
							sendPlayerMessage(playerid, "You Must Be At A Gas Station!", COLOR_GREEN);
						}
					}
					else
					{
						sendPlayerMessage(playerid, "You Must Be In A Tanker!", COLOR_GREEN);
					}
				}
			}
			else
			{
				sendPlayerMessage(playerid, "/dropoff fuel", COLOR_GREEN);
			}
		}
		else
		{
			sendPlayerMessage(playerid, "/dropoff fuel", COLOR_GREEN);
		}
	}

}
addEvent("playerCommand", onPlayerCommand);


