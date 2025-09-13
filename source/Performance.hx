package;

import Directories;
import flixel.math.FlxMath;
import openfl.display.Sprite;
import openfl.filters.DropShadowFilter;
import openfl.text.TextField;
import openfl.text.TextFormat;

class Performance extends Sprite
{
    var dir:Directories;
	var fps:Int;
	var txt:TextField;
	var fpsCount:Int = 0;
	var elapsed:Float = 0;

	public function new(x:Float = 5, y:Float = 5)
	{
		super();
		visible = true;

		txt = new TextField();
		txt.x = x;
		txt.y = y;
		txt.selectable = false;
		txt.mouseEnabled = false;
		txt.defaultTextFormat = new TextFormat(dir.fonts('vcr'), 12, 0xFFFFFF);

		var borderSize:Float = 1;
		txt.filters = [
			new DropShadowFilter(borderSize, 0, 0, 1, 0, 0),
			new DropShadowFilter(borderSize, 90, 0, 1, 0, 0),
			new DropShadowFilter(borderSize, 180, 0, 1, 0, 0),
			new DropShadowFilter(borderSize, 270, 0, 1, 0, 0)
		];

		addChild(txt);
	}

	override function __enterFrame(deltaTime:Float):Void
	{
		fpsCount++;
		elapsed += deltaTime;

		if (elapsed >= 1000)
		{
			fps = fpsCount;
			fpsCount = 0;
			elapsed = 0;
            var mem:Null<Float> = getMemory();
            
            var extension:String = '';
            if (mem != null)
                extension = '\nMEM: ${FlxMath.roundDecimal(mem / 1024 / 1024, 2)}MB';

            txt.text = 'FPS: ${fps}${extension}';
		}
	}

    function getMemory():Null<Float>
	{
		#if cpp
		return cpp.vm.Gc.memInfo64(cpp.vm.Gc.MEM_INFO_USAGE);
		#elseif hl
		return hl.Gc.stats().currentMemory;
		#elseif (js && html5)
		if (untyped __js__("(window.performance && window.performance.memory)"))
			return untyped __js__("window.performance.memory.usedJSHeapSize");
		#end

		return null;
	}
}