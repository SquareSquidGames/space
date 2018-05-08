module game_logic.game_logic;
import llist.slist;
import objects.wyrm;
import game_events.game_event;

class GameLogic {
	Node!Wyrm* wyrms;
	this(Node!Wyrm* wyrms) {
		this.wyrms = wyrms;
		wyrms.append(new Wyrm);
	}
	
	void update(GameEvent[] gameEvents) {
		foreach (event; gameEvents) {
			if (event.type == EventType.wyrmRotate) {
				Node!Wyrm* wyrmNode = wyrms;
				foreach (_; 0..event.wyrmRotate.playerNum) {
					wyrmNode = wyrmNode.next;
				}
				wyrmNode.value.rot += event.wyrmRotate.torque;
			}
			else if (event.type == EventType.wyrmThrust) {
				
			}
			else if (event.type == EventType.wyrmWarp) {
				
			}
		}
		foreach (wyrmNode; wyrms.iterator) {
			////wyrmNode.value.pos[0]++;
		}
	}
}
