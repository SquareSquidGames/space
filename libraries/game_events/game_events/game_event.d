/**	Events that are from the input manager to the game logic.
*/
module game_events.game_event;

enum EventType: ubyte {
	thrust,
	torque,
	rotateGun,
	fire,
}

struct GameEvent {
	EventType type;
	union {
		ThrustEvent	thrust	;
		TorqueEvent	torque	;
		RotateGunEvent	rotateGun	;
		FireEvent	fireGun	;
	}
}

struct ThrustEvent {
	float thrust;
}
struct TorqueEvent {
	float torque;
}
struct RotateGunEvent {
	float angle;
}
struct FireEvent {
}