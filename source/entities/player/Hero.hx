package entities.player;

/**
	Imports
**/
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Hero extends FlxSprite {
    
    /**
	    Variables
    **/
    public static var WIDTH(default, never):Int = 32;
    public static var HEIGHT(default, never):Int = 32;
    public static var GRAVITY(default, never):Float = 300;
    public static var TERMINAL_VELOCITY(default, never):Float = 600;
    public static var X_SPEED(default, never):Float = 200;
    public static var JUMP_SPEED(default, never):Float = -200;
    private var leftInput:Bool = false;
    private var rightInput:Bool = false;
    private var jumpInput:Bool = false;

    /**
	    Constructor
    **/
    public function new(?X:Float = 304, ?Y:Float = 416) {
        super(X, Y);
        makeGraphic(WIDTH, HEIGHT, FlxColor.WHITE);

        // Set up "gravity" (constant acceleration) and "terminal velocity" (max fall speed)
        acceleration.y = GRAVITY;
        maxVelocity.y = TERMINAL_VELOCITY;
    }

    /**
	    Overrides the update function.
    **/
    override function update(elapsed:Float) {
        // Set up nicer input-handling for movement.
        gatherInputs();

        // Horizontal movement
        var direction:Int = getMoveDirectionCoefficient(leftInput, rightInput);
        velocity.x = X_SPEED * direction;
       
        // Jump
        jump(jumpInput);

        super.update(elapsed);
    }

    /**
        Function to gather inputs.
    **/
    private function gatherInputs():Void {
        leftInput = FlxG.keys.pressed.A;
        rightInput = FlxG.keys.pressed.D;

        jumpInput = FlxG.keys.justPressed.SPACE;
    }

    /**
        Uses player input to determine if movement should occur in a positive or negative X 
        direction. If no movement inputs are detected, 0 is returned instead.
    **/
    private function getMoveDirectionCoefficient(leftPressed:Bool, rightPressed:Bool):Int {
        var finalDirection:Int = 0;        
        if (leftPressed) {
            finalDirection--;
        }
        if (rightPressed) {
            finalDirection++;
        }
        return finalDirection;
    }

    /**
        Simple jump function.
    **/
    private function jump(jumpJustPressed:Bool):Void {
        if (jumpJustPressed) {
            velocity.y = JUMP_SPEED;
        }
    }
   
}
