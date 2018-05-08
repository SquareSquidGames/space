import std.stdio;
import core.thread;
import core.time : msecs;

import cst_;
import llist.slist;

import game_logic.game_logic;
import io.io_manager;
import objects.wyrm;





void main() {
	Node!Wyrm* wyrms = new Node!Wyrm;
	
	GameLogic gameLogic = new GameLogic(wyrms);
	
	IoManager ioManager = new IoManager(wyrms);
	
	while (true) {
		Thread.sleep(msecs(100));
		auto gameEvents = ioManager.handleInput;
		gameLogic.update(gameEvents);
		ioManager.render;
	}
}
