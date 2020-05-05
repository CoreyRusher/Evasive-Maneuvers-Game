package entities.powerups;

/**
	Imports
**/
import flixel.util.FlxColor;
import flixel.FlxSprite;

class ExtraHit extends FlxSprite {
    
    /**
        Variables
    **/
    public static var WIDTH(default, never):Int = 10;
    public static var HEIGHT(default, never):Int = 10;
    
    /**
	    Constructor
    **/
    public function new(?X:Float = 0, ?Y:Float = 0) {
        super(X, Y);
        makeGraphic(WIDTH, HEIGHT, FlxColor.WHITE);
    }
}   