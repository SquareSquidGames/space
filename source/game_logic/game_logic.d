module game_logic.game_logic;
import llist.slist;
import objects.wyrm;

class GameLogic {
	Node!Wyrm* wyrms;
	this(Node!Wyrm* wyrms) {
		this.wyrms = wyrms;
	}
}
