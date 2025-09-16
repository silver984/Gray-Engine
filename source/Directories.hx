package;

class Directories {
	public static var root:String = 'assets';

	public static function fonts(file:String, ext:String = 'ttf'):String
	{
		return '${root}/fonts/${file}.${ext}';
    }

	public static function music(file:String, ext:String = 'ogg'):String
	{
		return '${root}/music/${file}.${ext}';
    }

	public static function sounds(file:String, ext:String = 'ogg'):String
	{
		return '${root}/sounds/${file}.${ext}';
	}

	public static function images(file:String, ext:String = 'png'):String
	{
		return '${root}/images/${file}.${ext}';
    }
}