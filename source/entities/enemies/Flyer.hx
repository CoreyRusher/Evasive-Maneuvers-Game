package entities.enemies;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Flyer extends FlxSprite {
    public static var WIDTH(default, never):Int = 32;
    public static var HEIGHT(default, never):Int = 32;

    public static var GRAVITY(default, never):Float = 300;
    public static var TERMINAL_VELOCITY(default, never):Float = 600;
    public static var X_SPEED(default, never):Float = 200;

    public static var JUMP_SPEED(default, never):Float = -200;

    private var leftInput:Bool = false;
    private var rightInput:Bool = false;
    private var jumpInput:Bool = false;

    public function new(?X:Float = 0, ?Y:Float = 0) {
        super(X, Y);
        makeGraphic(WIDTH, HEIGHT, FlxColor.WHITE);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}      