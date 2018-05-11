module objects.ship;

class Ship{
	float[2]	pos	= [0,0]	;
	float	rot	= 0	;
	float[2]	velocity	= [0,0]	;
	float	torque	= 0	;
	
	bool removed = false;// For destructive node
	
	this(float[2] pos, float rot) {
		this.pos = pos;
		this.rot = rot;
	}
}

