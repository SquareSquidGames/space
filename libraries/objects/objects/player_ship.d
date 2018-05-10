/**	The data for the player.
*/
module objects.player_ship;

class PlayerShip{
	float[2]	pos	= [0,0];
	float	rot	= 0;
	float[2]	velocity	= [0,0];
	float	torque	= 0;

	float	gunDirection	= 0;
}
