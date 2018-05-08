module io.renderer;


import clay_sdl.window;
import glwt;
import glwt.buffer;
import glwt.vertex_array;
import glwt.draw;
import glwt.shader;
import glwt.program;
import glwt.viewport;
import gl_context;

import llist.slist;
import objects.world;
import game_events.game_event;

private {
	enum string vertexShader = 
		"#version 330
		
		uniform mat4 projection;
		uniform vec2 pos = vec2(0,0);

		layout (location = 0) in vec3 inPos;
		layout (location = 1) in vec3 inColor;

		smooth out vec3 vertColor;

		void main() {
			////gl_Position = vec4(inPos, 1.0);
			////gl_Position = vec4(inPos.xy+pos,inPos.z, 1.0);
			gl_Position = projection*vec4(inPos.xy+pos,inPos.z, 1.0);
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


class Renderer {
	World world;

	Window window;
	
	GLContext context;
	VertexShader vert;
	FragmentShader frag;
	Program program;
	int uniformLoc_projection;
	int uniformLoc_pos;
	float[4][4] projection;

	ArrayBuffer objectVerts;
	ArrayBuffer objectCols;
	VertexArray object;

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
		


		float[3][] vertices = [
			[	-0.1	, -0.1	, 0.0f	]	,
			[	0.1	, -0.1	, 0.0f	]	,
			[	0.0	, 0.1	, 0.0f	]	,
		];
		float[3][] colors = [
			[	1	, 0	, 0	]	,
			[	0	, 1	, 0	]	,
			[	0	, 0	, 1	]	,
		];
		object.gen;
		object.bind;
		object.enableAttribute(0);
		object.enableAttribute(1);
		objectVerts.gen;
		objectVerts.bind;
		objectVerts.data(vertices, BufferUsage.StaticDraw);
		object.attributePointer(0, objectVerts, 3, DataType.Float);
		objectCols.gen;
		objectCols.bind;
		objectCols.data(colors, BufferUsage.StaticDraw);
		object.attributePointer(1, objectCols, 3, DataType.Float);
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
		program.use;
		
		program.uniformMatrix!(float,4,4)(uniformLoc_projection, projection);
		program.uniformVector(uniformLoc_pos, [0f,0f]);
		
		object.bind;
		object.draw(Primitive.Triangles, 3);

		context.flip();
	}

}
