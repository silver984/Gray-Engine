package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxRandom;
import flixel.sound.FlxSound;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import objects.AnimatedBoldFont;
import objects.Character;
import objects.Util;
import openfl.utils.Assets;
import ui.TransitionManager;

class TitleState extends FlxState
{
	public static var isAlive:Bool = false;

	static var textField:Array<AnimatedBoldFont> = [];
	static var lines:Array<Array<String>>;
	static var upperTxt:String;
	static var lowerTxt:String;

    // flash for when beat drops
	static var bg:FlxSprite;

	static var whiteFlash:FlxSprite;

	var hasFlashed:Bool = false;

	static var gf:Character;

	static var logo:FlxSprite;

	var pressEnter:FlxSprite;

	static var canPress:Bool = false;

	public function new()
	{
		super();
	}

	override public function create():Void
	{
		super.create();
		isAlive = true;

		logo = new FlxSprite();
		logo.antialiasing = true;
		logo.frames = FlxAtlasFrames.fromSparrow(Directories.images('logo'), Directories.images('logo', 'xml'));
		logo.animation.addByNames('idle', Util.returnNames('idle', 0, 14), 24, false);
		logo.scale.x = 0.95;
		logo.scale.y = 0.95;
		logo.updateHitbox();
		logo.x = -90;
		logo.y = -90;
		add(logo);

		gf = new Character('girlfriend-title');
		gf.addAnim('idle', 'leftBop', 'left-idle', 0, 14, 12);
		gf.addAnim('idle', 'rightBop', 'right-idle', 15, 29, 12);
		gf.x = FlxG.width - (gf.width + 20);
		gf.screenCenter(FlxAxes.Y);
		add(gf);

		pressEnter = new FlxSprite();
		pressEnter.antialiasing = true;
		pressEnter.frames = FlxAtlasFrames.fromSparrow(Directories.images('press-enter'), Directories.images('press-enter', 'xml'));
		pressEnter.animation.addByNames('idle', Util.returnNames('Press Enter to Begin', 0, 44), 24, true);
		pressEnter.animation.addByNames('pressed', Util.returnNames('ENTER PRESSED', 0, 8), 24, true);
		pressEnter.animation.play('idle');
		pressEnter.scale.x = 0.8;
		pressEnter.scale.y = 0.8;
		pressEnter.updateHitbox();
		pressEnter.screenCenter(FlxAxes.X);
		pressEnter.y = FlxG.height * 0.85;
		add(pressEnter);

		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

        var rawText:String = Assets.getText('assets/intro.txt');
        lines = rawText.split('\n').map(line -> line.split('-'));

        var rnd:FlxRandom = new FlxRandom();
        var firstLine = lines[rnd.int(0, lines.length - 1)];
        upperTxt = firstLine[0];
        lowerTxt = firstLine[1];

		for (i in 0...3)
		{
            var line = new AnimatedBoldFont();
            textField.push(line);
            add(line);
        }

        whiteFlash = new FlxSprite();
        whiteFlash.makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
        whiteFlash.visible = false;
        add(whiteFlash);

		Conductor.setMusic('menu', 102);
		TransitionManager.fadeOut();
    }

	override public function destroy():Void
	{
		super.destroy();
		isAlive = false;
	}

	override public function update(elapsed:Float):Void
	{
        super.update(elapsed);
		Conductor.update();

        for (i in 0...textField.length) {
            var t = textField[i];
            if (t != null) {
                t.x = (FlxG.width - t.width) / 2;
                t.y = (t.height * 5) + ((t.height + 30) * i);
            }
        }

		whiteFlash.alpha -= 1 * elapsed;

		if (!canPress)
			return;

		if (FlxG.keys.justPressed.ENTER)
		{
			var sfx = new FlxSound();
			sfx.loadEmbedded(Directories.sounds('confirm-menu'), false, true);
			sfx.play();

			new FlxTimer().start((sfx.length / 1000), function(timer:FlxTimer)
			{
				TransitionManager.fadeIn(PlayState.new);
			});

			whiteFlash.alpha += 0.25;
			pressEnter.animation.play('pressed');
			pressEnter.updateHitbox();
			pressEnter.screenCenter(FlxAxes.X);
			canPress = false;
		}
	}

	public static function beatHit():Void
	{
		if ((Conductor.curBeat + 1) % 2 == 0)
			gf.playAnim('rightBop');
		else
			gf.playAnim('leftBop');

		logo.animation.play('idle', true);

		switch (Conductor.curBeat)
		{
            case 0: setTextField(0, 'yo');
            case 2: setTextField(1, 'welcome');
            case 4:
                resetTextFields();
                setTextField(0, upperTxt);
            case 7: setTextField(1, lowerTxt);
            case 8:
                resetTextFields();

                var rnd:FlxRandom = new FlxRandom();
                var secondLine = lines[rnd.int(0, lines.length - 1)];
                upperTxt = secondLine[0];
                lowerTxt = secondLine[1];
                
                setTextField(0, upperTxt);
            case 11: setTextField(1, lowerTxt);
            case 12:
                resetTextFields();
                setTextField(0, 'friday');
            case 13: setTextField(1, 'night');
            case 14: setTextField(2, 'funkin');
            case 15:
                resetTextFields();
                setTextField(1, 'logo');
            case 16:
				if (textField.length > 0)
				{
					for (i in 0...textField.length)
					{
						if (textField[i] != null)
						{
							textField[i].destroy();
							textField[i] = null;
						}
					}
				}

				whiteFlash.alpha = 1;
                whiteFlash.visible = true;
				if (bg != null)
				{
					bg.destroy();
					bg = null;
				}

				canPress = true;
		}
	}

	static function setTextField(index:Int, msg:String):Void
	{
		if (textField[index] != null && textField[index].text != msg)
            textField[index].setText(msg);
    }

	static function resetTextFields():Void
	{
		for (line in textField)
		{
			if (line != null)
				line.setText('');
		}
	}
}