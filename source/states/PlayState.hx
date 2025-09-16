package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import ui.TransitionManager;

class PlayState extends FlxState {
	var text:FlxText;
	var conductor:Conductor;
	var switchedState:Bool;

	public function new()
	{
		super();
	}

	override public function create()
	{
		super.create(); 
		switchedState = false;

		text = new FlxText();
		text.text = '';
		text.size = 20;
		text.color = FlxColor.WHITE;
		text.setBorderStyle(OUTLINE, FlxColor.BLACK, 2, 1);
		text.alignment = CENTER;
		text.antialiasing = true;
		
		add(text);

		Conductor.setMusic('songs/bopeebo/Inst');
		TransitionManager.fadeOut();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		Conductor.update();

		text.text = 'curBeat: ${Conductor.curBeat}';
		text.screenCenter();

		if (switchedState)
			return;

		if (FlxG.keys.justPressed.ENTER)
		{
			TransitionManager.fadeIn(TitleState.new, true);
			switchedState = true;
		}
	}
}
