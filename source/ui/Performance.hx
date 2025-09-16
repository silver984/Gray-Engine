package ui;

import flixel.FlxG;
import flixel.math.FlxMath;
import openfl.display.Sprite;
import openfl.filters.DropShadowFilter;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;

class Performance extends Sprite
{
	var fps:Float;
	var txt:TextField;
	var elapsedFrames:Int = 0;

	public function new(x:Float = 2, y:Float = 2)
	{
		super();
		visible = true;

		txt = new TextField();
		txt.x = x;
		txt.y = y;
		txt.selectable = false;
		txt.mouseEnabled = false;
		txt.defaultTextFormat = new TextFormat(Directories.fonts('vcr'), 12);
		txt.autoSize = TextFieldAutoSize.LEFT;

		var borderSize:Float = 1;
		txt.filters = [
			new DropShadowFilter(borderSize, 0, 0, 1, 0, 0),
			new DropShadowFilter(borderSize, 90, 0, 1, 0, 0),
			new DropShadowFilter(borderSize, 180, 0, 1, 0, 0),
			new DropShadowFilter(borderSize, 270, 0, 1, 0, 0)
		];

		addChild(txt);
	}

	override function __enterFrame(deltaTime:Int):Void
	{
		elapsedFrames++;
		var totalFrames:Float = FlxMath.roundDecimal(1 / FlxG.elapsed, 0);
		if (elapsedFrames >= totalFrames) {
			fps = totalFrames;
			elapsedFrames = 0;
		}

		var mem:Null<Float> = getMemory();
		var extension:String = '';
		if (mem != null)
			extension = '\nMEMORY: ${FlxMath.roundDecimal(mem / 1024 / 1024, 0)}MB';

		txt.text = '${fps}FPS${extension}';

		if (fps <= 30)
			txt.textColor = 0xFF0000;
		else
			txt.textColor = 0xFFFFFF;
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