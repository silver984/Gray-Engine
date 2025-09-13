package states;

import Conductor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState {
	var text:FlxText;
	var conductor:Conductor;
	var dir:Directories;
	
	override public function create() {
		super.create(); 

		text = new FlxText();
		text.text = '';
		text.size = 20;
		text.color = FlxColor.WHITE;
		text.setBorderStyle(OUTLINE, FlxColor.BLACK, 2, 1);
		text.alignment = CENTER;
		text.antialiasing = true;
		
		add(text);

		FlxG.sound.play('assets/music/songs/bopeebo/Inst.ogg');
		
		var bgMusic:flixel.sound.FlxSound = FlxG.sound.play(dir.music('songs/bopeebo/inst'), 1, true);
		conductor = new Conductor(bgMusic);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		conductor.update();

		text.text = 'curBeat: ${conductor.curBeat}';

		text.x = (FlxG.width / 2) - (text.width / 2);
		text.y = (FlxG.height / 2) - (text.height / 2);
	}
}
