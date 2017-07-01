/*
* banking.nut
* 	Bank Layer
* 		 Valhalla Gaming 2011
*/
local atms = 
[
{x = 937.4, y = -554.7, z = 14.1},

];

bankType <-
{
	atm     = 0,
	clerk   = 1,
	lockbox = 2,
	vault 	= 3,
	Hsafe	= 4,
	Fsafe   = 5,
}

class CBank
{
	bankType = bankType.atm;
	
	function getBankType( )
	{
		return bankType;
	}

}
function onPlayerCommand(playerid, command)
{
	local cmd = split( command, " " );
	if (cmd[0] == "/balance")
	{
		if (PlayerToPoint(playerid,5.0, atms, atms, atms))
		{
		sendPlayerMessage(playerid,"Works");
		
		}
		
	}
	
}
addEvent("playerCommand", onPlayerCommand);