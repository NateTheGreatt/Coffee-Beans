package
{

	import org.flixel.*;
	import org.flixel.system.FlxTile;

	public class PlayState extends FlxState
	{
		
		public static var pc:PlayerController;
		
		public static var level:BaseMap;
		
		public static var walls:FlxGroup;
		
		public static var camera:FlxCamera;
		
		public static var bullets:FlxGroup;
		public static var enemies:FlxGroup;
		public var emitters:FlxGroup;
		
		public var _bigGibs:FlxEmitter;
		
		public var e:Zombie;
		
		private var timer:Number = 0;
		
		protected function onSpriteAddedCallback(sprite:FlxSprite, group:FlxGroup):void
		{
			if (sprite is Zombie)
			{
				enemies = group;
			}
		}
		
		override public function create():void
		{
			
			level = new Level_1(true, onSpriteAddedCallback);
			
			enemies = new FlxGroup();
			add(enemies);
			
			pc = new PlayerController(FlxG.width/2,FlxG.height/2);
			add(pc);
			
			bullets = new FlxGroup();
			add(bullets);
			
			emitters = new FlxGroup();
			add(emitters);
			
			walls = new FlxGroup();
			add(walls);
			
			for (var i:int = 0; i < 50; i++)
			{
				e = new Zombie(Math.random()*level.mainLayer.width, Math.random()*level.mainLayer.height);
				enemies.add(e);
			}
			
			FlxG.debug = true;
			
			camera = new FlxCamera(0, 0, FlxG.width, FlxG.height);
			FlxG.resetCameras(camera);
			camera.follow(pc.player, FlxCamera.STYLE_TOPDOWN);
			FlxG.worldBounds = new FlxRect(level.mainLayer.x, level.mainLayer.y, level.mainLayer.width, level.mainLayer.height);
			camera.bounds = FlxG.worldBounds;
			
			//Create an FlxEmitter for Zombie Gibs
			_bigGibs = new FlxEmitter();
			_bigGibs.setXSpeed(-200,200);
			_bigGibs.setYSpeed(-300,0);
			_bigGibs.setRotation(-720,-720);
			_bigGibs.bounce = 0.35;
			//_bigGibs.makeParticles(ImgSpawnerGibs,50,20,true,0.5);
			
			generateWalls();
			
		}
		
		override public function update():void
		{
			FlxG.collide(pc.player, walls);
			FlxG.collide(enemies, walls);
			
			FlxG.collide(enemies, enemies)
			FlxG.collide(enemies, pc.player)
			
			//make sure dead zombies appear at the bottom of the z-index
			enemies.members.sort(z_sorting);
			
			//zombies();
			
			super.update();
		}
		
		private function zombies():void
		{
			if (timer == 0) {
				var startPos:int = Math.round(Math.random() * (4 - 1)) + 1;
				var ex:Number;
				var ey:Number;
				switch(startPos) {
					case 1: //top
						ex = Math.random() * camera.x;
						ey = camera.y;
					break;
					
					case 2: //left
						ex = camera.x;
						ey = Math.random() * camera.y;
					break;
					
					case 3: //bottom
						ex = Math.random() * camera.x;
						ey = camera.y;
					break;
				}
				e = new Zombie(ex, ey);
				enemies.add(e);
			} else {
				timer--;
			}
		}
		
		private function z_sorting(a:FlxObject, b:FlxObject):Number
		{
			if ((a as Zombie).dead && (b as Zombie).dead)
				return 0;
			else if ((b as Zombie).dead)
				return 1;
			else if ((a as Zombie).dead)
				return -1;
			else return 0;
		}
		
		private function generateWalls():void
		{
			var t:Array = level.wallsLayer.getTileCoords(87);
			var l:Array = level.wallsLayer.getTileCoords(98);
			var r:Array = level.wallsLayer.getTileCoords(100);
			var b:Array = level.wallsLayer.getTileCoords(111);
			
			var tl:Array = level.wallsLayer.getTileCoords(86);
			var tr:Array = level.wallsLayer.getTileCoords(88);
			var bl:Array = level.wallsLayer.getTileCoords(110);
			var br:Array = level.wallsLayer.getTileCoords(112);
			
			var wall:Wall;
			
			var i:int;
			
			for (i = 0; i < t.length; i++) {
				wall = new Wall("top", t[i]);
				walls.add(wall);
			}
			
			for (i = 0; i < l.length; i++) {
				wall = new Wall("left", l[i]);
				walls.add(wall);
			}
			
			for (i = 0; i < r.length; i++) {
				wall = new Wall("right", r[i]);
				walls.add(wall);
			}
			
			for (i = 0; i < b.length; i++) {
				wall = new Wall("bottom", b[i]);
				walls.add(wall);
			}
			
			for (i = 0; i < tl.length; i++) {
				wall = new Wall("top", tl[i]);
				walls.add(wall);
				wall = new Wall("left", tl[i]);
				walls.add(wall);
			}
			
			for (i = 0; i < tr.length; i++) {
				wall = new Wall("top", tr[i]);
				walls.add(wall);
				wall = new Wall("right", tr[i]);
				walls.add(wall);
			}
			
			for (i = 0; i < bl.length; i++) {
				wall = new Wall("bottom", bl[i]);
				walls.add(wall);
				wall = new Wall("left", bl[i]);
				walls.add(wall);
			}
			
			for (i = 0; i < br.length; i++) {
				wall = new Wall("bottom", br[i]);
				walls.add(wall);
				wall = new Wall("right", br[i]);
				walls.add(wall);
			}
		}
	}
}

