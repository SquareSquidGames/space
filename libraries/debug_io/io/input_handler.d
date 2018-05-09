module io.input_handler;

import std.stdio;

import io.renderer;
import game_events.game_event;

class InputHandler {
	Renderer renderer;
		
	this(Renderer renderer) {
		this.renderer = renderer;
	}

	GameEvent[] handleInput() {
		GameEvent[] gameEvents;

		return gameEvents;
	}
}
