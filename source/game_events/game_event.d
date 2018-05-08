module game_events.game_event;

enum EventType: ubyte {
	wyrmRotate,
	wyrmThrust,
	wyrmWarp,
}

struct GameEvent {
	EventType type;
	union {
		WyrmRotate wyrmRotate;
		WyrmThrust wyrmThrust;
		WyrmWarp wyrmWarp;
	}
}

struct WyrmRotate {
	ubyte playerNum;
	float torque;
}
struct WyrmThrust {
	ubyte playerNum;
	float thrust;
}
struct WyrmWarp {
	ubyte playerNum;
	
}