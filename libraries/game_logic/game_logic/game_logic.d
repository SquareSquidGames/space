module game_logic.game_logic;

import llist.slist;
import objects.world;
import objects.ship;
import game_events.game_event;
import math.tau;
import math.polar_rect;

class GameLogic {
	World world;
	this(World world) {
		this.world = world;
		world.ships.append(new Ship([0,-3],0));
		world.ships.insertAfter(new Ship([2,2],0.5*TAU));
		world.ships.insertAfter(new Ship([-2,1],0.1*TAU));
	}
	
	void update(GameEvent[] gameEvents, float timeDelta) {
		foreach (event; gameEvents) {
			if (event.type == EventType.thrust) {
				world.playerShip.velocity[]+=getRect(event.thrust.thrust/20,world.playerShip.rot)[];
			}
			else if (event.type == EventType.torque) {
				world.playerShip.torque+=event.torque.torque/20*TAU;
			}
		}
		
		world.playerShip.rot += world.playerShip.torque*timeDelta;
		world.playerShip.pos[] += world.playerShip.velocity[]*timeDelta;
		////foreach (wyrmNode; wyrms.iterator) {
		////	////wyrmNode.value.pos[0]++;
		////}
	}
}
