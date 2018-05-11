module io.renderer;


import clay_sdl.window;
import glwt;
import glwt.buffer;
import glwt.vertex_array;
import glwt.draw;
import glwt.shader;
import glwt.program;
import glwt.viewport;
import glwt.clear;
import gl_context;


import linked.destructive_node	;
import linked.no_sent_node_funs	;
import objects.world;
import game_events.game_event;

private {
	enum string vertexShader = 
		"#version 330
		
		uniform mat4 projection;
		uniform vec2 pos = vec2(0,0);
		uniform mat2 rot;
		uniform vec2 scale;

		layout (location = 0) in vec3 inPos;
		layout (location = 1) in vec3 inColor;

		smooth out vec3 vertColor;

		void main() {
			////gl_Position = vec4(inPos, 1.0);
			////gl_Position = vec4(inPos.xy+pos,inPos.z, 1.0);
			gl_Position = projection*vec4((rot*inPos.xy*scale)+pos,inPos.z, 1.0);
			vertColor = inColor;
		}";

	enum string fragmentShader =
		"#version 330

		smooth in vec3 vertColor;
		out vec4 outputColor;

		void main() {
			outputColor = vec4(vertColor, 1.0);
		}";
}


float[4][4] orthoProjection(float[2] size, float nearPlane, float farPlane) {
	return [	[1f/size[0]	,0f	,0f	,0f	],
		[0f	,1f/size[1]	,0f	,0f	],
		[0f	,0f	,-2f/(farPlane-nearPlane)	,0f	],
		[0f	,0f	,-(farPlane+nearPlane)/(farPlane-nearPlane)	,1f	]];
}
float[2][2] rotationMatrix(float angle) {
	import std.math;
	return [	[cos(angle)	,sin(angle)	],
		[-sin(angle)	,cos(angle)	]];
}


class Renderer {
	World world;

	Window window;
	
	GLContext context;
	VertexShader vert;
	FragmentShader frag;
	Program program;
	int uniformLoc_projection;
	int uniformLoc_pos;
	int uniformLoc_rot;
	int uniformLoc_scale;
	float[4][4] projection;

	VertexArray playerShip;
	VertexArray playerGun;
	VertexArray bullet;
	VertexArray ship;

	this(World world) {
		this.world = world;

		SetupGl.ver(3,2);
		SetupGl.ContextProfileMask.core;
		int x = 256;
		int y = 192;
		window = new Window("Window!!!", [x,y], Window.Flags.OPENGL|Window.Flags.Resizable);
		calcProjection([x,y]);
		
		context = window.createGLContext;
		reloadGl();
		context.makeCurrent();
		
		vert.create;
		vert.source(vertexShader);
		vert.compile;
		frag.create;
		frag.source(fragmentShader);
		frag.compile;
		program.create;
		program.attach(vert);
		program.attach(frag);
		program.link;
		
		program.use;
		uniformLoc_projection	= program.getUniform("projection");
		uniformLoc_pos	= program.getUniform("pos");
		uniformLoc_rot	= program.getUniform("rot");
		uniformLoc_scale	= program.getUniform("scale");
		
		//---playerShip
		{
			float[3][] vertices = [
				[	-0.5	,  0.5	, 0.0f	]	,
				[	-0.5	, -0.5	, 0.0f	]	,
				[	 0.5	,  0.0	, 0.0f	]	,
				[	-0.5	,  0.5	, 0.0f	]	,
				[	-0.5	, -0.5	, 0.0f	]	,
				[	-1.0	,  0.0	, 0.0f	]	,
			];
			float[3][] colors = [
				[	1	, 0	, 0	]	,
				[	0	, 1	, 0	]	,
				[	0	, 0	, 1	]	,
				[	1	, 0	, 0	]	,
				[	0	, 1	, 0	]	,
				[	0	, 0	, 1	]	,
			];
			playerShip.gen;
			playerShip.bind;
			playerShip.enableAttribute(0);
			playerShip.enableAttribute(1);
			playerShip.attributePointer(0, ArrayBuffer(vertices, BufferUsage.StaticDraw), 3, DataType.Float);
			playerShip.attributePointer(1, ArrayBuffer(colors, BufferUsage.StaticDraw), 3, DataType.Float);
		}
		//---playerGun
		{
			float[3][] vertices = [
				[	-0.2	,  0.2	, 0.0f	]	,
				[	-0.2	, -0.2	, 0.0f	]	,
				[	 1	,  0.0	, 0.0f	]	,
			];
			float[3][] colors = [
				[	0.5	, 0.2	, 0.2	]	,
				[	0.2	, 0.5	, 0.2	]	,
				[	0.2	, 0.2	, 0.5	]	,
			];
			playerGun.gen;
			playerGun.bind;
			playerGun.enableAttribute(0);
			playerGun.enableAttribute(1);
			playerGun.attributePointer(0, ArrayBuffer(vertices, BufferUsage.StaticDraw), 3, DataType.Float);
			playerGun.attributePointer(1, ArrayBuffer(colors, BufferUsage.StaticDraw), 3, DataType.Float);
		}
		//---ship
		{
			float[3][] vertices = [
				[	-0.25	,  0.25	, 0.0f	]	,
				[	-0.25	, -0.25	, 0.0f	]	,
				[	 0.25	,  0.0	, 0.0f	]	,
			];
			float[3][] colors = [
				[	1	, 0	, 0	]	,
				[	0	, 1	, 0	]	,
				[	0	, 0	, 1	]	,
			];
			ship.gen;
			ship.bind;
			ship.enableAttribute(0);
			ship.enableAttribute(1);
			ship.attributePointer(0, ArrayBuffer(vertices, BufferUsage.StaticDraw), 3, DataType.Float);
			ship.attributePointer(1, ArrayBuffer(colors, BufferUsage.StaticDraw), 3, DataType.Float);
		}
		//---bullet
		{
			float[3][] vertices = [
				[	-0.1	,  0.1	, 0.0f	]	,
				[	-0.1	, -0.1	, 0.0f	]	,
				[	 0.1	,  0.0	, 0.0f	]	,
			];
			float[3][] colors = [
				[	1	, 1	, 1	]	,
				[	0	, 1	, 0	]	,
				[	0	, 0	, 1	]	,
			];
			bullet.gen;
			bullet.bind;
			bullet.enableAttribute(0);
			bullet.enableAttribute(1);
			bullet.attributePointer(0, ArrayBuffer(vertices, BufferUsage.StaticDraw), 3, DataType.Float);
			bullet.attributePointer(1, ArrayBuffer(colors, BufferUsage.StaticDraw), 3, DataType.Float);
		}
	}
	
	void resize(int[2] size) {
		window.resize(size);
		setGlViewport([0,0],size);
		calcProjection(size);
	}
	void calcProjection(int[2] size) {
		projection = orthoProjection([size[0]>size[1]?cast(float)size[0]/size[1]:1,size[0]<size[1]?cast(float)size[1]/size[0]:1],-1,1);
	}

	void render() {
		clear;
		
		program.use;
		program.uniformVector(uniformLoc_scale, [0.1f,0.1]);
		
		program.uniformMatrix!(float,4,4)(uniformLoc_projection, projection);
		
		foreach(shipNode; world.ships.iterator) {
			float[2] rPos = (shipNode.payload.pos[] - world.playerShip.pos[]) /4;
			program.uniformVector(uniformLoc_pos, rPos);
			program.uniformMatrix!(float,2,2)(uniformLoc_rot, rotationMatrix(shipNode.payload.rot));
		
			ship.bind;
			ship.draw(Primitive.Triangles, 3);
		}
		foreach(bulletNode; world.bullets.iterator) {
			float[2] rPos = (bulletNode.payload.pos[] - world.playerShip.pos[]) /4;
			program.uniformVector(uniformLoc_pos, rPos);
			program.uniformMatrix!(float,2,2)(uniformLoc_rot, rotationMatrix(bulletNode.payload.rot));

			bullet.bind;
			bullet.draw(Primitive.Triangles, 3);
		}
		program.uniformVector(uniformLoc_pos, [0f,0]);
		program.uniformMatrix!(float,2,2)(uniformLoc_rot, rotationMatrix(world.playerShip.rot));
		playerShip.bind;
		playerShip.draw(Primitive.Triangles, 6);
		
		program.uniformMatrix!(float,2,2)(uniformLoc_rot, rotationMatrix(world.playerShip.gunDirection));
		playerGun.bind;
		playerGun.draw(Primitive.Triangles, 3);
		

		context.flip();
	}

}
