package;

/**
	Imports
**/
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxG;

class Level1AdvanceState extends FlxState
{
    /**
	    Create Function.
    **/
    override public function create():Void
        {
            super.create();
            var text = new FlxText(155, 180, "You Win Round 1!", 32);
            add(text);
            var text2 = new FlxText(80, 300, "Press Space to move on.", 32);
            add(text2);
        }
        
    /**
	    Override of the update function.
    **/
    override public function update(elapsed:Float):Void
        {
            if (FlxG.keys.justPressed.SPACE){
                FlxG.switchState(new Level1());
            }
        }    
}