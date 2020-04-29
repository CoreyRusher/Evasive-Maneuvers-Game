package entities.enemies;

/**
	Imports
**/
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import entities.projectiles.Fireball;

class Flyer extends FlxSprite {
    
    /**
		Variables
	**/
    public static var WIDTH(default, never):Int = 32;
    public static var HEIGHT(default, never):Int = 32;
    public static var HOVERHEIGHT = 150;
    public var INITIALMOVE = false;
    public var fireballCount = 10;

    /**
	    Constructor
    **/
    public function new(?X:Float = 320, ?Y:Float = -32) {
        super(X, Y);
        makeGraphic(WIDTH, HEIGHT, FlxColor.WHITE);
    }

    /**
		Function handles flyer attacks.
	**/
    public function shootFireball(){
        var fireball = new Fireball(this.x + WIDTH / 2, this.y + HEIGHT);
        FlxG.state.add(fireball);
        }    
    }
    
    /**
	    Override of the update function.
    **/
    override function update(elapsed:Float) {
        super.update(elapsed);
    
        /**
		    Handling Flyer movement
	    **/
        if (this.y < HOVERHEIGHT){
            velocity.y = 200;
        }
        if (this.y >= HOVERHEIGHT){
            
            if (INITIALMOVE == false){
            velocity.y = 0;
            velocity.x = 250;
            INITIALMOVE = true;
            }
            else{
                if (this.x + WIDTH >= FlxG.width && velocity.x >= 0){
                    velocity.x = -250;
                }
                if (this.x <= 0 && velocity.x <= 0){
                    velocity.x = 250;
                }
            }    
        }
    }
}      