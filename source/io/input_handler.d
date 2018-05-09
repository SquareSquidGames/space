module io.input_handler;

import std.stdio;

import clay_sdl.event;
import math.tau;

import io.renderer;
import game_events.game_event;

class InputHandler {
	Renderer renderer;
	EventQueue	eventQueue;
		
	this(Renderer renderer) {
		this.renderer = renderer;
		eventQueue	= new EventQueue;
	}

	GameEvent[] handleInput() {
		GameEvent[] gameEvents;

		foreach (event; eventQueue) {
			if (event.type == event.Type.QUIT) {
				"Quit".writeln;
			}
			else if (event.type == event.Type.WINDOW_EVENT) {
				with (event.window) {
					if (type == Type.CLOSE) {
						"WindowClose".writeln;
					}
					if (type == Type.RESIZED) {
						renderer.resize(size);
					}
				}
			}
			else if (event.type == event.Type.KEY_DOWN) {
				with (event.key) {
					if (keycode == Keycode.LEFT) {
						GameEvent gameEvent;
						{
							gameEvent.type = EventType.torque;
							gameEvent.torque.torque = 1;
						}
						gameEvents ~= gameEvent;
					}
					else if (keycode == Keycode.RIGHT) {
						GameEvent gameEvent;
						{
							gameEvent.type = EventType.torque;
							gameEvent.torque.torque = -1;
						}
						gameEvents ~= gameEvent;
					}
					else if (keycode == Keycode.UP) {
						GameEvent gameEvent;
						{
							gameEvent.type = EventType.thrust;
							gameEvent.thrust.thrust = 1;
						}
						gameEvents ~= gameEvent;
					}
					else if (keycode == Keycode.DOWN) {
						GameEvent gameEvent;
						{
							gameEvent.type = EventType.thrust;
							gameEvent.thrust.thrust = -1;
						}
						gameEvents ~= gameEvent;
					}
				}
			}
		}
		
		return gameEvents;
	}
}
