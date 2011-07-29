package
{
	import org.flixel.*;
	import flash.geom.Point;
	import flash.display.Bitmap;
	import flash.display.Shape;
	
	public class Bullet extends FlxGroup
	{
		protected var drawShape:Shape;
		protected var player:FlxSprite;
		protected var camera:FlxCamera;
		
		private var tracer:Tracer;
		
		private var b:FlxSprite;
		
		private var xx:Number;
		private var yy:Number;
		
		private var _angle:Number;
		
		private var count:int = 50;

        function Bullet() 
		{
			
			//TODO: Make tracer release AFTER bullet has been shot to determine aesthetics
			//e.g. count iterations it took for the bullet to travel. determine tracer length based on that
			
			this.player = PlayState.pc.player;
			this.camera = PlayState.camera;
			
			tracer = new Tracer(player.x, player.y, PlayState.pc.getMoveVector());
			add(tracer);
			
			xx = player.x + 12;
			yy = player.y + 12;
			
			_angle = tracer.angle * (Math.PI / 180) + Math.PI / 2;
			
			b = new FlxSprite(xx, yy);
			
			while (b.x > camera.scroll.x && b.y > camera.scroll.y && b.x < camera.scroll.x+camera.width && b.y < camera.scroll.y+camera.height) {
				xx += Math.cos(_angle) * 4;
				yy += Math.sin(_angle) * 4;
				//b = new FlxSprite(xx, yy);
				b.x = xx;
				b.y = yy;
				b.makeGraphic(2, 2);
				//add(b);
				if (FlxG.overlap(b, PlayState.enemies,enemyHit)) {
					FlxG.log("enemy hit");
					break;
				}
				if (FlxG.overlap(b, PlayState.walls)) {
					FlxG.log("wall hit");
					break;
				}
			}
			b = null
        }
		
		private function enemyHit(bullet:FlxObject, enemy:FlxObject):void
		{
			if (enemy is Zombie) (enemy as Zombie).hit(_angle);
			
			/////////////////////////////////////////
			//Here we actually initialize out emitter
			//The parameters are        X   Y                Size (Maximum number of particles the emitter can store)
			var theEmitter:FlxEmitter = new FlxEmitter(bullet.x, bullet.y, 20);

			var dx:Number = bullet.x - (player.x + 12);
			var dy:Number = bullet.y - (player.y + 12);
			var _angle1:Number = Math.atan2(dy,dx);
			
			var vx:Number = -Math.cos(_angle1) * 50;
			var vy:Number = -Math.sin(_angle1) * 50;

			//First this emitter is on the side of the screen, and we want to show off the movement of the particles
			//so lets make them launch to the right.
			theEmitter.setXSpeed(vx-50, vx+50);

			//and lets funnel it a tad
			theEmitter.setYSpeed(vy-50, vy+50);

			//Let's also make our pixels rebound off surfaces
			theEmitter.bounce = .8;

			//Now let's add the emitter to the state.
			add(theEmitter);

			//Now it's almost ready to use, but first we need to give it some pixels to spit out!
			//Lets fill the emitter with some white pixels
			for (var i:int = 0; i < theEmitter.maxSize/2; i++) {
				var pBlood:FlxParticle = new FlxParticle();
				pBlood.makeGraphic(2, 2, 0xFFFF0000);
				pBlood.visible = false; //Make sure the particle doesn't show up at (0, 0)
				theEmitter.add(pBlood);
				pBlood = new FlxParticle();
				pBlood.makeGraphic(1, 1, 0xFFFF0000);
				pBlood.visible = false;
				theEmitter.add(pBlood);
			}
			
			theEmitter.start(true, .25);
			/////////////////////////////////////////
		}

        /*override public function draw():void 
		{
            drawShape = new Shape();
            drawShape.graphics.lineStyle(1, 0x999999);
            drawShape.graphics.moveTo(player.x + player.width/2, player.y + player.height/2);
            drawShape.graphics.lineTo(FlxG.mouse.x, FlxG.mouse.y);
            FlxG.camera.buffer.draw(drawShape);
			super.draw();
        }*/
		
		override public function update():void
		{
			if (FlxG.overlap(tracer, PlayState.enemies)) tracer.kill();
			if (FlxG.overlap(tracer, PlayState.walls)) tracer.kill();
			
			super.update();
		}
		
	}

}