package objects;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;

class AnimatedBoldFont extends FlxSpriteGroup {
    public var text:String = '';

    public function new(text:String = '', x:Float = 0, y:Float = 0) {
		super(x, y);
        setText(text);
    }

    public function setText(newText:String = ''):Void {
        text = newText;

        // clear existing letters
        clear();

        var currentX:Float = 0;

        for (i in 0...text.length) {
            var letter = String.fromCharCode(text.charCodeAt(i));
            var upper = letter.toUpperCase();

            // skip anything not A–Z
            if (upper.charCodeAt(0) < 65 || upper.charCodeAt(0) > 90) {
                currentX += 40; // give gap
                continue;
            }

            var spr = new FlxSprite(currentX, 0);
            spr.frames = FlxAtlasFrames.fromSparrow(
			Directories.fonts('animated/regular', 'png'), Directories.fonts('animated/regular', 'xml')
            );

            spr.animation.addByPrefix(upper, '${upper} bold', 24, true);
            spr.animation.play(upper);

            spr.antialiasing = true;
            
            add(spr);
            currentX += spr.frameWidth + 2;
        }
    }
}