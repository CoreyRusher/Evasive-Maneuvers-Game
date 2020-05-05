package entities.enemies;

/**
	Imports
**/
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import entities.projectiles.Fireball;

class Grounder extends FlxSprite {
    
    /**
		Variables
	**/
    public static var WIDTH(default, never):Int = 32;
    public static var HEIGHT(default, never):Int = 32;
    public static var SPAWNHEIGHT = 416;
    public var INITIALMOVE = false;
    public var fireballCount = 10;

    /**
	    Constructor
    **/
    public function new(?X:Float = -32, ?Y:Float = 416) {
        super(X, Y);
        makeGraphic(WIDTH, HEIGHT, FlxColor.WHITE);
        loadGraphic(AssetPaths.GROUNDERPIC__png, true, WIDTH, HEIGHT);
    }

    /**
		Function handles GROUNDER attacks.
	**/
    public function shootFireball(){
        var fireball = new Fireball(this.x + WIDTH / 2, this.y + HEIGHT);
        FlxG.state.add(fireball);
        }    

    /**
	    Override of the update function.
    **/
    override function update(elapsed:Float) {
        super.update(elapsed);
    
        /**
		    Handling Grounder movement
	    **/
            if (this.x < 0){
            velocity.x = 200;
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