module io.io_manager;

import llist.slist;
import objects.world;
import game_events.game_event;

class IoManager {
	World world;
	
	this(World world) {
		this.world = world;
	}
	
	void render() {
		////foreach (wyrmNode; wyrms.iterator) {
		////	import std.stdio;
		////	wyrmNode.value.rot.writeln;
		////}
	}
	
	GameEvent[] handleInput() {
		GameEvent gameEvent;
		{
			gameEvent.type = EventType.thrust;
			gameEvent.thrust.thrust = -3;
		}
		return [gameEvent];
	}
}
