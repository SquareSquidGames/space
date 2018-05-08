module io.io_manager;

import llist.slist;
import objects.world;
import game_events.game_event;

import dsdl2.window;

class IoManager {
	World world;
	
	Window window;
	
	this(World world) {
		this.world = world;
		
		window = new Window("Window!!!", [256,192]);
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
