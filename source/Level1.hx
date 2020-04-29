package;

/**
	Imports
**/
import flixel.FlxBasic;
import flixel.text.FlxText;
import timer.Timer;
import entities.projectiles.Fireball;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import entities.player.Hero;
import entities.terrain.Wall;
import entities.enemies.Flyer;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;

class Level1 extends FlxState
{
	
	/**
		Variables
	**/
	private static var WALL_COUNT(default, never) = 20;
	private static var FIRSTWALL_START_X(default, never) = 0;
	private static var FIRSTWALL_START_Y(default, never) = 448;

	private static var FIREBALL_COUNT(default, never) = 10;
	private static var FIREBALL_SPAWN_BORDER(default, never) = 50;

	private var FLYER_COUNT = 3;
	private var FLYERSPAWN = true;

	private var hero:Hero;
	private var walls:FlxTypedGroup<Wall>;
	private var fireballs:FlxTypedGroup<Fireball>;
	private var flyers:FlxTypedGroup<Flyer>;

	private var flyer1:Flyer;
	private var flyer2:Flyer;
	private var flyer2:Flyer;

	private var timer = 60.0;
	private var timerText:FlxText;
	private var timerObject:Timer;

	private var _backdrop:FlxBackdrop;
	
	/**
		Create function.
	**/
	override public function create():Void
	{
		super.create();

		//Create the level scenery
		_backdrop = new FlxBackdrop(AssetPaths.level1__png);
		add(_backdrop);
		
		//Create the player.
		hero = new Hero();
		add(hero);

		//Create the timer.
		timerObject = new Timer();
		timerObject.setTimer(timer);
		timerText = timerObject.createTimer();
		add(timerText);

		initializeWalls();
		initializeFireballs();
		initializeFlyers();
	}

	/**
		Function spawns platforms for player to play on.
	**/
	private function initializeWalls() {
		walls = new FlxTypedGroup<Wall>();

		for (i in 0...WALL_COUNT) {
			var x1:Float = FIRSTWALL_START_X + (i * Wall.WIDTH);
			var y1:Float = FIRSTWALL_START_Y;
			var wall1:Wall = new Wall(x1, y1);
			walls.add(wall1);
		}
		add(walls);
	}


	/**
		Function initializes fireballs.
	**/
	private function initializeFireballs() {
		fireballs = new FlxTypedGroup<Fireball>();

		for (i in 0...FIREBALL_COUNT) {
			var x:Float = FlxG.random.int(FIREBALL_SPAWN_BORDER, 
				FlxG.width - FIREBALL_SPAWN_BORDER);
			var y:Float = FlxG.random.int(FIREBALL_SPAWN_BORDER, 
				FlxG.height - FIREBALL_SPAWN_BORDER);
			var fireball = new Fireball(x, y);
			fireballs.add(fireball);
		}
		add(fireballs);
	}

	private function initializeFlyers(){
		flyers = new FlxTypedGroup<Flyer>();
		for (i in 0...FLYER_COUNT) {
			var flyer = new Flyer();
			flyers.add(flyer);
		}
		flyer1 = flyers.getFirstExisting();
		add(flyer1);
	}

    /**
		Update Function.
	**/
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		//Turns on the floor
		FlxG.collide(hero, walls);

		// Resolve fireball hit.
		FlxG.overlap(hero, fireballs, resolveHeroFireballOverlap);

		// Respawn the fireballs.
		for (fireball in fireballs) {
		    respawnFireballs(fireball);
		} 
		
		//Update the timer.
		timer -= elapsed;
		timerText.text = "Time: " + Std.int(timer);

		if (timer <= 45 && FLYER_COUNT == 2){
			FLYER_COUNT -= 1;
			flyer2 = flyers.getFirstAvailable();
			add(flyer2);		
		}
	}
	

    /**
		Function respawns fireballs.
	**/
	private function respawnFireballs(fireball:FlxObject) {
		if (fireball.y > FlxG.height) {
			fireball.y = 0 - fireball.height;
			fireball.x = FlxG.random.int(FIREBALL_SPAWN_BORDER, 
				FlxG.width - FIREBALL_SPAWN_BORDER);
		} 
	}

	/**
		Function called when an overlap between hero and fireball is detected.
	**/
	private function resolveHeroFireballOverlap(hero:Hero, fireball:Fireball) {
		fireball.kill();
		hero.kill();
		FlxG.switchState(new FailState());
		
		#if debug
		//trace("Hero and Fireball collided!");
		#end
	}

}
