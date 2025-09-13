package;

import Performance;
import flixel.FlxGame;
import openfl.display.Sprite;
import states.TitleState;

class Main extends Sprite {
	public function new() {
		super();
		addChild(new FlxGame(0, 0, TitleState.new, 60, 60, true));

		var performance:Performance = new Performance();
		addChild(performance);
	}
}
