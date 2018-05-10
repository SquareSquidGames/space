module game_logic.game_logic;

import llist.slist;
import objects.world;
import objects.ship;
import objects.bullet;
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
			else if (event.type == EventType.rotateGun) {
				world.playerShip.gunDirection += event.rotateGun.angle*timeDelta;
			}
			else if (event.type == EventType.fire) {
				float[2] mov;
				mov = world.playerShip.velocity[] + getRect(0.1f,world.playerShip.gunDirection)[];
				auto node = world.bullets;
				while (node.next!=null)
					node=node.next;
				node.append(new Bullet(world.playerShip.pos, world.playerShip.gunDirection, mov));
			}
		}

		world.playerShip.velocity[]	+=getRect(inputThrust/10,world.playerShip.rot)[];
		world.playerShip.torque	+=inputTorque/20*TAU;
		
		world.playerShip.rot += world.playerShip.torque*timeDelta;
		world.playerShip.pos[] += world.playerShip.velocity[]*timeDelta;
		////foreach (wyrmNode; wyrms.iterator) {
		////	////wyrmNode.value.pos[0]++;
		////}
	}
}
