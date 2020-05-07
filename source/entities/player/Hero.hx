package entities.player;

/**
	Imports
**/
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxObject;

class Hero extends FlxSprite {
    
    /**
	    Variables
    **/
    public static var WIDTH(default, never):Int = 32;
    public static var HEIGHT(default, never):Int = 32;
    public static var GRAVITY(default, never):Float = 300;
    public static var TERMINAL_VELOCITY(default, never):Float = 600;
    public static var X_SPEED(default, never):Float = 200;
    public static var X_OFFSET(default, never):Int = 7;
    public static var JUMP_SPEED(default, never):Float = -200;
    
    public var lifeCounter = 1;

    private var leftInput:Bool = false;
    private var rightInput:Bool = false;
    private var jumpInput:Bool = false;
    
    public static var STAND_ANIMATION:String = "stand";
    public static var WALK_ANIMATION:String = "walk";


    /**
	    Constructor
    **/
    public function new(?X:Float = 304, ?Y:Float = 416) {
        super(X, Y);
        makeGraphic(WIDTH, HEIGHT, FlxColor.WHITE);

        loadGraphic(AssetPaths.Hero__png, true, WIDTH, HEIGHT);
        animation.add(STAND_ANIMATION, [0], 0, false);
        animation.add(WALK_ANIMATION, [1, 0, 2, 0], 5);
        animation.play(STAND_ANIMATION);
        width = 18;
        height = HEIGHT;
        offset.x = X_OFFSET;

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
        if (direction < 0) {
            flipX = true;
            animation.play(WALK_ANIMATION);
        } else if (direction > 0) {
            flipX = false;
            animation.play(WALK_ANIMATION);
        } else {
            animation.play(STAND_ANIMATION);
        }
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
        if (leftPressed && this.x >= 0) {
            finalDirection--;
        }
        if (rightPressed && this.x + WIDTH <= FlxG.width) {
            finalDirection++;
        }
        return finalDirection;
    }

    /**
        Simple jump function.
    **/
    private function jump(jumpJustPressed:Bool):Void {
        if (jumpJustPressed && this.isTouching(FlxObject.DOWN)) {
            velocity.y = JUMP_SPEED; 
        }
    }
   
}
