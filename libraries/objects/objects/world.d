/**	This contains all the shared world data.  Has the player ship and AI ships astoids, and also data about ammo and health etc.
*/
module objects.world;

import linked.destructive_node	;
import linked.no_sent_node_funs	;
import objects.player_ship	;
import objects.ship	;
import objects.bullet	;

class World {
	PlayerShip playerShip;
	
	Node!Ship* ships;

	Node!Bullet* bullets;
	
	this() {
		playerShip	= new PlayerShip;
	}
}