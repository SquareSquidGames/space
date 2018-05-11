import std.stdio;
import core.thread;
import core.time : msecs;

import cst_;
import linked.destructive_node;

import game_logic.game_logic;
import io.renderer;
import io.input_handler;
import objects.world;





void main() {
	World world = new World;
	
	GameLogic gameLogic = new GameLogic(world);
	Renderer renderer = new Renderer(world);
	InputHandler inputHandler = new InputHandler(renderer);
	
	while (true) {
		Thread.sleep(msecs(100));
		auto gameEvents = inputHandler.handleInput;
		gameLogic.update(gameEvents, 0.1);
		renderer.render;
	}
}
