package objects;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import haxe.ds.StringMap;

class Character extends FlxSpriteGroup {
	public var name:String;
    var animSprites:StringMap<FlxSprite>;
    var currentAnim:String;

    public function new(name:String, x:Float = 0, y:Float = 0) {
        super(x, y);
        this.name = name;
        animSprites = new StringMap<FlxSprite>();
    }

    public function addAnim(file:String, animName:String, xmlPrefix:String, start:Int, end:Int, fps:Int = 24, loop:Bool = false) {
        var sprite = new FlxSprite();
        sprite.antialiasing = true;

        var atlas = FlxAtlasFrames.fromSparrow(
		Directories.images('characters/${name}/${file}'), Directories.images('characters/${name}/${file}', 'xml')
        );
        sprite.frames = atlas;

		sprite.animation.addByNames(animName, Util.returnNames(xmlPrefix, start, end), fps, loop);

        sprite.visible = false;

        add(sprite);
        animSprites.set(animName, sprite);

        if (currentAnim == null)
            playAnim(animName);
    }

    public function playAnim(animName:String) {
        if (!animSprites.exists(animName)) return;

        if (currentAnim != null && animSprites.exists(currentAnim)) {
            animSprites.get(currentAnim).visible = false;
            animSprites.get(currentAnim).animation.stop();
        }

        var sprite = animSprites.get(animName);
        sprite.visible = true;
        sprite.animation.play(animName, true);

        currentAnim = animName;
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        for (sprite in animSprites) {
            if (sprite.visible) sprite.update(elapsed);
        }
    }
}