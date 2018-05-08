module io.io_manager;
import llist.slist;
import objects.wyrm;
import game_events.game_event;

class IoManager {
	Node!Wyrm* wyrms;
	this(Node!Wyrm* wyrms) {
		this.wyrms = wyrms;
	}
	
	void render() {
		foreach (wyrmNode; wyrms.iterator) {
			import std.stdio;
			wyrmNode.value.rot.writeln;
		}
	}
	
	GameEvent[] handleInput() {
		GameEvent gameEvent;
		{
			gameEvent.type = EventType.wyrmRotate;
			gameEvent.wyrmRotate.torque = -3;
		}
		return [gameEvent];
	}
}
