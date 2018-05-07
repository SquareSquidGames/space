module rendering.renderer;
import llist.slist;
import objects.wyrm;

class Renderer {
	Node!Wyrm* wyrms;
	this(Node!Wyrm* wyrms) {
		this.wyrms = wyrms;
	}
	
	void update() {
		foreach (wyrm; wyrms.iterator) {
			import std.stdio;
			wyrm.value.pos.writeln;
		}
	}
}
