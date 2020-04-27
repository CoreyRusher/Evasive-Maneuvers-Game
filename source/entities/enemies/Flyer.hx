package entities.enemies;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import entities.projectiles.Fireball;

class Flyer extends FlxSprite {
    public static var WIDTH(default, never):Int = 32;
    public static var HEIGHT(default, never):Int = 32;
    public static var HOVERHEIGHT = 150;
   
    public function new(?X:Float = 320, ?Y:Float = -32) {
        super(X, Y);
        makeGraphic(WIDTH, HEIGHT, FlxColor.WHITE);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        if (this.y < HOVERHEIGHT){
            velocity.y = 100;
        }
        if (this.y >= HOVERHEIGHT){
            velocity.y = 0;
            this.x += 100;
            if (this.x + WIDTH >= FlxG.width && velocity.x >= 0){
                velocity.x = -100;
            }
            if (this.x <= 0 && velocity.x <= 0){
                velocity.x = 100;
            }
        }

    }

}      