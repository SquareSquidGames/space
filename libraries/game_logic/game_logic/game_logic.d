module game_logic.game_logic;

import linked.destructive_node ;
import linked.no_sent_node_funs ;
import objects.world;
import objects.ship;
import objects.bullet;
import game_events.game_event;
import math.tau;
import math.polar_rect;
import xyz;
import std.math;
import game_logic.scenario_handler;
import game_logic.ship_ai_handler;

class GameLogic {
	World world;
	ScenarioHandler scenarioHandler;
	ShipAiHandler shipAiHandler;
	
	float inputThrust=0;
	float inputTorque=0;
	
	this(World world) {
		this.world	= world;
		this.scenarioHandler	= new ScenarioHandler(world);
		this.shipAiHandler	= new ShipAiHandler(world);
	}
	
	void update(GameEvent[] gameEvents, float timeDelta) {
		scenarioHandler.update(timeDelta);
		
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
		
		Node!Bullet** lastBulletNextPtr = &world.bullets;
		foreach (Node!Bullet* bulletNode; world.bullets.iterator) {
			bulletNode.value.pos[] += bulletNode.value.velocity[]*timeDelta;
			foreach (shipNode; world.ships.iterator) {
				if (shipNode.value.pos.distance(bulletNode.value.pos) < 0.2) {
					*lastBulletNextPtr = bulletNode.next;
				}
			}
			lastBulletNextPtr = &bulletNode.next();
		}
		foreach (shipNode; world.ships.iterator) {
			shipAiHandler.handleShip(shipNode.value);
			shipNode.value.rot	+= shipNode.value.torque*timeDelta;
			shipNode.value.pos[]	+= shipNode.value.velocity[]*timeDelta;
			break;
		}
	}
	
	
}


float distance(float[2] point1, float[2]  point2) {
	float[2] d = point1[]-point2[];
	float distance = sqrt(d.x*d.x + d.y*d.y);
	return distance;
}