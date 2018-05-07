module rendering.renderer;
import llist.slist;
import objects.wyrm;

class Renderer {
	Node!Wyrm* wyrms;
	this(Node!Wyrm* wyrms) {
		this.wyrms = wyrms;
	}
}
