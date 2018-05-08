module io.renderer;


import clay_sdl.window;
import glwt;
import glwt.buffer;
import glwt.vertex_array;
import glwt.draw;
import glwt.shader;
import glwt.program;
import gl_context;

import llist.slist;
import objects.world;
import game_events.game_event;

private {
	enum string vertexShader = 
		"#version 330


		//uniform vec3 pos = vec3(0,0,0);

		layout (location = 0) in vec3 inPosition;
		//layout (location = 1) in vec3 inColor;

		//smooth out vec3 theColor;

		void main() {
			gl_Position = vec4(inPosition, 1.0);
			//theColor = inColor;
		}";

	enum string fragmentShader =
		"#version 330

		//smooth in vec3 theColor;
		out vec4 outputColor;

		void main() {
			outputColor = vec4(1,0,0, 1.0);
		}";
}


class Renderer {
	World world;

	Window window;
	
	GLContext context;
	VertexShader vert;
	FragmentShader frag;
	Program program;

	ArrayBuffer objectVerts;
	VertexArray object;

	this(World world) {
		this.world = world;

		SetupGl.ver(3,2);
		SetupGl.ContextProfileMask.core;
		window = new Window("Window!!!", [256,192], Window.Flags.OPENGL);
		
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
		


		float[3][] vertices = [
			[	-0.5	, -0.5	, 0.0f	]	,
			[	0.5	, -0.5	, 0.0f	]	,
			[	0.0	, 0.5	, 0.0f	]	,
		];
		object.gen;
		object.bind;
		object.enableAttribute(0);
		objectVerts.gen;
		objectVerts.bind;
		objectVerts.data(vertices, BufferUsage.StaticDraw);
		object.attributePointer(0, objectVerts, 3, DataType.Float);
		
	}

	void render() {
		program.use;
		
		object.bind;
		object.draw(Primitive.Triangles, 3);

		context.flip();
	}

}
