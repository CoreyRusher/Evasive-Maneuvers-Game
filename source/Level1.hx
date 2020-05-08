package;

/**
	Imports
**/
import entities.powerups.ExtraHit;
import flixel.FlxBasic;
import flixel.text.FlxText;
import timer.Timer;
import entities.projectiles.Fireball;
import entities.powerups.Speed;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import entities.player.Hero;
import entities.terrain.Wall;
import entities.enemies.Flyer;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import entities.enemies.Grounder;

class Level1 extends FlxState
{
	
	/**
		Variables
	**/
	private static var WALL_COUNT(default, never) = 20;
	private static var FIRSTWALL_START_X(default, never) = 0;
	private static var FIRSTWALL_START_Y(default, never) = 448;

	private var FLYER_COUNT = 3;
	private var flyerCounter = 3;

	private var healthPowerup:ExtraHit;
	private var speedPowerup:Speed;
	private var powerupCounter = 1;

	private var hero:Hero;
	private var walls:FlxTypedGroup<Wall>;
	private var flyers:FlxTypedGroup<Flyer>;
	private var grounders:FlxTypedGroup<Grounder>;

	private var GROUNDER_COUNT = 1;
	private var grounderCounter = 1;

	private var timer = 60.0;
	private var timerText:FlxText;
	private var timerObject:Timer;

	private var FIREBALL:Fireball;
	private var fireballs:FlxTypedGroup<Fireball>;

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

		fireballs = new FlxTypedGroup<Fireball>();
		initializeWalls();
		initializeFlyers();
		initializeGrounders();
		add(fireballs);
		
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

	private function initializeFlyers(){
		flyers = new FlxTypedGroup<Flyer>();
		for (i in 0...FLYER_COUNT) {
			var flyer = new Flyer(320, -32, fireballs);
			flyer.exists = false;
			flyers.add(flyer);
		}
		var flyer1 = flyers.getFirstAvailable();
		flyer1.exists = true;
		flyerCounter -= 1;
		add(flyers);
	}

	private function initializeGrounders(){
		grounders = new FlxTypedGroup<Grounder>();
		for (i in 0...GROUNDER_COUNT) {
			var grounder = new Grounder();
			grounder.exists = false;
			grounders.add(grounder);
		}
		add(grounders);
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
		
		// Resolve flyer collision.
		FlxG.overlap(hero, flyers, resolveHeroFlyerOverlap);

		// Resolve grounder collision.
		FlxG.overlap(hero, grounders, resolveHeroGrounderOverlap);

		//Resolve speed powerup collision.
		FlxG.overlap(hero, speedPowerup, resolveHeroSpeedPowerupOverlap);

		//Resolve health powerup collision.
		FlxG.overlap(hero, healthPowerup, resolveHeroHealthPowerupOverlap);
		
		//Update the timer.
		timer -= elapsed;
		timerText.text = "Time: " + Std.int(timer);

		//Timed spawns
		if (timer <= 45 && flyerCounter == 2){
			flyerCounter -= 1;
			var flyer2 = flyers.getFirstAvailable();
			flyer2.exists = true;	
		}
		if (timer <= 30 && grounderCounter == 1){
			grounderCounter -= 1;
			var grounder1 = grounders.getFirstAvailable();
			grounder1.spawnSide = 0;
			grounder1.exists = true;
		}
		
		if (timer <= 15 && flyerCounter == 1){
			flyerCounter -= 1;
			var flyer3 = flyers.getFirstAvailable();
			flyer3.exists = true;
		}	

		if (timer <= 0){
			FlxG.switchState(new Level1AdvanceState());
		}

		//Powerup Spawn
		if (timer <= 30 && powerupCounter == 1){
			powerupCounter -= 1;
			speedPowerup = new Speed(500,438);
			add(speedPowerup);
		}
	}

	/**
		Function called when an overlap between hero and fireball is detected.
	**/
	private function resolveHeroFireballOverlap(hero:Hero, fireball:Fireball) {
		if (hero.lifeCounter > 1){
			fireball.kill();
			hero.lifeCounter -= 1;
		}
		else{
		fireball.kill();
		hero.kill();
		FlxG.switchState(new FailState());
		
		#if debug
		//trace("Hero and Fireball collided!");
		#end
		}
	}

	private function resolveHeroFlyerOverlap(hero:Hero, flyer:Flyer) {
		if (hero.lifeCounter > 1){
			flyer.kill();
			hero.lifeCounter -= 1;
		}
		else{
		flyer.kill();
		hero.kill();
		FlxG.switchState(new FailState());
		}
		#if debug
		//trace("Hero and Flyer collided!");
		#end
	}

	private function resolveHeroGrounderOverlap(hero:Hero, grounder:Grounder) {
		if (hero.lifeCounter > 1){
			if (grounder.spawnSide == 0){
			hero.lifeCounter -= 1;
			grounder.x = -32;
			}
			if (grounder.spawnSide == 1){
				hero.lifeCounter -= 1;
				grounder.x = 642;
			}	
		}
		else{
		grounder.kill();
		hero.kill();
		FlxG.switchState(new FailState());

		#if debug
		//trace("Hero and Grounder collided!");
		#end
		}
	}

	private function resolveHeroSpeedPowerupOverlap(hero:Hero, speedPowerup:Speed){
		speedPowerup.kill();
		hero.speedStat = 300;
	}

	private function resolveHeroHealthPowerupOverlap(hero:Hero, healthPowerup:ExtraHit){
		healthPowerup.kill();
		hero.lifeCounter += 1;
	}
}
