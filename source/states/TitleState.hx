package states;

import Conductor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxRandom;
import flixel.util.FlxColor;
import objects.AnimatedBoldFont;
import objects.Character;
import openfl.utils.Assets;

class TitleState extends FlxState {
    var conductor:Conductor;
    var dir:Directories;
    var textField:Array<AnimatedBoldFont> = [];
    var lines:Array<Array<String>>;
    var upperTxt:String;
    var lowerTxt:String;
    var processedBeats:Map<Int, Bool> = new Map();

    // flash for when beat drops
    var whiteFlash:FlxSprite;
    var hasFlashed:Bool = false;

    var gf:Character;
    
    public function new() {
        super();
    }

    override function create() {
        var rawText:String = Assets.getText('assets/intro.txt');
        lines = rawText.split('\n').map(line -> line.split('-'));

        var rnd:FlxRandom = new FlxRandom();
        var firstLine = lines[rnd.int(0, lines.length - 1)];
        upperTxt = firstLine[0];
        lowerTxt = firstLine[1];

        for (i in 0...3) {
            var line = new AnimatedBoldFont();
            textField.push(line);
            add(line);
        }

        gf = new Character('girlfriend-title');
        gf.addAnim('idle', 'leftBop', 'left-idle', 0, 14, 12);
        gf.addAnim('idle', 'rightBop', 'right-idle', 15, 29, 12);
        gf.x = (FlxG.width / 2) - (gf.width / 2);
        gf.y = (FlxG.height / 2) - (gf.height / 2);
        add(gf);
        gf.kill();

        whiteFlash = new FlxSprite();
        whiteFlash.makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
        whiteFlash.visible = false;
        add(whiteFlash);

        var bgMusic = FlxG.sound.play(dir.music('menu'), 1, true);
        conductor = new Conductor(bgMusic, 102);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        conductor.update();

        for (i in 0...textField.length) {
            var t = textField[i];
            if (t != null) {
                t.x = (FlxG.width - t.width) / 2;
                t.y = (t.height * 5) + ((t.height + 30) * i);
            }
        }
        
        fadeWhiteFlash(elapsed);
    }

    public function beatHit():Void {
        handleSteps(conductor.curBeat);

        if ((conductor.curBeat + 1) % 2 == 0)
            gf.playAnim("rightBop");
        else
            gf.playAnim("leftBop");
    }

    function handleSteps(beat:Int):Void {
        if (processedBeats.exists(beat)) return; // already handled this step

        switch(beat) {
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
                for (i in 0...textField.length) {
                    if (textField[i] != null) {
                        textField[i].destroy();
                        textField[i] = null;
                    }
                }
                whiteFlash.visible = true;
                hasFlashed = true;
                gf.revive();
        }

        processedBeats.set(beat, true);
    }

    function setTextField(index:Int, msg:String):Void {
        if (textField[index] != null && textField[index].text != msg)
            textField[index].setText(msg);
    }

    function resetTextFields():Void {
        for (line in textField)
            if (line != null) line.setText('');
    }

    function fadeWhiteFlash(elapsed:Float):Void {
        if (hasFlashed && whiteFlash != null) {
            whiteFlash.alpha -= elapsed;
            if (whiteFlash.alpha <= 0) {
                whiteFlash.destroy();
                whiteFlash = null;
            }
        }
    }
}