/********************************************************************************
*                 Copyright © 2011 - Valhalla Gaming                            *
*                                                                               *
*                      Original Authors: 	Broski - James                      *
*                             Created: 	08/03/10                                *
*                       Title:		Valhalla Gaming : IV                        *
*                              Version:	0.0.5e	                                *
*                                                                               *
*____________________________________Change Log_________________________________*
*                   James - Updated fucntions to Beta 1                         *
*                   James - Fixed Alot of bugs and updated MySQL fucntions      *
*                   James - Added Factions + Edits to functions                 *
*                   James - Vehicle System Tidy Up                              *
*                   James - Updated Script to 0.1 T1                            *
*                   James - Vehicle System Tidy Up                              *
*                   James - Admin Logs + Vehicle Saving                         *
*                   James - Faction System/PD Tidy-Up                           *
*                   James - Added Basic Job System                              *
********************************************************************************/


//General
dofile("scripts/Layers/misc.nut"); // Misc.
dofile("scripts/Layers/functions.nut"); // Functions
dofile("scripts/Layers/sql.nut"); // SQL Data
dofile("scripts/Layers/players.nut"); // Player Data
dofile("scripts/Layers/Factions/factions.nut"); // Faction Data
dofile("scripts/Layers/vehicles.nut"); // Vehicle Data
dofile("scripts/Layers/banking.nut"); // Banking Data
dofile("scripts/Layers/housing.nut"); // Housing Data
dofile("scripts/Layers/jobs.nut"); // Job Data



//Admin
dofile("scripts/Layers/Admin/admincmds.nut"); // Admin Commands


//PD Data
dofile("scripts/Layers/Factions/LCPD/pdfunctions.nut"); // LCPD Functions
dofile("scripts/Layers/Factions/LCPD/lcpd.nut"); // LCPD 


//Etc
dofile("scripts/mysql.nut");


function onPlayerCommand(playerid, command)
{
	local cmd = split(command, " ");
	local str;
	if(cmd[0] == "/login")
	{
		if(command.len() >= cmd[0].len()+6)
		{
			if( !account.load(getPlayerName(playerid), pData[playerid]))
			{
				sendPlayerMessage(playerid, "[vG]: You have not yet registered. Please register.", COLOR_YELLOW);
				sendPlayerMessage(playerid, "SYNTAX: /register [password]",COLOR_GRAY);
			}
			else
			{
				if(whirlpool(cmd[1]) == pData[playerid].password )
				{
					
					sendPlayerMessage(playerid, "[vG]: Welcome back to vG IV:MP , "+getPlayerName(playerid)+"!",  COLOR_YELLOW);
					pLog[playerid] = 1;
					togglePlayerControls (playerid, true);

				}
				else
				{
					sendPlayerMessage(playerid, "[vG]: Incorrect password. 3 tries will get you kicked.", COLOR_YELLOW);
					log(getPlayerName(playerid) + "|Failed Login, Using Pass:" +  md5(cmd[1]) + "Actuall Pass:" + pData[playerid].password);
				}
			}
		}
		else
		{
			sendPlayerMessage(playerid, "SYNTAX: /login [password]", COLOR_GRAY);
		}
	}

	if(cmd[0] == "/register") 
	{
		if( command.len() >= cmd[0].len() + 6 )
		{
			if( pReg[playerid] == 1 )
			{
				sendPlayerMessage(playerid, "[vG]: Account is already registered. Use /login [password]",COLOR_YELLOW);
			}
			else
			{
				account.create(getPlayerName(playerid), cmd[1].tostring());
				sendPlayerMessage(playerid, "[vG]: Account created. Automatically logged in.", COLOR_YELLOW);
				account.load(getPlayerName(playerid), pData[playerid]);
				setPlayerCoordinates(playerid, 385.374939, 1636.597900, 26.912529);
				setPlayerHeading(playerid, 319.445007);
				pLog[playerid] = 1;
				pReg[playerid] = 1;
				pData[playerid].model <- 23;
				local Date = date();
				pData[playerid].reg = Date["year"] + "-" + (Date["month"]+1) + "-" + Date["day"]
				togglePlayerControls (playerid, true)
				account.save(getPlayerName(playerid), pData[playerid]);
			}
		}
		else
		{
			sendPlayerMessage(playerid, "SYNTAX: /register [password] (password must be longer than 5 characters)", COLOR_GRAY);
		}
	}
//****************************************************************************************************
//****************************************Logged in Commands******************************************
//****************************************************************************************************
	if(pLog[playerid] == 1)
	{
		if(cmd[0] == "/help")
		{
			sendPlayerMessage(playerid, "|| Welcome To Valhalla Gaming IV:MP Roleplay Server.||", COLOR_WHITE);
			sendPlayerMessage(playerid, "|| In This Server We Have Strict Rules. Please Take Time To Read /rules. Thanks! || ", COLOR_GREEN);
			sendPlayerMessage(playerid, "|| /commands Will Give An In-Depth List Of Our Current Commands ||", COLOR_WHITE);	
			return 1;
		}
		if(cmd[0] == "/commands")
		{
			sendPlayerMessage(playerid, "|| /me /do /b /pm /enter /exit||", COLOR_WHITE);
			sendPlayerMessage(playerid, "|| /vehhelp /fachhelp  /job||", COLOR_GRAY);

		}
		if(cmd[0] == "/report")
		{
			if(command.len() > cmd[0].len()+1)
			{
				str = command.slice(cmd[0].len()+1, command.len());
				for(local i = 0; i < getPlayerSlots(); i++)
				{
					if(isPlayerConnected(i))
					{
						if(player.isAdmin(i))
						{
							sendPlayerMessage(i, "Report From: " + getPlayerName(playerid) + "["+playerid+"] : " +   str, COLOR_TEAL);
							pData[playerid].report == 1;
						}
					}
				}
			}
			else
			{
				sendPlayerMessage(playerid, "SYNTAX: /report [reason]", COLOR_GRAY);
			}
		}
		if(cmd[0] == "/me" )
		{
			if( command.len() > cmd[0].len()+1 )
			{
				local action = command.slice(cmd[0].len()+1, command.len());
				ProxDetector(20.0, playerid, getPlayerName(playerid) + " " + action, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				log( "[ME]: "+getPlayerName(playerid)+" "+action);
			}
			else
			{
				sendPlayerMessage(playerid, "SYNTAX: /me [action]", COLOR_GRAY);
			}
		}
		if(cmd[0] == "/do" )
		{
			if( command.len() > cmd[0].len()+1 )
			{
				local action = command.slice(cmd[0].len()+1, command.len());
				ProxDetector(20.0, playerid, action + " (( "+ getPlayerName(playerid) +" ))", COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				log( "[DO]: "+action+" (( "+getPlayerName(playerid)+" ))");
			}
			else
			{
				sendPlayerMessage(playerid, "SYNTAX: /me [action]", COLOR_GRAY);
			}
		}
		if(cmd[0] == "/seatbelt" )
		{
			if(isPlayerInAnyVehicle(playerid))
			{
				if(pData[playerid].seatbelt == 0)
				{			
					pData[playerid].seatbelt = 1;
					ProxDetector(20.0, playerid, getPlayerName(playerid) + " reaches to the side, grabs his seatbelt and clicks it into place.", COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
					togglePlayerPhysics(playerid, false);
				}
				else
				{
					pData[playerid].seatbelt = 0;
					togglePlayerPhysics(playerid, true);
					ProxDetector(20.0, playerid, getPlayerName(playerid) + " un-clips his seatbelt and slides it off.", COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				}
			}
		}
		if(cmd[0] == "/vehicles" )
		{
			foreach(vehicle in vData)
			{
				if(vData[i].owner == getPlayerName(playerid))
				{			
					sendPlayerMessage(playerid, vData[i].id + ": " + getVehicleName(vData[i].model + ": " + getVehicleName(i)), COLOR_RED);
				}
			}
		}
		if(cmd[0] == "/lock" )
		{
			local veh = cmd[1].tointeger();
			if( isInteger(veh))
			{
				if(vData[veh].owner == getPlayerName(playerid))
				{
					if(vData[veh].lock = "0")
					{
						ProxDetector(20.0, playerid, getPlayerName(playerid) + " takes out his keys, locking their vehicle.", COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
						vData[veh].lock = "1";
						setVehicleLocked(veh, 2)
					}
					else
					{
						vData[veh].lock = "0"
						ProxDetector(20.0, playerid, getPlayerName(playerid) + " takes out his keys, un-locking the vehicle", COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
						setVehicleLocked(veh, 0)
					}				
				}
				else
				{
					sendPlayerMessage(playerid, "You do not own this vehicle! Use /vehicles", COLOR_GRAY);
				}
			}
			else
			{
				sendPlayerMessage(playerid, "[SYNTAX]: /lock [Vehicle ID]. HINT: Use /vehicles to see your owned vehciles!", COLOR_GRAY);
			}
			
		}
		if(cmd[0] == "/gas" )
		{
			if(pData[playerid].driver == 1)
			{
				if(PlayerToPoint(playerid, 1, 110.818901, 1129.920410, 14.091767))
				{
					
					local veh = getPlayerVehicleId(playerid);
					local model = getVehicleModel(veh);
					ProxDetector(20.0, playerid, "The Gas Clerk Begins To Fill Up" +  getPlayerName(playerid) + "'s Tank", COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
					vData[veh].fuel = vStats[model].maxfuel;
				}
				if(PlayerToPoint(playerid, 1,  111.005974, 1141.684082, 14.092154))
				{
					local veh = getPlayerVehicleId(playerid);
					local model = getVehicleModel(veh);
					ProxDetector(20.0, playerid, "The Gas Clerk Begins To Fill Up" +  getPlayerName(playerid) + "'s Tank", COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
					vData[veh].fuel = vStats[model].maxfuel;
				}
				if(PlayerToPoint(playerid, 1,  106.221535, 1130.037598, 14.091471))
				{
					local veh = getPlayerVehicleId(playerid);
					local model = getVehicleModel(veh);
					ProxDetector(20.0, playerid, "The Gas Clerk Begins To Fill Up" +  getPlayerName(playerid) + "'s Tank", COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
					vData[veh].fuel = vStats[model].maxfuel;
				}
				if(PlayerToPoint(playerid, 1,  106.415436, 1140.895020, 14.091691))
				{
					local veh = getPlayerVehicleId(playerid);
					local model = getVehicleModel(veh);
					ProxDetector(20.0, playerid, "The Gas Clerk Begins To Fill Up" +  getPlayerName(playerid) + "'s Tank", COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
					vData[veh].fuel = vStats[model].maxfuel;
				}
				if(PlayerToPoint(playerid, 1,  101.944397, 1141.703857, 14.091944))
				{
					local veh = getPlayerVehicleId(playerid);
					local model = getVehicleModel(veh);
					ProxDetector(20.0, playerid, "The Gas Clerk Begins To Fill Up" +  getPlayerName(playerid) + "'s Tank", COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
					vData[veh].fuel = vStats[model].maxfuel;
				}
				if(PlayerToPoint(playerid, 1,  101.858795, 1130.891968, 14.093105))
				{
					local veh = getPlayerVehicleId(playerid);
					local model = getVehicleModel(veh);
					ProxDetector(20.0, playerid, "The Gas Clerk Begins To Fill Up" +  getPlayerName(playerid) + "'s Tank", COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
					vData[veh].fuel = vStats[model].maxfuel;
				}
				else
				{
					sendPlayerMessage(playerid, " You Must be at one of the fuel station points to fill up your vehicle", COLOR_GRAY);
				}
			}
			else
			{
				sendPlayerMessage(playerid, " You Must Be A Driver Of A Vehicle To Fill It Up!", COLOR_GRAY);
			}
			
		}
		
		if(cmd[0] == "/b")
		{
			if( command.len() > cmd[0].len()+1 )
			{
				str = command.slice(cmd[0].len()+1, command.len());
				if(pData[playerid].aduty)
				{
					ProxDetector(20.0, playerid, "[ADMIN "+ " " + getPlayerName(playerid)+"]: (( "+str+" ))", COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW, COLOR_YELLOW);
				}
				else
				{
					ProxDetector(20.0, playerid, "((" + getPlayerName(playerid) +":"+str+" ))", 0xE6E6E6E6,0xC8C8C8C8,0xAAAAAAAA,0x8C8C8C8C,0x6E6E6E6E);
				}
				log("[CHAT]: "+getPlayerName(playerid)+": (( "+str+" ))");
			}
			else
			{
				sendPlayerMessage(playerid, "[SYNTAX]: /(b)racket [message]", COLOR_GRAY);
			}
		}
		if(cmd[0] == "/pm" || cmd[0] == "/pme")
		{
			if(command.len() > cmd[0].len()+1)
			{
				if(returnUser(cmd[1]) != -1)
				{
	
					if( pData[targetid].pm == 1 )
					{
						str = command.slice(cmd[0].len()+cmd[1].len()+2, command.len());
						local target = returnUser(cmd[1]);
						sendPlayerMessage(target, "((PM from "+ " " + getPlayerName(playerid)+": "+str + "))", COLOR_ORANGE);
						sendPlayerMessage(playerid, "((PM sent to "+ " " + getPlayerName(target)+": "+str + "))", COLOR_ORANGE);
					}
					else
					{
						sendPlayerMessage(playerid, "[vG]: That player is not accepting messages at this time.", COLOR_YELLOW);
					}
				}
				else
				{
					sendPlayerMessage(playerid, "[vG]: Invalid player.", COLOR_YELLOW);
				}
			}
			else
			{
				sendPlayerMessage(playerid, "SYNTAX: /pm(e) [player] [message]",  COLOR_GRAY);
			}
		}
		if(cmd[0] == "/enter")
		{
			for (local f = 0; f < MAX_FACTIONS; f++)
			{
				if(fData[f].Locked == "0")
				{
					if(PlayerToPoint(playerid, 10, fData[f].PickupX, fData[f].PickupY, fData[f].PickupZ))
					{
						setPlayerCoordinates(playerid, fData[f].IntX, fData[f].IntY, fData[f].IntZ);
					}
				}
			}
			for (local h = 0; h < MAX_HOUSES; h++)
			{
				if(hData[h].Locked == "0")
				{
					if(PlayerToPoint(playerid, 10, hData[h].outsideX, hData[h].outsideY, hData[h].outsideZ))
					{
						setPlayerCoordinates(playerid, hData[h].insideX, hData[h].insideY, hData[h].insideZ);
					}
				}
			}
		}
		
		if(cmd[0] == "/exit")
		{
			for (local f = 0; f < MAX_FACTIONS; f++)
			{
				if(fData[f].locked == "0")
				{
					if(PlayerToPoint(playerid, 10, fData[f].IntX, fData[f].IntY, fData[f].IntZ))
					{
						setPlayerCoordinates(playerid, fData[f].PickupX, fData[f].PickupY, fData[f].PickupZ);
					}
				}
			}
			for (local h = 0; h < MAX_HOUSES; h++)
			{
				if(hData[h].Locked == "0")
				{
					if(PlayerToPoint(playerid, 10, hData[h].insideX, hData[h].insideY, hData[h].insideZ))
					{
						setPlayerCoordinates(playerid, hData[h].outsideX, hData[h].outsideY, hData[h].outsideZ);
					}
				}
			}
		}	
		if(cmd[0] == "/start")
		{
			if(isPlayerInAnyVehicle(playerid))
			{
				local veh = getPlayerVehicleId(playerid);
				if(vData[veh].engine == 0)
				{
					vData[veh].engine = 1;
					togglePlayerControls(playerid, true);
					local names = returnSplit(playerid);
					str = "* "+ " " + getPlayerName(playerid)+" attempts to start the vehicle and succeeds.";
					ProxDetector(20.0, playerid, str, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
					local started = timer(VehEngine, 1000, -1, vData[veh], playerid);
					local Fuel = timer(VehFuel, 600000, -1, vData[veh]);
				}
				else
				{
					sendPlayerMessage(playerid, "[vG]: The vehicle is already on.", COLOR_YELLOW);
				}
			}
			else
			{
				sendPlayerMessage(playerid, "[vG]: You aren't in a vehicle.", COLOR_YELLOW);
			}
		}
		if(cmd[0] == "/stop")
		{
			if(isPlayerInAnyVehicle(playerid))
			{
				local veh = getPlayerVehicleId(playerid);
				if(vData[veh].engine = 1)
				{
					vData[veh].engine = 0;
					togglePlayerControls(playerid, false);
					local names = returnSplit(playerid);
					str = "* "+ " " + getPlayerName(playerid)+" stops the vehicle.";
					ProxDetector(20.0, playerid, str, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
					if(isTimerActive(fuel))
					{
						killTimer(fuel);
					}
					if(isTimerActive(started))
					{
						killTimer(started);
					}
					if(isTimerActive(engine))
					{
						killTimer(engine);
					}
				}
				else
				{
					sendPlayerMessage(playerid, "[vG]: The vehicle is already off.", COLOR_YELLOW);
				}
			}
			else
			{
				sendPlayerMessage(playerid, "[vG]: You aren't in a vehicle.", COLOR_YELLOW);
			}
		}
		if(cmd[0] == "/buyvehicle")
		{
			if(isPlayerInAnyVehicle(playerid))
			{
				local veh = getPlayerVehicleId(playerid);
				if(vData[veh].forsale == 1)
				{
					if(pData[playerid].cash >= vData[veh].price)
					{
						local pos = getPlayerCoordinates(playerid);
						local rot = getPlayerHeading(playerid);
						local color = getVehicleColor(veh);
						local model = getVehicleModel(veh);
						local plate = "Default";
						local price = vData[veh].price;
						pData[playerid].cash = pData[playerid].cash - vData[veh].price;
						vData[veh].owner = getPlayerName(playerid);
						vData[veh].forsale = 0;
						sendPlayerMessage(playerid, "[vG]: You Bought This Vehicle!.", COLOR_YELLOW);
						setPlayerCoordinates(playerid, -471.288818, 448.681793, 9.545568);
						local query = sql.query_insertid("INSERT INTO vehicles (VehModel, VehX, VehY, VehZ, VehA, VehColor1, VehColor2, VehColor3, VehColor4, Plate) VALUES ('"+model+"', '"+pos[0]+"', '"+pos[1]+"', '"+pos[2]+"', '"+ rot +"', '"+color[0]+"', '"+color[1]+"', '"+color[2]+"', '"+color[3]+"', '"+plate+"')")
						local newveh = createVehicle(model, pos[0]+1, pos[1], pos[2], rot, color[0], color[1], color[2], color[3]);
						log("[Spawned]: Vehicle ID: "+ newveh);
						vData[newveh] <- { };
						vData[newveh].id <- veh;
						vData[newveh].model <- model;
						vData[newveh].spawnx <- pos[0];
						vData[newveh].spawny <- pos[1];
						vData[newveh].spawnz <- pos[2];
						vData[newveh].spawnrot <- rot;
						vData[newveh].owner <- "None"
						vData[newveh].faction <- "0";
						vData[newveh].color1 <- color[0];
						vData[newveh].color2 <- color[1];
						vData[newveh].color3 <- color[2];
						vData[newveh].color4 <- color[3];
						vData[newveh].engine <- 0;
						vData[newveh].lock <- "0";
						vData[newveh].engine <- "0";
						vData[newveh].forsale = 1;
						vData[newveh].price = price;
						togglePlayerControls(playerid, true);
					}
					else
					{
						sendPlayerMessage(playerid, "[vG]: You Don't Have Enough Money!", COLOR_YELLOW);
					}
				}
				else
				{
					sendPlayerMessage(playerid, "[vG]: This Vehicle Is Not For Sale!", COLOR_YELLOW);
				}
			}
			else
			{
				sendPlayerMessage(playerid, "[vG]: You Must Be In A Vehicle To Use This Command!", COLOR_YELLOW);
			}
		}
		if(cmd[0] == "/stats")
		{
			local ftext, rtext, jtext;
			if(pData[playerid].job == "0") { jtext = "None"; }
			if(pData[playerid].job == "1") { jtext = "Weapon Smuggler"; }
			if(pData[playerid].job == "2") { jtext = "Drug Smuggler"; }
			if(pData[playerid].faction == "0") { ftext = "None"; rtext = "None"; }
			if(pData[playerid].faction == "1")
			{
				ftext = "LCPD";
				if(pData[playerid].rank == "1") { rtext = "Cadet"; }
				if(pData[playerid].rank == "2") { rtext = "Officer"; }
				if(pData[playerid].rank == "3") { rtext = "Corporal"; }
				if(pData[playerid].rank == "4") { rtext = "Sergeant"; }
				if(pData[playerid].rank == "5") { rtext = "Lieutenant"; }
				if(pData[playerid].rank == "6") { rtext = "Assistant Chief"; }
				if(pData[playerid].rank == "7") { rtext = "Chief"; }
			}
			if(pData[playerid].faction == "2")
			{
				ftext = "FBI";
				if(pData[playerid].rank == "1") { rtext = "Agent"; }
				if(pData[playerid].rank == "2") { rtext = "Special Agent"; }
				if(pData[playerid].rank == "3") { rtext = "SAIC"; }
				if(pData[playerid].rank == "4") { rtext = "Vice Director"; }
				if(pData[playerid].rank == "5") { rtext = "Director"; }
			}
			if(pData[playerid].faction == "3")
			{
				ftext = "Agency";
				if(pData[playerid].rank == "1") { rtext = "Agent"; }
				if(pData[playerid].rank == "2") { rtext = "Special Agent"; }
				if(pData[playerid].rank == "3") { rtext = "Vice Director"; }
				if(pData[playerid].rank == "4") { rtext = "Head Director"; }
			}
			else
			{
				ftext = "None";
				rtext = "None";
			}
			sendPlayerMessage(playerid, "____________________"+names[0]+" "+names[1]+"____________________", COLOR_WHITE);
			sendPlayerMessage(playerid, "[GENERAL] Level["+pData[playerid].level+"] Age["+pData[playerid].age+"] Tutorial["+pData[playerid].tutorial+"] Model["+pData[playerid].model+"] Respect["+pData[playerid].respect+"]", COLOR_YELLOW);
			sendPlayerMessage(playerid, "[MONEY] Cash["+pData[playerid].cash+"] Bank["+pData[playerid].bank+"]", COLOR_YELLOW);
			sendPlayerMessage(playerid, "[JOB] Job ["+jtext+"] Packages["+pData[playerid].packages+"]", COLOR_YELLOW);
			sendPlayerMessage(playerid, "[FACTION] Faction["+ftext+"] Rank["+rtext+"]", COLOR_YELLOW);
		}	
	}
	return 0;
}
addEvent("playerCommand", onPlayerCommand);
