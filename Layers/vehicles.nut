/********************************************************************************
*                 Copyright © 2011 - Valhalla Gaming                            *
*                            Vehicle Script                                     *
*                      Original Authors: 	Broski - James                      *
*                             Created: 	19/03/11                                *
*                       Title:		Valhalla Gaming : IV                        *
*                              Version:	0.0.5e	                                *
*                                                                               *
*____________________________________Change Log_________________________________*
*                   James - Created                                             *
********************************************************************************/

local vData = { }; // Vehicle Data Table
local vStats = { }; // Vehicle Statistics - Fuel - Default Price ETC

function onScriptInit()
{
	local Date = date();
	log("***************************************************");
	log("* Running Valhalla Gaming | Vehicle Script        *");
	log("***************************************************");
}

addEvent("scriptInit", onScriptInit);

function onScriptExit( )
{
	log("***************************************************");
	log("*    Valhalla  Script | Vehicles Un-Loaded        *");
	log("***************************************************");
	for (local v = 0; v < MAX_VEHICLES; v++)
	{
		local pos = getVehicleCoordinates(v);
		local color = getVehicleColor(v);
		local health = getVehicleHealth(v);
		local engine =  getVehicleEngineHealth(v);
		local lock = getVehicleLocked(v);
		
		vData[v].spawnx <- pos[0];
		vData[v].spawny <- pos[1];
		vData[v].spawnz <- pos[2];
		vData[v].color1 <- color[0];
		vData[v].color2 <- color[1];
		vData[v].color3 <- color[2];
		vData[v].color4 <- color[3];
		vData[v].damage <- health
		vData[v].enginedamage <- engine;
		vData[v].lock <- lock;
		vehicle.save(v, vData[v]);
		log("*           All Vehicles Saved             *");
	}
}
addEvent("scriptExit", onScriptExit);

local vehicle = {
	function create(model, creator, owner, faction, rank, color1, color2, color3, color4, lock , engine)
    {
		local pos = getPlayerCoordinates(creator);
		local rot = getPlayerHeading(creator);
		local plate = "LCITY112"
		local economy = vStats[model].economy;
		if(sql.query("INSERT INTO vehicles (VehModel, VehX, VehY, VehZ, VehA, VehColor1, VehColor2, VehColor3, VehColor4, Plate, Economy) VALUES ('"+model+"', '"+pos[0]+"', '"+pos[1]+"', '"+pos[2]+"', '"+ rot +"', '"+color1+"', '"+color2+"', '"+color3+"', '"+color4+"', '"+plate+"', '"+economy+"' )"))
		{
			log("|Created By:" + getPlayerName(creator));
			return 1;
		}
		else
		{
			log("|ERROR :Attempted To Be Created By:" + getPlayerName(creator));
			return -1;
		}
    }

	function del(vehicle, pt)
	{
		if(sql.query("DELETE FROM vehicles WHERE VehID='"+vehicle+"'"))
		{
			log("[VEHICLE]: ID "+vehicle+" deleted.");
			deleteVehicle(vehicle);
			return 1;
		}
		else
		{
			return 0;
		}
	}
    function save(vehicle, pt)
    {
		local update = sql.query_affected_rows("UPDATE vehicles SET VehModel='" + pt.model + "', VehX='" + pt.spawnx + "', VehY='" + pt.spawny + "', VehZ='" + pt.spawnz + "', VehA='" + pt.spawnrot + "', VehColor1='" + pt.color1 + "', VehColor2='" + pt.color2 + "', VehColor3='" + pt.color3 + "', VehColor4='"+ pt.color4+"' , Damage='"+ pt.damage+"', Fuel='"+ pt.fuel+"' , Engine='"+pt.engine+"', Lights='"+pt.lights+"' , Dirt='"+pt.dirt+"' Faction='"+pt.faction+"', Owner='"+pt.owner+"', Admin='"+pt.admin+"' , Lock='"+pt.lock+"', Type='"+pt.forsale+"', Price='"+pt.price+"' , Economy='"+pt.economy +"' WHERE VehID='" + vehicle + "'")
		if(update)
		{	
			log("Vehicle:" + vehicle + "|Updated!");
			return 1;
		}
		else
		{
			log("Vehicle:" + vehicle + "|ERROR UPDATING!");
			return 0;
		}
    }
	function load(vData)
    {
		local cars = sql.query_assoc("SELECT * FROM vehicles")
		if( cars )
		{
			foreach( car in cars )
			{
				
				local veh = car.VehID;
				vData[veh] <- { };
				vData[veh].id <- veh;
				vData[veh].model <- car.VehModel;
				vData[veh].spawnx <- car.VehX;
				vData[veh].spawny <- car.VehY;
				vData[veh].spawnz <- car.VehZ;
				vData[veh].spawnrot <- car.VehA;
				vData[veh].color1 <- car.VehColor1;
				vData[veh].color2 <- car.VehColor2;
				vData[veh].color3 <- car.VehColor3;
				vData[veh].color4 <- car.VehColor4;
				vData[veh].damage <- car.Damage;
				vData[veh].enginedamage <- car.EngineDamage;
				vData[veh].plate <- car.Plate;
				vData[veh].fuel <- car.Fuel;
				vData[veh].engine <- car.Engine;
				vData[veh].lights <- car.Lights;
				vData[veh].dirt <- car.Dirt;
				vData[veh].faction <- car.Faction;
				vData[veh].owner <- car.Owner;
				vData[veh].admin <- car.Admin;
				vData[veh].lock <- car.Lock;
				vData[veh].forsale <- car.Value;
				vData[veh].price <- car.Price;
				vData[veh].economy <- vStats[car.VehModel].economy;
				createVehicle (vData[veh].model, vData[veh].spawnx, vData[veh].spawny, vData[veh].spawnz, vData[veh].spawnrot, vData[veh].color1 , vData[veh].color2 , vData[veh].color3 , vData[veh].color4 )
				if(vData[veh].lock == "1")
				{
					setVehicleLocked(veh, 2)
				}
				setVehicleHealth(veh, vData[veh].damage);
				setVehicleEngineHealth(veh, vData[veh].enginedamage);
				setVehicleDirtLevel(veh, vData[veh].dirt);
				log("[Vehicle Loaded]: " +  vData[veh].id);
				
			}
		}	
    }
	function isACopCar(veh, pt)
	{
		if(pt.faction == 1 || pt.faction == 2)
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
}


function onPlayerEnterVehicle(playerid, veh, passenger, seatid)
{
	if( seatid == 0 )
	{
		if(getVehicleModel(veh) == 55)
		{
			if(pData[playerid].job == 1)
			{
				sendPlayerMessage(playerid, "Welcome to Your Shift!", COLOR_YELLOW);
				sendPlayerMessage(playerid, "Your Tanker Has Been Filled For You! Take It To A Fuel Station and use /dropfuel", COLOR_GREEN);
				Oil[playerid] = 100;
			}
			else
			{
				removePlayerFromVehicle(playerid, true);
				sendPlayerMessage(playerid, "Do you have the Oil Worker Job? Diden't think so. Go get it to drive this!.", COLOR_YELLOW);
			}
		}
		if(getVehicleModel(veh) == 27 || getVehicleModel(veh) == 52 || getVehicleModel(veh) == 65 || getVehicleModel(veh) == 63 || getVehicleModel(veh) == 64 || getVehicleModel(veh) == 70 || getVehicleModel(veh) == 119 || getVehicleModel(veh) == 53 && pData[playerid].faction != 1)
		{
			removePlayerFromVehicle(playerid, true);
			sendPlayerMessage(playerid, "This is a faction vehicle. You cannot enter it.", COLOR_YELLOW);
		
		}
		if(vData[veh].lock == "1" && vData[veh].alarm == "1")
		{
			vData[veh].lock = 0;
			setVehicleLocked(veh, 0);
			local alarm = timer(VehAlarm, 3000, 5, veh);
		}
		if(vData[veh].lock == "1")
		{			
			vData[veh].lock = 0;
			setVehicleLocked(veh, 0);
		}
		if(vData[veh].forsale = "1")
		{
			togglePlayerControls(playerid, false);
			sendPlayerMessage(playerid, "[vG]: This Vehicle Is For Sale, Price: " + " $"  + vData[veh].price + ". To Buy This Vehicle Type /buyvehicle.", COLOR_YELLOW);
		}
		if(vData[veh].engine == "0")
		{
			pData[playerid].driver <- 1;
			sendPlayerMessage(playerid, "The vehicle's engine is off.", COLOR_PURPLE);
			sendPlayerMessage(playerid, "HINT: Type /start to turn the vehicle's engine on.", COLOR_GRAY);
			pData[playerid].driver <- 1;
			togglePlayerControls(playerid, false);

		}
		if(vData[veh].engine == "1")
		{
			pData[playerid].driver <- 1;
			sendPlayerMessage(playerid, "The vehicle's engine is running!!.", COLOR_PURPLE);
			pData[playerid].driver <- 1;
			local engine = timer(VehEngine, 1000, -1, vData[veh], playerid);
		}
	}
	else
	{
		pData[playerid].driver <- 0;
	}
}
addEvent("playerentervehicle", onPlayerEnterVehicle);

function VehAlarm(veh)
{
	soundVehicleHorn (veh, 2000);
}

function VehEngine(vData, playerid)
{
	if(isPlayerInAnyVehicle(playerid))
	{
		local veh = getPlayerVehicleId(playerid);
		local model = getVehicleModel(vehicleid);
		local speed = getSpeed(vehicleid).tointeger();
		local fuelpercent = vData[veh].fuel / vStats[model].maxfuel * 100
		if(fuelpercent == 100)
		{
			displayPlayerInfoText(playerid, "~g~Speed:" + speed +   "~r~Fuel: ~g~==========", 1000);
		}
		if(fuelpercent < 100 || fuelpercent >= 90)
		{
			displayPlayerInfoText(playerid, "~g~Speed:" + speed +   "~r~Fuel: ~g~=========~w~=", 1000);
		}
		if(fuelpercent < 90 || fuelpercent >= 80)
		{
			displayPlayerInfoText(playerid, "~g~Speed:" + speed +   "~r~Fuel: ~g~========~w~==", 1000);
		}
		if(fuelpercent < 80 || fuelpercent >= 70)
		{
			displayPlayerInfoText(playerid, "~g~Speed:" + speed +   "~r~Fuel: ~g~=======~w~===", 1000);
		}
		if(fuelpercent < 70 || fuelpercent >= 60)
		{
			displayPlayerInfoText(playerid, "~g~Speed:" + speed +   "~r~Fuel: ~g~======~w~====", 1000);
		}
		if(fuelpercent < 60 || fuelpercent >= 50)
		{
			displayPlayerInfoText(playerid, "~g~Speed:" + speed +   "~r~Fuel: ~g~=====~w~=====", 1000);
		}
		if(fuelpercent < 50 || fuelpercent >= 40)
		{
			displayPlayerInfoText(playerid, "~g~Speed:" + speed +   "~r~Fuel: ~g~====~w~======", 1000);
		}
		if(fuelpercent < 40 || fuelpercent >= 30)
		{
			displayPlayerInfoText(playerid, "~g~Speed:" + speed +   "~r~Fuel: ~g~===~w~=======", 1000);
		}
		if(fuelpercent < 30 || fuelpercent >= 20)
		{
			displayPlayerInfoText(playerid, "~g~Speed:" + speed +   "~r~Fuel: ~g~==~w~========", 1000);
		}
		if(fuelpercent < 20 || fuelpercent >= 10)
		{
			displayPlayerInfoText(playerid, "~g~Speed:" + speed +   "~r~Fuel: ~g~=~w~=========", 1000);
		}
		if(fuelpercent == 0)
		{
			displayPlayerInfoText(playerid, "~g~Speed:" + speed +   "~r~Fuel: ~w~==========", 1000);
		}
	}
}
function VehFuel(vData, veh)
{
	if(vData[veh].engine == 1)
	{
		vData[veh].fuel = vData[veh].fuel - vData[veh].economy;
	}
}

