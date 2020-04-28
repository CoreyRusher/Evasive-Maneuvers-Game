package timer;

/**
	Imports
**/
import flixel.text.FlxText;
import flixel.FlxObject;

class Timer extends FlxObject {
    
    /**
	    Variables
    **/
    public var timer:Float;
    
    /**
	    Constructor
    **/
    public function new(?X = 0, ?Y = 0, ?Width = 32, ?Height = 32){
        super(X, Y);
    }

    /**
	    Function to create the timer text.
    **/
    public function createTimer(){
        var timeText = new FlxText(0, 0, "Time: " + timer, 32);
        return timeText;
    }
    
    /**
	    Function to change the time value in the timer.
    **/
    public function setTimer(newTime){
        timer = newTime;
    }
}