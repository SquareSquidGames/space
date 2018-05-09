/**	This contains all the shared world data.  Has the player ship and AI ships astoids, and also data about ammo and health etc.
*/
module objects.world;

import llist.slist	;
import objects.player_ship	;
import objects.ship	;

class World {
	PlayerShip playerShip;
	
	Node!Ship* ships;
	
	this() {
		playerShip = new PlayerShip;
		ships = new Node!Ship;
	}
}