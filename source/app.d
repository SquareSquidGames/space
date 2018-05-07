import std.stdio;

import cst_;
import llist.slist;

import game_logic.game_logic;
import rendering.renderer;
import objects.wyrm;





void main() {
	Node!Wyrm* wyrms = new Node!Wyrm;
	
	GameLogic gameLogic = new GameLogic(wyrms);
	
	Renderer renderer = new Renderer(wyrms);
	
	while (true) {
		gameLogic.update;
		renderer.update;
	}
}
