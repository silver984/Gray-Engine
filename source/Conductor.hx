package;

import flixel.FlxG;
import flixel.sound.FlxSound;
import states.TitleState;

class Conductor {
    public var curBeat:Int = 0;
    var lastBeat:Int = -1;
    var beat:Float;
    var inst:FlxSound;

    var titleState:TitleState;

    public function new(inst:FlxSound, bpm:Float = 100) {
        if (bpm <= 0) bpm = 100;
        this.inst = inst;
        beat = 60 / bpm;
    }

    public function update():Void {
        if (inst != null) {
            var songPos:Float = inst.time / 1000;
            curBeat = Math.floor(songPos / beat);

            if (curBeat != lastBeat) {
                beatHit();
                lastBeat = curBeat;
            }
        }
    }

    public function beatHit():Void {
        // Get the current state dynamically
        var state = FlxG.state;
        if (Std.isOfType(state, TitleState)) {
            var titleState = cast(state, TitleState);
            titleState.beatHit();
        }
        trace('curBeat: ${curBeat}');
    }
}