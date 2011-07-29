package  
{
	import org.flixel.*;
	
	public class Zombie extends FlxSprite
	{
		[Embed(source = 'data/zombietile.png')] private var imgZombie:Class;
		
		private var player:FlxSprite;
		
		private var speed:Number;
		private var turnSpeed:Number;
		
		public var aggro:Boolean;
		
		public var dead:Boolean;
		public var permaDead:Boolean;
		
		private var deadCounter:Number = 0;
		private var rotateCounter:Number = 0;
		private var despawnCounter:Number = 0;
		
		private var rnd:Number;
		
		public function Zombie(X:Number, Y:Number) 
		{
			loadGraphic(imgZombie, true, false, 24, 48);
			
			x = X;
			y = Y;
			
			width = 24;
			height = 24;
			
			offset.y = 12;
			
			player = PlayState.pc.player;
			
			speed = 25;
			turnSpeed = 0.3;
			
			aggro = false;
			dead = false;
			
			angularDrag = 10;
			
			rnd = 0;
			
			angle = Math.random() * 360;
			
			//random health, possibly temporary. could make bullet damage varry in the hit() function
			health = randRange(25,100,true);
			
			drag.x = drag.y = 200;
			
			addAnimation('walk', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 4, true);
			addAnimation('death', [11, 12, 13, 14, 15, 16], 12, false);
			addAnimation('dead', [16], 0, false);
		}
		
		override public function update():void
		{
			
			var dx:Number = x - player.x-6;
			var dy:Number = y - player.y+12;
			var dist:Number = Math.sqrt(dx*dx+dy*dy);
			var _angle:Number = Math.atan2(dy, dx);
			
			if (dist < 150) aggro = true;
			
			if (aggro && !dead) {
				
				angle = _angle * 180 / Math.PI - 90;
				velocity.x = -Math.cos(_angle) * speed;
				velocity.y = -Math.sin(_angle) * speed;
				
			} else if (!aggro && !dead) {
				
				rotateCounter += FlxG.elapsed;
				
				if (rotateCounter >= randRange(1,5)) {
					angularVelocity = randRange(-50, 50);
					rotateCounter = 0;
				}
				
				_angle = (angle * (Math.PI / 180)) - Math.PI / 2;
				
				velocity.x = Math.cos(_angle) * speed/2;
				velocity.y = Math.sin(_angle) * speed/2;
				
			}
			
			if (dead && !permaDead) {
				deadCounter += FlxG.elapsed;
				if (deadCounter >= 1) {
					rnd = randRange(0, 5, true);
					if (rnd == 1) {
						_revive();
					}
					deadCounter = 0;
				}
			}
			
			if (dead && permaDead)
			{
				despawnCounter += FlxG.elapsed;
				if (despawnCounter >= 10)
					alpha -= .001;
				if (alpha <= 0)
					kill();
			}
			
			if(velocity.x > 0 && velocity.y > 0 && !dead)
				play('walk');
			
			super.update();
		}
		
		public function hit(_angle:Number):void
		{
			if (!dead) {
				/*velocity.x = Math.cos(_angle) * 40;
				velocity.y = Math.sin(_angle) * 40;*/
				hurt(25);
				if(randRange(0, 3, true) == 1) aggro = true;
			}
		}
		
		override public function kill():void
		{
			dead = true;
			play('death');
			if (randRange(0, 10, true) < 5) permaDead = true;
			solid = false;
			if(alpha <= 0) super.kill();
		}
		
		private function _revive():void
		{
			dead = false;
			solid = true;
			health = randRange(25, 100,true);
			play('walk');
			permaDead = true;
			despawnCounter = 0;
		}
		
		private function randRange(minArg:Number,maxArg:Number,floor:Boolean=false):Number
		{
			rnd = minArg + (maxArg - minArg) * Math.random();
			if (floor) rnd = Math.floor(rnd);
			return rnd;
		}
		
	}

}