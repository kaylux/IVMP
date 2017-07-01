/********************************************************************************
*                 Copyright © 2011 - Valhalla Gaming                            *
*                                 Admin Script                                  *
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
	log("*     Valhalla Script | Admin 1 Loaded            *");
	log("***************************************************");
}

addEvent("scriptInit", onScriptInit);



function onScriptExit( )
{
	log("***************************************************");
	log("*     Valhalla Script | Admin 2 Un-Loaded         *");
	log("***************************************************");
}
addEvent("scriptExit", onScriptExit);

function onPlayerCommand(playerid, command)
{
	local cmd = split(command, " ");
	local str;
	if(player.isAdmin(playerid))
	{
		if(cmd[0] == "/sql")
		{
			if(pData[playerid].admin > 5)
			{
				if(cmd.len() > cmd[1].len + 2)
				{
					if(cmd[1] == "Drop" || cmd[1] == "drop")
					{
						adminMessage(playerid, "[ADMIN" +getPlayerName(playerid)+"]Executed(Failed):" + str, COLOR_WHITE);
						log("[ADMIN" +getPlayerName(playerid)+"]Executed(Failed):" + str );
						return 1;
					}
					else
					{
						str = command.slice(cmd[0].len()+cmd[1].len()+2, command.len());
						adminMessage(playerid, "[ADMIN" +getPlayerName(playerid)+"]Executed:" + str, COLOR_WHITE);
						log("[ADMIN" +getPlayerName(playerid)+"]Executed:" + str);
						sql.query(str);
					}
				}
			}
		}
		if(cmd[0] == "/ahelp" || cmd[0] == "/ah")
		{
			sendPlayerMessage(playerid, "__________________Admin Commands__________________", COLOR_WHITE);
			sendPlayerMessage(playerid, "[Trial Admin ] /kick, /a, /aod, /cr, /slap /freeze /uf /goto /gethere /getip", COLOR_YELLOW);
			sendPlayerMessage(playerid, "[Normal Admin]  /ban /editfac(tion) /editacc(ount)", COLOR_YELLOW);
			sendPlayerMessage(playerid, "[Super Admin]  /veh  /gwep /unbanip /unban", COLOR_YELLOW);
			sendPlayerMessage(playerid, "[ Head Admin ] /addfac(tion) /delveh /addhouse /addbiz /deletehouse /deletebiz ", COLOR_YELLOW);
			sendPlayerMessage(playerid, "[   Owner    ] /close /servername /consule /serverpass", COLOR_YELLOW);

		}
		if(cmd[0] == "/editacc" || cmd[0] == "/editaccount") //editacc [Player] [Option] [Amount]
		{
			if(pData[playerid].admin > 2)
			{
				if(cmd.len() > cmd[0].len + 2)
				{	
					local id = returnUser(cmd[1].tointeger);
					if(isPlayerConnected(id))
					{
						if(isNumeric(cmd[3].tointeger))
						{
							local option = cmd[3].tointeger;
							if(cmd[2] == "warns")
							{
								pData[id].warns = option;
								adminMessage("Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s warns to "+ option, COLOR_GRAY);
							}
							if(cmd[2] == "age")
							{
								pData[id].age = option;
								adminMessage ("Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s age to "+ option, COLOR_GRAY);
							}
							if(cmd[2] == "level")
							{
								pData[id].level = option;
								adminMessage( "Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s level to "+ option, COLOR_GRAY);
							}
							if(cmd[2] == "model")
							{
								if(option > 1 && option > 346)
								{
									pData[id].model = option;
									setPlayerModel(id, option);
									adminMessage( "Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s model to "+ option, COLOR_GRAY);
								}
								else
								{
									sendPlayerMessage(playerid, "Invalid Skin ID!", COLOR_YELLOW);
								}
							}
							if(cmd[2] == "bank")
							{
								pData[id].bank = option;
								adminMessage( "Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s bank to "+ option, COLOR_GRAY);
								
							}
							if(cmd[2] == "cash")
							{
									pData[id].cash = option;
									adminMessage( "Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s cash to "+ option, COLOR_GRAY);
							}
							if(cmd[2] == "faction")
							{
								pData[id].faction = option;
								adminMessage( "Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s faction to "+ option, COLOR_GRAY);
							}
							if(cmd[2] == "rank")
							{
								pData[id].rank = option;
								adminMessage( "Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s faction rank to "+ option, COLOR_GRAY);
							}
							if(cmd[2] == "job")
							{
								if(option > 0 && option > 4)
								{
									pData[id].job = option;
									adminMessage( "Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s job to "+ option, COLOR_GRAY);
								}
								else
								{
									sendPlayerMessage(playerid, "Invalid Job ID!", COLOR_YELLOW);
								}
							}								
							if(cmd[2] == "drugs")
							{
								pData[id].drugs = option;
								adminMessage( "Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s drugs to "+ option, COLOR_GRAY);
							}
							if(cmd[2] == "leader")
							{
								pData[id].rank = option;
								adminMessage( "Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s leader faction to "+ option, COLOR_GRAY);
							}
							if(cmd[2] == "donator")
							{
								pData[id].donator = option;
								adminMessage( "Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s donator rank to "+ option, COLOR_GRAY);
							}
							if(cmd[2] == "sex")
							{
								pData[id].sex = option;
								adminMessage( "Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s sex to "+ option, COLOR_GRAY);
							}
							if(cmd[2] == "carlic")
							{
								if(option == 1 || option == 2 || option == 3)
								{
									pData[id].carlic = option;
									adminMessage( "Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s car licence to "+ option, COLOR_GRAY);
								}
								else
								{
									sendPlayerMessage(playerid, "Invalid Option! 1 == No Licence, 2 == License, 3 == Suspended License", COLOR_YELLOW);
								}
							}
							if(cmd[2] == "flylic")
							{
								if(option == 1 || option == 2 || option == 3)
								{
									pData[id].flylic = option;
									adminMessage( "Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s flying licence to "+ option, COLOR_GRAY);
								}
								else
								{
									sendPlayerMessage(playerid, "Invalid Option! 1 == No Licence, 2 == License, 3 == Suspended License", COLOR_YELLOW);
								}
							}
							if(cmd[2] == "gunlic")
							{
								if(option == 1 || option == 2 || option == 3)
								{
									pData[id].gunlic = option;
									adminMessage( "Admin " +getPlayerName(playerid)+ " set "+ getPlayerName(playerid)+ "'s gun licence to "+ option, COLOR_GRAY);
								}
								else
								{
									sendPlayerMessage(playerid, "Invalid Option! 1 == No Licence, 2 == License, 3 == Suspended License", COLOR_YELLOW);
								}
							}
						}
						else
						{
							sendPlayerMessage(playerid, "SYNTAX: /editacc(ount) [ Player ] [ Option ] [ Ammount ]", COLOR_YELLOW);
							sendPlayerMessage(playerid, "age level model bank cash faction rank job drugs leader donator sex ", COLOR_WHITE);
							sendPlayerMessage(playerid, "carlic flylic gunlic", COLOR_YELLOW);
						}
					}
					else
					{
						sendPlayerMessage(playerid, "Invalid Player!", COLOR_YELLOW);
					}
				}
				else
				{
					sendPlayerMessage(playerid, "SYNTAX: /editacc(ount) [ Player ] [ Option ] [ Ammount ]", COLOR_YELLOW);
					sendPlayerMessage(playerid, "age level model bank cash faction rank job drugs leader donator sex ", COLOR_WHITE);
					sendPlayerMessage(playerid, "carlic flylic gunlic", COLOR_YELLOW);
				}
			}
		}
		if(cmd[0] == "/gwep")
		{
			if(pData[playerid].admin > 3)
			{
				if(cmd.len() > cmd[0].len + 2)
				{
					local id = returnUser(cmd[1].tointeger);
					local weaponid = cmd[2].tointeger;
					local ammo = cmd[3].tointeger;
					if(!isPlayerConnected(id))
						return sendPlayerMessage(playerid, "Invalid player!", COLOR_GRAY);
					if(weaponid >= 0 && weaponid < 18)
					{
						if(ammo == 0)
						{
							givePlayerWeapon(id, weaponid, 9999);
							return 1;
						}
						else
						{
							givePlayerWeapon(id, weaponid, ammo);
							return 1;
						}
					}
					else
					{
						sendPlayerMessage(playerid, "Invalid Weapon ID", COLOR_YELLOW);
					}
				}
				else
				{
					sendPlayerMessage(playerid, "Please Enter A Name/ID | SYNTAX /gwep [ Name/ID ] [ Wep ] [ Ammo ]", COLOR_YELLOW);
				}
			}
		}
		if(cmd[0] == "/unban")
		{
			if(cmd.len > 6)
			{
				local check = sql.query("SELECT FROM bans WHERE Name = '" + cmd[1] + "'");
				if(check)
				{
					sql.query("DELETE FROM bans WHERE Name = '" + cmd[1] + "'");
				}
				else
				{
					sendPlayerMessage(playerid, "Player Not Banned", COLOR_YELLOW);
				}
			}
			else
			{
					sendPlayerMessage(playerid, "Please Enter A Name | SYNTAX /unban [ Name ]", COLOR_YELLOW);
			}
		}
		if(cmd[0] == "/unbanip")
		{
			if(cmd.len > 6)
			{
				local check = sql.query("SELECT FROM bans WHERE IP = '" + cmd[1] + "'");
				if(check)
				{
					sql.query("DELETE FROM bans WHERE IP = '" + cmd[1] + "'");
				}
				else
				{
					sendPlayerMessage(playerid, "IP Not Banned", COLOR_YELLOW);
				}
			}
			else
			{
				sendPlayerMessage(playerid, "Please Enter A IP | SYNTAX /unbanip [ IP ]", COLOR_YELLOW);
			}
		}
		if(cmd[0] == "/veh")
		{
			if(pData[playerid].admin > 2)
			{
				local vehicleid = cmd[1].tointeger();
				if(cmd.len() >= 6)
				{
					if(!isNumeric(cmd[2].tointeger) || !isNumeric(cmd[3].tointeger) || !isNumeric(cmd[4].tointeger) || !isNumeric(cmd[5].tointeger))
						return sendPlayerMessage(playerid, "SYNTAX: /veh [ID (1-123)] [Color 1] [Color 2] [Color 3] [Color 4]", COLOR_YELLOW);
					local pos = getPlayerCoordinates(playerid);
					local Color1 = cmd[2].tointeger();
					local Color2 = cmd[3].tointeger();					
					local Color3 = cmd[4].tointeger();
					local Color4 = cmd[5].tointeger();					
					local veh = createVehicle(vehicleid, pos[0]+1, pos[1], pos[2], getPlayerHeading(playerid), Color1, Color2, Color3, Color4);
					vehicle.create(vehicleid, getPlayerName(playerid), "NONE", 0, 0, Color1, Color2, Color3, Color4, 0 , 1000)
					vData[veh] <- { };
					vData[veh].id <- veh;
					vData[veh].model <- vehicleid;
					vData[veh].spawnx <- pos[0];
					vData[veh].spawny <- pos[1];
					vData[veh].spawnz <- pos[2];
					vData[veh].spawnrot < getPlayerHeading(playerid);
					vData[veh].color1 <- Color1;
					vData[veh].color2 <- Color2;
					vData[veh].color3 <- Color3;
					vData[veh].color4 <- Color4;
					vData[veh].damage <- 1000;
					vData[veh].enginedamage <- 1000;
					vData[veh].plate <- "Default";
					vData[veh].fuel <- 100;
					vData[veh].engine <- 0;
					vData[veh].lights <- 1;
					vData[veh].dirt <- 0.0;
					vData[veh].faction <- 0;
					vData[veh].owner <- "None";
					vData[veh].admin <- 0;
					vData[veh].lock <- 0;
					vData[veh].forsale <- 0;
					vData[veh].price <- 0;
						
				}
				else
				{
					sendPlayerMessage(playerid, "SYNTAX: /veh [ID (1-123)] [Color 1] [Color 2] [Color 3] [Color 4]", COLOR_YELLOW);
				}
			}
			return 1;
		}
		if(cmd[0] == "/getip")
		{
			if(cmd.len() < 2)
				return sendPlayerMessage(playerid, "SYNTAX: /getip [ID]", COLOR_YELLOW);
		
			local id = returnUser(cmd[1]);
			if(!isPlayerConnected(id))
				return sendPlayerMessage(playerid, "Invalid player!", COLOR_GRAY);

			sendPlayerMessage(playerid, "IP: "+getPlayerName(id)+" - "+getPlayerIp(id), COLOR_RED);
			return 1;
		}
		if(cmd[0] == "/goto")
		{			
			if(cmd.len() < 2)
				return sendPlayerMessage(playerid, "USE: /goto [ID]", COLOR_YELLOW);
				
			local id = returnUser(cmd[1]);
			if(!isPlayerConnected(id))
				return sendPlayerMessage(playerid, "Invalid player!", COLOR_GRAY);		
			local pos = getPlayerCoordinates(id);
			
			if(isPlayerInAnyVehicle(playerid))
			{
				local vehicleid = getPlayerVehicleId(playerid);
				setVehicleCoordinates(vehicleid, pos[0]+1, pos[1], pos[2]);
			}
			else
			{
				setPlayerCoordinates(playerid, pos+1, pos, pos);
			}
			return 1;
		}
		if(cmd[0] == "/gethere")
		{			
			if(cmd.len() < 2)
				return sendPlayerMessage(playerid, "USE: /gethere [ID]", COLOR_YELLOW);
						
			local id = returnUser(cmd[1]);
			if(!isPlayerConnected(id))
				return sendPlayerMessage(playerid, "Invalid player!", COLOR_GRAY);		
			local pos = getPlayerCoordinates(playerid);
				
			if(isPlayerInAnyVehicle(id))
			{
				local vehicleid = getPlayerVehicleId(id);
				setVehicleCoordinates(vehicleid, pos[0]+1, pos[1], pos[2]);
			}
			else
			{
				setPlayerCoordinates(id, pos+1, pos, pos);
				return 1;		
			}
		}
		if(cmd[0] == "/freeze")
		{
			if(cmd.len() < 2)
				return sendPlayerMessage(playerid, "SYNTAX /freeze [ID/PlayerName]", COLOR_GRAY);
					
			local id = returnUser(cmd[1]);
			if(!isPlayerConnected(id))
				return sendPlayerMessage(playerid, "Invalid player!", COLOR_RED);
						
			togglePlayerFrozen(id, true);
			sendPlayerMessage(id, "You were frozen by admin: " +getPlayerName(playerid), COLOR_ADMIN);
			sendPlayerMessage(id, "You frozeplayer: " +getPlayerName(id), COLOR_RED);
			return 1;
		}
		if(cmd[0] == "/unfreeze" || cmd[0] == "/uf")
		{
			if(cmd.len() < 2)
				return sendPlayerMessage(playerid, "SYNTAX /uf [ID/PlayerName]", COLOR_GRAY);
					
			local id = returnUser(cmd[1]);
			if(!isPlayerConnected(id))
				return sendPlayerMessage(playerid, "Invalid player!", COLOR_RED);
						
			togglePlayerFrozen(id, false);
			sendPlayerMessage(id, "You were frozen by admin: " +getPlayerName(playerid), COLOR_ADMIN);
			sendPlayerMessage(id, "You unfroze player: " +getPlayerName(id), COLOR_RED);
			return 1;
		}
		if (cmd[0] == "/cr")
		{
			if (cmd.len() < 2)
				return sendPlayerMessage(playerid, "SYNTAX: /cr [Id/Name]", COLOR_ORANGE);

				
			local id = returnUser(cmd[1]);
			if(!isPlayerConnected(id))
				return sendPlayerMessage(playerid, "Invalid player!", COLOR_RED);
			if(pData[id].report == 1)
			{
				pData[id].report = 0;
				sendPlayerMessage(id, "Admin "+getPlayerName(playerid)+" Called Your Report", COLOR_TEAL);
			}
			for(local i = 0; i < MAX_PLAYERS; i++)
			{
				if(pData[i].admin > 0)
				{
					sendPlayerMessage(i, getPlayerName(playerid)+" Called "+getPlayerName(id)+"'s Report", COLOR_TEAL);
				}
			}
		}
		if(cmd[0] == "/aod")
		{
			if(pData[playerid].aod == 1)
			{
				sendPlayerMessage(playerid, "You Are Now Off-Duty As An Admin", COLOR_TEAL);
				pData[playerid].aod = 0;
				return 1;
			}
			if(pData[playerid].aod == 0)
			{
				sendMessageToAll(getPlayerName(playerid)+" is now on duty as an admin", COLOR_YELLOW);
				pData[playerid].aod = 1;
				return 1;
			}
			return 1;
		}			
		if (cmd[0] == "/a")
		{
			if (cmd.len() < 2)
				return sendPlayerMessage(playerid, "SYNTAX: /a [Text]", COLOR_ORANGE);

			for (local i = 0; i < MAX_PLAYERS; i++)
			{
				if(pData[playerid].admin < 2)
				{
					sendPlayerMessage(i, "(( Admin "+getPlayerName(playerid)+"["+playerid+"]: "+command.slice(cmd[0].len()+1, command.len())+" ))", COLOR_ORANGE);
					return 1;
				}
				if(pData[playerid].admin > 2)
				{
					sendPlayerMessage(i, "(( Senior Admin "+getPlayerName(playerid)+"["+playerid+"]: "+command.slice(cmd[0].len()+1, command.len())+" ))", COLOR_RED);
					return 1;
				}
			}
		}
		if(cmd[0] == "/slap")
		{
			if(cmd.len() < 2)
				return sendPlayerMessage(playerid, "SYNTAX /slap [ID/PlayerName]", COLOR_GRAY);
				
			local id = returnUser(cmd[1]);
			if(!isPlayerConnected(id))
				return sendPlayerMessage(playerid, "Invalid player!", COLOR_RED);
						
			local Position = getPlayerCoordinates(id);
			setPlayerCoordinates(id, Position[0], Position[1], Position[2]+10);
			sendPlayerMessage(id, "You were slapped by admin: " +getPlayerName(playerid), COLOR_ADMIN);
			sendPlayerMessage(id, "You slapped player: " +getPlayerName(id), COLOR_RED);
			return 1;
		}			
		if(cmd[0] == "/kick")
		{
			if(cmd.len() < 5)
				return sendPlayerMessage(playerid, "USE: /kick [ID/Name] [Reason]", COLOR_GRAY);
					
			if(cmd[2].len() < 1)
				return sendPlayerMessage(playerid, "USE: /kick [ID/Name] [Reason]", COLOR_GRAY);
			local reason = command.slice(cmd[1].len()+1, command.len());
			local id = returnUser(cmd[1]);
			if(!isPlayerConnected(id))
				return sendPlayerMessage(playerid, "Invalid player!", COLOR_RED);
				
			if(cmd.len() > 6)
				return sendMessageToAll( "[ADMIN] :"+getPlayerName(playerid)+"["+playerid+"] has kicked " + getPlayerName(id)"["+id+"]. Reason: "+reason, COLOR_ADMIN);
			kickPlayer(id, true);
		}
		if(cmd[0] == "/ban")
		{
			if(cmd.len() < 2)
				return sendPlayerMessage(playerid, "USE: /ban [ID/Name] [Reason]", COLOR_GRAY);
								
			if(cmd[2].len() < 1)
				return sendPlayerMessage(playerid, "USE: /kick [ID/Name] [Reason]", COLOR_GRAY);
					
			local id = returnUser(cmd[1]);
			local reason = command.slice(cmd[1].len()+1, command.len());
			if(!isPlayerConnected(id))
				return sendPlayerMessage(playerid, "Invalid player!", COLOR_RED);
				
			if(cmd.len() > 6)
				return sendMessageToAll( "[ADMIN] :"+getPlayerName(playerid)+"["+playerid+"] has BANNED " + getPlayerName(id)"["+id+"]. Reason: "+reason, COLOR_ADMIN);
			sql.query("INSERT INTO bans (Name, IP, Admin, Reason) VALUES ('"+getPlayerName(id)+"','"+getPlayerIp(id)+"', '"+getPlayerName(playerid)+"', '"+reason+"')")
			kickPlayer(id, true);
		}
	}
	return 0;
}
addEvent("playerCommand", onPlayerCommand);