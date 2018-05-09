module io.input_handler;

import std.stdio;

import clay_sdl.event;
import math.tau;

import io.renderer;
import game_events.game_event;

class InputHandler {
	Renderer renderer;
	EventQueue	eventQueue;
	
	struct KeysDown {	bool up;	bool down;	bool left;	bool right;	}
	KeysDown keysDown;
		
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
					bool thrustChanged	= false;
					bool torgueChanged	= false;
					if (keycode == Keycode.LEFT) {
						keysDown.left	= true;
						torqudChanged	= true;
					}
					else if (keycode == Keycode.RIGHT) {
						keysDown.right	= true;
						torqueChanged	= true;
					}
					else if (keycode == Keycode.UP) {
						keysDown.up	= true;
						thrustChanged	= true;
					}
					else if (keycode == Keycode.DOWN) {
						keysDown.down	= true;
						thustChanged	= true;
					}
					
					if (torqueChanged) {
						GameEvent gameEvent;
						{
							gameEvent.type = EventType.torque;
							gameEvent.torque.torque = keyDown.right-keysDown.left;
						}
						gameEvents ~= gameEvent;
					}
					if (torqueChanged) {
						GameEvent gameEvent;
						{
							gameEvent.type = EventType.thrust;
							gameEvent.thrust.thrust = keyDown.up-keysDown.down;
						}
						gameEvents ~= gameEvent;
					}
				}
			}
		}
		
		return gameEvents;
	}
}
