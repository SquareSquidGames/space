module game_logic.ship_ai_handler;

import linked.destructive_node ;
import linked.no_sent_node_funs ;
import objects.world;
import objects.ship;
import objects.bullet;
import math.tau;
import math.polar_rect;

class ShipAiHandler {
	World world;

	this(World world) {
		this.world = world;
	}

	void handleShip(Ship ship) {
		ship.velocity[] += getRect(0.1f, direction(ship.pos, world.playerShip.pos))[];
	}
}



float direction(float[2] point1, float[2]  point2) {
	float[2] d = point2[]-point1[];
	float direction = d.getT;
	return direction;
}