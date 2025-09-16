package;

import flixel.FlxG;
import flixel.sound.FlxSound;
import states.TitleState;

class Conductor {
    public static var curBeat:Int = 0;
    public static var beatTime:Float;
    public static var music:FlxSound;
    public static var bpm:Float;
    static var lastBeat:Int = -1;
    static var beat:Float;

    public static function setMusic(file:String, _bpm:Float = 100)
    {
        if (_bpm <= 0) _bpm = 100;
        bpm = _bpm;

        if (FlxG.sound.music != null && FlxG.sound.music.playing) {
			FlxG.sound.music.stop();
            FlxG.sound.music.volume = 1;
        }
		FlxG.sound.playMusic(Directories.music(file), 1, false);

        music = FlxG.sound.music;
    }

    public static function update():Void
    {
        if (bpm <= 0) bpm = 100;
        beat = 60 / bpm;

        if (music != null && music.playing) {
            var songPos:Float = music.time / 1000;
            curBeat = Math.floor(songPos / beat);

            if (curBeat != lastBeat) {
                beatHit();
                beatTime = songPos;
                lastBeat = curBeat;
            }
        }
    }

    public static function beatHit():Void
    {
        if (TitleState.isAlive)
            TitleState.beatHit();

        trace('curBeat: ${curBeat}, beatTime: ${beatTime} seconds');
    }
}
