import std.stdio;
import core.thread;
import core.time : msecs;

import cst_;
import llist.slist;

import game_logic.game_logic;
import io.io_manager;
import objects.world;





void main() {
	World world = new World;
	
	GameLogic gameLogic = new GameLogic(world);
	IoManager ioManager = new IoManager(world);
	
	while (true) {
		Thread.sleep(msecs(100));
		auto gameEvents = ioManager.handleInput;
		gameLogic.update(gameEvents);
		ioManager.render;
	}
}
