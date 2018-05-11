module objects.ship;

class Ship{
	float[2] pos = [0,0];
	float rot = 0;
	
	bool removed = false;// For destructive node
	
	this(float[2] pos, float rot) {
		this.pos = pos;
		this.rot = rot;
	}
}

