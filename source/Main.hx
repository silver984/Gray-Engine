package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;
import states.TitleState;
import ui.Performance;

class Main extends Sprite {
	public function new() {
		super();
		addChild(new FlxGame(1280, 720, TitleState.new, 240, 240, true, true));
		FlxG.fixedTimestep = false;
		FlxG.maxElapsed = 0.1;

		var performance:Performance = new Performance();
		addChild(performance);
	}
}
