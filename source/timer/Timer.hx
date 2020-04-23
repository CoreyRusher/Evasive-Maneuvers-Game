package timer;

import flixel.text.FlxText;
import flixel.FlxObject;

class Timer extends FlxObject {
    
    public var timer:Float;
    
    public function new(?X = 0, ?Y = 0, ?Width = 32, ?Height = 32){
        super(X, Y);
    }

    public function createTimer(){
        var timeText = new FlxText(0, 0, "Time: " + timer, 32);
        return timeText;
    }
    
    public function setTimer(newTime){
        timer = newTime;
    }
}