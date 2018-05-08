module io.input_handler;

import std.stdio;

import clay_sdl.event;

import io.renderer;
import game_events.game_event;

class InputHandler {
	EventQueue	eventQueue;
		
	this(Renderer renderer) {
		eventQueue	= new EventQueue;
	}

	GameEvent[] handleInput() {
		GameEvent gameEvent;
		{
			gameEvent.type = EventType.thrust;
			gameEvent.thrust.thrust = -3;
		}

		foreach (event; eventQueue) {
			if (event.type == event.Type.QUIT) {
				"Quit".writeln;
			}
			else if (event.type == event.Type.WINDOW_EVENT) {
				with (event.window) {
					if (type == Type.CLOSE) {
						"WindowClose".writeln;
					}
				}
			}
		}
		
		return [gameEvent];
	}
}
