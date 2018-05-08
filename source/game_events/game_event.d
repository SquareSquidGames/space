/**	Events that are from the input manager to the game logic.
*/
module game_events.game_event;

enum EventType: ubyte {
	thrust,
	torque,
}

struct GameEvent {
	EventType type;
	union {
		ThrustEvent thrust;
		TorqueEvent torque;
	}
}

struct ThrustEvent {
	float thrust;
}
struct TorqueEvent {
	float torque;
}