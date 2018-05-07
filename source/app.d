import std.stdio;

import cst_;

import game_logic.game_logic;
import rendering.renderer;
import objects.wyrm;





void main() {
	Wyrm[] wyrms = new Wyrms[];
	
	GameLogic gameLogic = new GameLogic(wyrms);
	
	Renderer renderer = new Renderer(wyrms);
	
}
