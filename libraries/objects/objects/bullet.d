module objects.bullet;

class Bullet{
	float[2]	pos	= [0,0];
	float	rot	= 0;
	float[2]	velocity	= [0,0];

	bool removed = false;

	this(float[2] pos, float rot, float[2] velocity) {
		this.pos	= pos	;
		this.rot	= rot	;
		this.velocity	= velocity	;
	}
}

