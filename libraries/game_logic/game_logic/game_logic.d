module game_logic.game_logic;

import llist.slist;
import objects.world;
import objects.ship;
import objects.bullet;
import game_events.game_event;
import math.tau;
import math.polar_rect;
import xyz;
import std.math;

class GameLogic {
	World world;
	
	float inputThrust=0;
	float inputTorque=0;
	
	this(World world) {
		this.world = world;
		world.ships = new Node!Ship(world.ships	, new Ship([0,-3],0)	);
		world.ships = new Node!Ship(world.ships	, new Ship([2,2],0.5*TAU)	);
		world.ships = new Node!Ship(world.ships	, new Ship([-2,1],0.1*TAU)	);
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
				float[2] mov = world.playerShip.velocity[] + getRect(2f,world.playerShip.gunDirection)[];
				world.bullets = new Node!Bullet(world.bullets	, new Bullet(world.playerShip.pos, world.playerShip.gunDirection, mov)	);
			}
		}

		world.playerShip.velocity[]	+=getRect(inputThrust/10,world.playerShip.rot)[];
		world.playerShip.torque	+=inputTorque/20*TAU;
		
		world.playerShip.rot += world.playerShip.torque*timeDelta;
		world.playerShip.pos[] += world.playerShip.velocity[]*timeDelta;
		
		Node!Bullet** lastBulletNode = &world.bullets;
		foreach (bulletNode; world.bullets.iterator) {
			bulletNode.value.pos[] += bulletNode.value.velocity[]*timeDelta;
			foreach (shipNode; world.ships.iterator) {
				if (shipNode.value.pos.distance(bulletNode.value.pos) < 0.2) {
					*lastBulletNode = bulletNode.next;
				}
			}
			lastBulletNode = &bulletNode.next;
		}
	}
	
	
}


float distance(float[2] point1, float[2]  point2) {
	float[2] d = point1[]-point2[];
	float distance = sqrt(d.x*d.x + d.y*d.y);
	return distance;
}