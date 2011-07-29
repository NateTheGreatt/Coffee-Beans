package  
{
	import org.flixel.*;
	
	public class Tracer extends FlxSprite
	{
		
		private var _angle:Number;
		private var speed:Number = 2000;
		
		private var spread:Number = 2;
		
		private var length:Number = 225;
		
		private var thrust:Number;
		
		public function Tracer(X:Number,Y:Number,angle:Number) 
		{
			length = randRange(25, 255);
			makeGraphic(1, length, 0xffedda77);
			
			x = X;
			y = Y;
			
			origin.x = 0;
			origin.y = 0;
			offset.x = -12;
			offset.y = -12;
			
			//_angle = (angle + (Math.random() / accuracy) - 1 / accuracy);
			
			alpha = Math.random();
			
			_angle = angle * (180 / Math.PI); //radians -> degrees
			
			_angle = _angle + randRange(-spread, spread);
			
			_angle = _angle * (Math.PI / 180); //degrees -> radians
			
			this.angle = _angle*(180/Math.PI)-90;
			
		}
		
		override public function update():void
		{
			velocity.x = Math.cos(_angle) * speed;
			velocity.y = Math.sin(_angle) * speed;
			
			super.update();
		}
		
		private function randRange(minArg:Number,maxArg:Number):Number
		{
			return minArg + (maxArg-minArg)*Math.random();
		}
		
	}

}