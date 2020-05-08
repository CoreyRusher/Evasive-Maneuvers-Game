package;

/**
	Imports
**/
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	/**
		Constructor
	**/
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, Level1));
	}
}
