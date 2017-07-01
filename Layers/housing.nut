/********************************************************************************
*                 Copyright © 2011 - Valhalla Gaming                            *
*                          Houseing Script                                      *
*                                                                               *
*                      Original Authors: 	Broski - James                      *
*                             Created: 	19/03/11                                *
*                       Title:		Valhalla Gaming : IV                        *
*                              Version:	0.0.5e	                                *
*                                                                               *
*____________________________________Change Log____ ____________________________*
*                   James - Created                                             *
********************************************************************************/

function onScriptInit()
{
	log("***************************************************");
	log("*     Valhalla Script | Housing Loaded            *");
	log("***************************************************");
}

addEvent("scriptInit", onScriptInit);



function onScriptExit( )
{
	log("***************************************************");
	log("*     Valhalla Script | Housing Loaded            *");
	log("***************************************************");
}
addEvent("scriptExit", onScriptExit);


local hData = { }; // House Data  Table
local HouseCount = 0;


local house = {
	function create(name, street, area, creator)
    {
		local pos = getPlayerCoordinates(creator);
		getClientStreetAreaName(playerid);	
		if(sql.query("INSERT INTO houses (Name, Street, Area, OutSideX, OutsideY, OutSideZ) VALUES ('"+name+"', '"+streetName+"', '"+areaName+"', '"+pos[0]+"', '"+ pos[1] +"', '"+pos[2]+"')"))
		{
			log("|House Created By:" + getPlayerName(creator));
			return 1;
		}
		else
		{
			log("|ERROR :House Attempted To Be Created By:" + getPlayerName(creator));
			return -1;
		}
    }

	function del(name, pt)
	{
		if(sql.query("DELETE FROM houses WHERE Name='"+name+"'"))
		{
			log("[House]: Name "+name+" deleted.");
			return 1;
		}
		else
		{
			return 0;
		}
	}
    function save(pt)
    {
		local update = sql.query_affected_rows("UPDATE houses SET Name='" + pt.name + "', Street='" + pt.street + "', Area='" + pt.area + "', Owner='" + pt.owner + "', OutsideX='" + pt.outsideX + "', OutsideY='" + pt.outsideY + "', OutsideZ='" + pt.outsideZ + "', InsideX='" + pt.insideX + "', InsideY='"+ pt.insideY+"' , InsideZ='"+ pt.insideZ +"', Price='"+ pt.price+"' , ForSale='"+pt.forsale+"', Locked='"+pt.locked+"' WHERE id='" + pt.id + "'")
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
	function load(hData)
    {
		local houses = sql.query_assoc("SELECT * FROM houses")
		if( houses )
		{
			foreach( house in houses )
			{
				
				local id = house.id;
				hData[id] <- { };
				hData[id].id <- id;
				hData[id].name <- house.Name;
				hData[id].street <- house.Street;
				hData[id].area <- house.Area;
				hData[id].owner <- house.Owner;
				hData[id].outsideX <- house.OutSideX;
				hData[id].outsideY <- house.OutSideY;
				hData[id].outsieZ <- house.OutSideZ;
				hData[id].insideX <- house.InsideX;
				hData[id].insideY <- house.InsideY;
				hData[id].insideZ <- house.InsideZ;
				hData[id].price <- house.Price;
				hData[id].forsale <- house.ForSale;
				hData[id].locked <- house.Locked;
				log("[House Loaded]: " +  hData[id].id);
				HouseCount++;
				
			}
		}	
    }
}