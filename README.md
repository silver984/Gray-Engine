# Gray Engine
A [Friday Night Funkin'](https://ninja-muffin24.itch.io/funkin) remake being made from the ground up. Currently in its EXTREMELY early development, feel free to contribute!

_Go to Friday Night Funkin's repository [here!](https://github.com/FunkinCrew/Funkin)_

## How to compile
1. **Download Haxe:** [Haxe v4.3.7](https://haxe.org/download/list/)

2. **Install Lime and HaxeFlixel**
```
haxelib install lime 8.2.2
haxelib install flixel 6.1.0
haxelib run lime setup
haxelib run lime setup flixel
```
3. **Install OpenFL**
```
haxelib install openfl 9.4.1
```
---
### How to build for Windows?
Run the `.bat` file provided or simply choose the following:
```
haxelib run lime build windows # option 1: build the game
haxelib run lime test windows # option 2: build and run for testing/debugging
```
---
### How to build for other platforms?
The source code is currently only being tested in Windows 10. Contributions are welcome for Linux, macOS, HTML5, or even Android builds!