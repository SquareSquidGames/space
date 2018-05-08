module game_logic.game_logic;

import llist.slist;
import objects.world;
import game_events.game_event;

class GameLogic {
	World world;
	this(World world) {
		this.world = world;
	}
	
	void update(GameEvent[] gameEvents) {
		foreach (event; gameEvents) {
			if (event.type == EventType.thrust) {
			}
			else if (event.type == EventType.torque) {
				////Node!Wyrm* wyrmNode = wyrms;
				////foreach (_; 0..event.wyrmRotate.playerNum) {
				////	wyrmNode = wyrmNode.next;
				////}
				////wyrmNode.value.rot += event.wyrmRotate.torque;
			}
		}
		////foreach (wyrmNode; wyrms.iterator) {
		////	////wyrmNode.value.pos[0]++;
		////}
	}
}
