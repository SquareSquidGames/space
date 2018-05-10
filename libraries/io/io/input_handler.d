module io.input_handler;

import cst_;
import std.stdio;

import clay_sdl.event;
import math.tau;

import io.renderer;
import game_events.game_event;

class InputHandler {
	Renderer renderer;
	EventQueue	eventQueue;
	
	struct KeysDown {	bool up;	bool down;	bool left;	bool right;	bool rotateGunLeft;	bool rotateGunRight;	}
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
			
			{
				bool thrustChanged	= false;
				bool torqueChanged	= false;
				if (event.type == event.Type.KEY_DOWN) {
					with (event.key) {
						if (keycode == Keycode.R) {
							keysDown.left	= true;
							torqueChanged	= true;
						}
						else if (keycode == Keycode.N) {
							keysDown.right	= true;
							torqueChanged	= true;
						}
						else if (keycode == Keycode.E) {
							keysDown.up	= true;
							thrustChanged	= true;
						}
						else if (keycode == Keycode.COMMA) {
							keysDown.down	= true;
							thrustChanged	= true;
						}
					}
				}
				else if (event.type == event.Type.KEY_UP) {
					with (event.key) {
						if (keycode == Keycode.R) {
							keysDown.left	= false;
							torqueChanged	= true;
						}
						else if (keycode == Keycode.N) {
							keysDown.right	= false;
							torqueChanged	= true;
						}
						else if (keycode == Keycode.E) {
							keysDown.up	= false;
							thrustChanged	= true;
						}
						else if (keycode == Keycode.COMMA) {
							keysDown.down	= false;
							thrustChanged	= true;
						}
					}
				}
				if (torqueChanged) {
					GameEvent gameEvent;
					{
						gameEvent.type = EventType.torque;
						gameEvent.torque.torque = (keysDown.right?-1:0)+(keysDown.left?1:0);
					}
					gameEvents ~= gameEvent;
				}
				if (thrustChanged) {
					GameEvent gameEvent;
					{
						gameEvent.type = EventType.thrust;
						gameEvent.thrust.thrust = (keysDown.up?1:0)+(keysDown.down?-1:0);
					}
					gameEvents ~= gameEvent;
				}
			}
			{
				if (event.type == event.Type.KEY_DOWN) {
					with (event.key) {
						if (keycode == Keycode.S) {
							keysDown.rotateGunLeft	= true;
						}
						else if (keycode == Keycode.I) {
							keysDown.rotateGunRight	= true;
						}
					}
				}
				else if (event.type == event.Type.KEY_UP) {
					with (event.key) {
						if (keycode == Keycode.S) {
							keysDown.rotateGunLeft	= false;
						}
						else if (keycode == Keycode.I) {
							keysDown.rotateGunRight	= false;
						}
					}
				}
			}
		}

		if ((keysDown.rotateGunLeft?1:0)+(keysDown.rotateGunRight?-1:0)!=0) {
			GameEvent gameEvent;
			{
				gameEvent.type = EventType.rotateGun;
				gameEvent.rotateGun.angle = (keysDown.rotateGunLeft?1:0)+(keysDown.rotateGunRight?-1:0);
			}
			gameEvents ~= gameEvent;
		}
		
		return gameEvents;
	}
}
