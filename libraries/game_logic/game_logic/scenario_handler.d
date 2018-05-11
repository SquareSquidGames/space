module game_logic.scenario_handler;

import linked.destructive_node ;
import linked.no_sent_node_funs ;
import objects.world;
import objects.ship;
import objects.bullet;
import math.tau;
import math.polar_rect;

class ScenarioHandler {
	World world;

	this(World world) {
		this.world = world;
		world.ships = new Node!Ship(world.ships	, new Ship([0,-3],0)	);
		world.ships = new Node!Ship(world.ships	, new Ship([2,2],0.5*TAU)	);
		world.ships = new Node!Ship(world.ships	, new Ship([-2,1],0.1*TAU)	);
	}

	void update(float timeDelta) {
		
	}
}

