const VG_SCRIPT_VERSION = "0.0.5e"
const INVALID_PLAYER_ID = -1;

const MAX_PLAYERS = 50;
const MAX_VEHICLES = 100;
const MAX_FACTIONS  = 10;
const MAX_HOUSES = 100;

const COLOR_WHITE = 0xFFFFFFFF;
const COLOR_YELLOW = 0xA6A600FF;
const COLOR_RED = 0xA60000FF;
const COLOR_GREEN = 0x00A600FF;
const COLOR_BLUE = 0x0000A6FF;
const COLOR_GRAY = 0xA6A6A6FF
const COLOR_ORANGE = 0xC86C00FF;
const COLOR_PURPLE = 0xC2A2DAAA;
const COLOR_TEAL = 0x00FFCCFF;
const COLOR_ADMIN = 0x6E0000AA;


local streetName;
local areaName

local gOOC = 0; // OOC Toggler



local server = {
	function vehiclestats(vStats)
	{
		local vehicles = sql.query_assoc("SELECT * FROM vehiclevalues")
		if( vehicles )
		{
			foreach( vehicle in vehicles )
			{
				
				local model = vehicle.Model;
				vStats[model] <- { };
				vStats[model].name <- vehicle.Name;
				vStats[model].model <- vehicle.Model;
				vStats[model].maxfuel <- vehicle.MaxFuel;
				vStats[model].economy <- vehicle.Economy;
				vStats[model].insurance <- vehicle.Insurance;
				vStats[model].tax <- vehicle.Tax;
				log(vehicle.Name + " " + vehicle.Model + " " +  vehicle.MaxFuel + " " + vehicle.Economy + " " + vehicle.Insurance + " " + vehicle.Tax);
			}
		}	
	}
	function adminlog(admin, player, command)
	{
		local date = date();
		if(sql.query("INSERT INTO adminlog (Admin, Player, Command, Date) VALUES ('"+admin+"', '"+player+"', '"+command+"', '"+date+"')"))
		{
			log("[Admin Command][" + command + "]: " + admin + " on player: " + player);
		}
	}
}

function onScriptInit()
{
	local Date = date();
	log("***************************************************");
	log("*   Running Valhalla Gaming IV:MP Script 0.0.5d   *");
	log("*           By Broski/James - 05/11/2010          *");
	log("*               Last Update - 06/03/2011          *");
	log("*              Version:"+ VG_SCRIPT_VERSION+"                     *");
	log("*                   Starting......                *");
	log("*"+ "                 " + Date["day"]+"/"+(Date["month"]+1)+"/"+Date["year"] + " : " +Date["hour"]+":"+Date["min"]+":"+ Date["sec"]+"             *");
	log("***************************************************");
	createBlip(79,-471.288818, 448.681793, 9.545568) // Shitty Auto's  Blip
	createBlip(79, 56.701229, 803.740540, 14.396356) // Grotti  Blip
	createBlip(91, 106.913635, 1121.048584, 14.670035) // Gas Blip
	createBlip(1,  77.307098, -705.815552, 5.001526) // City Hall Blip

	createActor(135, 113.080788, 1142.701050, 14.803074, 12.394151); // Gas Clerk 1
	createActor(135, 104.119293, 1142.793579, 14.881272, 2.929250); //Gas Clerk 2
	createActor(135, 104.044884, 1132.109009, 14.897332, 359.860535); //Gas Clerk 3
	createActor(135, 112.960892, 1132.179565, 14.819383, 26.181726); //Gas Clerk 4
	createActor(107, 77.307098, -705.815552, 5.001526, 189.098145); //City Hall Clerk 1

}

addEvent("scriptInit", onScriptInit);