module game_logic.game_logic;

import llist.slist;
import objects.world;
import objects.ship;
import game_events.game_event;
import math.tau;
import math.polar_rect;

class GameLogic {
	World world;
	
	float inputThrust=0;
	float inputTorque=0;
	
	this(World world) {
		this.world = world;
		world.ships.append(new Ship([0,-3],0));
		world.ships.insertAfter(new Ship([2,2],0.5*TAU));
		world.ships.insertAfter(new Ship([-2,1],0.1*TAU));
	}
	
	void update(GameEvent[] gameEvents, float timeDelta) {
		foreach (event; gameEvents) {
			if (event.type == EventType.thrust) {
				inputThrust = event.thrust.thrust;
			}
			else if (event.type == EventType.torque) {
				inputTorque = event.torque.torque;
			}
		}

		world.playerShip.velocity[]	+=getRect(inputThrust/20,world.playerShip.rot)[];
		world.playerShip.torque	+=inputTorque/20*TAU;
		
		world.playerShip.rot += world.playerShip.torque*timeDelta;
		world.playerShip.pos[] += world.playerShip.velocity[]*timeDelta;
		////foreach (wyrmNode; wyrms.iterator) {
		////	////wyrmNode.value.pos[0]++;
		////}
	}
}
