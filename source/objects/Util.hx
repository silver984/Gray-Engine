package objects;

class Util {
    public static function returnNames(prefix:String, start:Int = 0, end:Int = 1, padding:Int = 4):Array<String> {
        var frameNames:Array<String> = [];
        for (i in start...end+1)
            frameNames.push(prefix + StringTools.lpad(i + '', '0', padding));
        return frameNames;
    }
}