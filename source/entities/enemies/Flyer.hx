package entities.enemies;

/**
	Imports
**/
import flixel.group.FlxGroup.FlxTypedGroup;
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
    public static var FIREBALL_DELAY(default, never):Float = 1;
    public var INITIALMOVE = false;
    public var fireballCount = 20;
    public var fireballTimer:Float = FIREBALL_DELAY;
    public var fireballs:FlxTypedGroup<Fireball>;

    /**
	    Constructor
    **/
    public function new(?X:Float = 320, ?Y:Float = -32, stateFireballs:FlxTypedGroup<Fireball>) {
        super(X, Y);
        makeGraphic(WIDTH, HEIGHT, FlxColor.WHITE);
        loadGraphic(AssetPaths.FLYERPIC__png, true, WIDTH, HEIGHT);
        this.fireballs = stateFireballs;
    }

    /**
		Function handles flyer attacks.
	**/
    public function shootFireball(){
        var fireball = new Fireball(this.x + WIDTH / 2, this.y + HEIGHT);
		fireballs.add(fireball);
    }    

    /**
	    Override of the update function.
    **/
    override function update(elapsed:Float) {
        super.update(elapsed);
        
        fireballTimer -= elapsed;
        if (fireballTimer < 0){
            shootFireball();
            fireballCount -= 1;
            fireballTimer = FIREBALL_DELAY;
        }

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