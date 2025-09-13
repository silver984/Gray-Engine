package;

class Directories {
    public function new() {}

    public function fonts(file:String, ext:String = 'ttf'):String {
        return 'assets/fonts/${file}.${ext}';
    }

    public function music(file:String, ext:String = 'ogg'):String {
        return 'assets/music/${file}.${ext}';
    }

    public function images(file:String, ext:String = 'png'):String {
        return 'assets/images/${file}.${ext}';
    }

    public function character(name:String, anim:String, ext:String = 'png'):String {
        return 'assets/images/characters/${name}/${anim}.${ext}';
    }
}