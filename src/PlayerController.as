package  
{
	import org.flixel.*;
	
	public class PlayerController extends FlxGroup
	{
		[Embed(source = 'data/holdinggun.png')] private var imgPlayer:Class;
		[Embed(source = 'data/legsbody.png')] private var imgLegs:Class;
		[Embed(source = 'data/uzi.png')] private var imgUzi:Class;
		[Embed(source = 'data/gunshot.mp3')] private var sfxGunshot:Class;
		
		private var speed:int = 100;
		
		public var aimAngle:Number;
		
		public var player:FlxSprite;
		private var legs:FlxSprite;
		public var gun:FlxSprite;
		
		private var firing:Boolean;
		private var gunCD:Number = 1;
		private var curCD:Number = 0;
		
		public function PlayerController(X:Number,Y:Number)
		{
			
			legs = new FlxSprite();
			legs.loadGraphic(imgLegs, true, false, 24, 24);
			legs.addAnimation("idle", [0], 12, true);
			legs.addAnimation("run", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 12, true);
			//add(legs);
			
			gun = new FlxSprite();
			gun.loadGraphic(imgUzi, false, false, 24, 24);
			//add(gun);
			
			player = new FlxSprite;
			player.loadGraphic(imgPlayer, true, false, 24, 24);
			player.x = X;
			player.y = Y;
			player.origin.x = 12;
			player.origin.y = 12;
			player.offset.x = 2;
			player.offset.y = 3;
			player.width = 20;
			player.height = 20;
			player.maxVelocity.x = player.maxVelocity.y = speed;
			player.drag.x = player.drag.y = speed * 4;
			player.addAnimation("idle", [0]);
			player.addAnimation("run", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 12, true);
			add(player);
			
		}
		
		override public function update():void
		{
			player.angle = getAimAngle();
			
			player.acceleration.x = player.acceleration.y = 0;
			
			/*crosshair.x = player.x + Math.cos(getMoveVector()) + 100;
			crosshair.y = player.y + Math.sin(getMoveVector()) + 100;
			
			if (FlxG.keys.pressed("W")) {
				player.acceleration.x = Math.cos(getMoveVector()) * player.maxVelocity.x * 4;
				player.acceleration.y = Math.sin(getMoveVector()) * player.maxVelocity.y * 4;
			}
			if (FlxG.keys.pressed("A")) {
				player.acceleration.x = -player.maxVelocity.y * 4;
			}
			if (FlxG.keys.pressed("S")) {
				player.acceleration.y = player.maxVelocity.y * 4;
			}
			if (FlxG.keys.pressed("D")) {
				player.acceleration.x = player.maxVelocity.y * 4;
			}*/
			
			//W moves towards mouse
			
			/*if (FlxG.keys.pressed("W")) {
				player.acceleration.x = Math.cos(getMoveVector()) * player.maxVelocity.x * 4;
				player.acceleration.y = Math.sin(getMoveVector()) * player.maxVelocity.y * 4;
			}
			if (FlxG.keys.pressed("A")) {
				player.acceleration.x = -player.maxVelocity.y * 4;
			}
			if (FlxG.keys.pressed("S")) {
				player.acceleration.y = player.maxVelocity.y * 4;
			}
			if (FlxG.keys.pressed("D")) {
				player.acceleration.x = player.maxVelocity.y * 4;
			}*/
			
			
			//Standard top-down controls
			
			if (FlxG.keys.pressed("W")) {
				player.acceleration.y = -player.maxVelocity.y*4;
			}
			if (FlxG.keys.pressed("A")) {
				player.acceleration.x = -player.maxVelocity.y * 4;
			}
			if (FlxG.keys.pressed("S")) {
				player.acceleration.y = player.maxVelocity.y * 4;
			}
			if (FlxG.keys.pressed("D")) {
				player.acceleration.x = player.maxVelocity.y * 4;
			}
			
			if (FlxG.keys.pressed("SHIFT")) {
				player.acceleration.x *= 5;
				player.acceleration.y *= 5;
			}
			
			if (player.velocity.x != 0 || player.velocity.y != 0) {
				player.play("run");
				legs.play("run");
			} else {
				player.play("idle");
				legs.play("idle");
			}
			
			//if (FlxG.mouse.justPressed()) fireWep();
			
			//options for firing: automatic, semi-automatic, burst
			//if # of clicks within .elapsed is great, reduce accuracy angle
			
			if (FlxG.mouse.pressed()) firing = true;
			else firing = false;
			
			if (firing) {
				if(curCD <= 0) {
					fireWep();
					curCD = .2;
				} else {
					curCD -= FlxG.elapsed;
				}
			}
			
			if (FlxG.mouse.justReleased()) curCD = 0;
			
			if (legs.x != player.x) legs.x = player.x;
			if (legs.y != player.y) legs.y = player.y;
			
			if(gun.x != player.x) gun.x = player.x;
			if(gun.y != player.y) gun.y = player.y;
			if (gun.angle != player.angle) gun.angle = player.angle;
			
			super.update()
		}
		
		private function fireWep():void
		{
			FlxG.play(sfxGunshot);
			var b:Bullet = new Bullet();
			add(b);
		}
		
		/*private function fireWeapon():void
		{
			var tracer:Tracer = new Tracer(player.x, player.y, getMoveVector());
			add(tracer);
			
			var xx:Number = player.x + 12;
			var yy:Number = player.y + 12;
			
			var a:FlxGroup = new FlxGroup();
			add(a);
			var b:FlxSprite = new FlxSprite(xx, yy);
			b.makeGraphic(2, 2);
			
			var _angle:Number = tracer.angle*(Math.PI/180)+Math.PI/2;
			
			for (var i:int = 0; i < 50; i++) {
				xx += Math.cos(_angle) * 6;
				yy += Math.sin(_angle) * 6;
				b = new FlxSprite(xx, yy);
				b.makeGraphic(2, 2);
				a.add(b);
				if (FlxG.overlap(b, PlayState.enemies)) {
					tracer.kill();
					FlxG.log("enemy hit");
					break;
				}
			}
			a.kill();
		}*/
		
		public function getAimAngle():Number
		{
			
			var dx:Number = player.x+12 - FlxG.mouse.x;
			var dy:Number = player.y+12 - FlxG.mouse.y;
			var angle:Number = Math.atan2(dy, dx); //gives radian
			angle = angle * (180 / Math.PI); //convert to degrees
			
			return angle - 90;
		}
		
		public function getMoveVector():Number
		{
			var dx:Number = FlxG.mouse.x - (player.x+12);
			var dy:Number = FlxG.mouse.y - (player.y+12);
			var angle:Number = Math.atan2(dy, dx); //gives radian
			
			return angle;
		}
		
	}

}