package ui;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.typeLimit.NextState;

class TransitionManager {
    public static function fadeIn(newState:NextState, fadeMusic:Bool = false) {
        var screen = new FlxSprite();
        screen.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        screen.alpha = 0;
        FlxG.state.add(screen);
        FlxTween.tween(screen, { alpha: 1 }, 0.5, {
            onComplete: function(tween:FlxTween) {
                FlxG.switchState(newState);
            }
        });

        if (fadeMusic)
            FlxTween.tween(FlxG.sound.music, { volume: 0 }, 0.25);
    }

    public static function fadeOut():Void {
        var screen = new FlxSprite();
        screen.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        screen.alpha = 1;
        FlxG.state.add(screen);
        FlxTween.tween(screen, { alpha: 0 }, 0.5);
    }
}