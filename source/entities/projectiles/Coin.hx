package entities.projectiles;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;

class Coin extends FlxSprite {
    public function new(?X:Float = 0, ?Y:Float = 0) {
        super(X, Y);
        makeGraphic(10, 10, FlxColor.YELLOW);

        velocity.y = 250;
    }
}   