package;

import entities.projectiles.Fireball;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import entities.player.Hero;
import entities.terrain.Wall;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;

class PlayState extends FlxState
{
	private static var WALL_COUNT(default, never) = 20;
	private static var FIRSTWALL_START_X(default, never) = 0;
	private static var FIRSTWALL_START_Y(default, never) = 448;

	private static var FIREBALL_COUNT(default, never) = 10;
	private static var FIREBALL_SPAWN_BORDER(default, never) = 50;

	private var hero:Hero;
	private var walls:FlxTypedGroup<Wall>;
	private var fireballs:FlxTypedGroup<Fireball>;

	private var _backdrop:FlxBackdrop;

	override public function create():Void
	{
		super.create();
		
		_backdrop = new FlxBackdrop(AssetPaths.level1__png);
		add(_backdrop);

		hero = new Hero();
		add(hero);

		initializeWalls();
		initializeFireballs();
	}

	/**
		Function spawns three platforms for player to play on.
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



	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		//Turns on the floor
		FlxG.collide(hero, walls);

		// player overlaps with a fireball.
		FlxG.overlap(hero, fireballs, resolveHeroFireballOverlap);

		// Wrap various objects if gone offscreen.
		for (fireball in fireballs) {
		    respawnFireballs(fireball);
		} 	
	}
	
    private function screenWrapObject(wrappingObject:FlxObject) {
		if (wrappingObject.x > FlxG.width) {
			wrappingObject.x = 0 - wrappingObject.width;
		} else if (wrappingObject.x + wrappingObject.width < 0) {
			wrappingObject.x = FlxG.width;
		}

		if (wrappingObject.y > FlxG.height) {
			wrappingObject.y = 0 - wrappingObject.height;
		} else if (wrappingObject.y + wrappingObject.height < 0) {
			wrappingObject.y = FlxG.height;
		}
	}

    /**
		Function respawns fireballs at a random y-axis position.
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
