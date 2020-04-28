package entities.projectiles;

/**
	Imports
**/
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Fireball extends FlxSprite {
    /**
	    Constructor
    **/
    public function new(?X:Float = 0, ?Y:Float = 0) {
        super(X, Y);
        makeGraphic(10, 10, FlxColor.RED);

        velocity.y = 150;
    }
}   
