package  
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		
		[Embed(source = 'data/player.png')] private var imgPlayer:Class;
		
		private var speed:int = 100;
		
		public var aimAngle:Number;
		
		public function Player(X:int, Y:int) 
		{
			loadGraphic(imgPlayer, true, false, 24, 24);
			x = X;
			y = Y;
			
			maxVelocity.x = maxVelocity.y = speed;
			drag.x = drag.y = speed * 4;
			
			addAnimation("idle", [0]);
			addAnimation("run", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 12, true);
			
		}
		
		override public function update():void
		{
			
			setAimAngle();
			angle = aimAngle;
			
			acceleration.x = acceleration.y = 0;
			
			if (FlxG.keys.pressed("W")) {
				acceleration.y = -maxVelocity.y*4;
			}
			if (FlxG.keys.pressed("A")) {
				acceleration.x = -maxVelocity.y * 4;
			}
			if (FlxG.keys.pressed("S")) {
				acceleration.y = maxVelocity.y * 4;
			}
			if (FlxG.keys.pressed("D")) {
				acceleration.x = maxVelocity.y * 4;
			}
			
			if(velocity.x != 0 || velocity.y != 0) 
				play("run");
			else
				play("idle");
			
			super.update();
			
		}
		
		private function setAimAngle():void
		{
			var dx:Number = x - FlxG.mouse.screenX;
			var dy:Number = y - FlxG.mouse.screenY;
			var angle:Number = Math.atan2(dy, dx); //gives radian
			angle = angle * (180 / Math.PI); //convert to degrees
			
			this.aimAngle = angle - 90;
		}
		
	}

}