package
{
	import org.flixel.*;

	public class Spawner extends FlxSprite
	{
		
		private var _timer:Number;
		private var _Zombies:FlxGroup;
		private var _botBullets:FlxGroup;
		private var _botGibs:FlxEmitter;
		private var _gibs:FlxEmitter;
		private var _player:Player;
		
		public function Spawner(X:int, Y:int,Gibs:FlxEmitter,Zombies:FlxGroup,BotBullets:FlxGroup,BotGibs:FlxEmitter,ThePlayer:Player)
		{
			super(X,Y);
			loadGraphic(ImgSpawner,true);
			_gibs = Gibs;
			_Zombies = Zombies;
			_botBullets = BotBullets;
			_botGibs = BotGibs;
			_player = ThePlayer;
			_timer = FlxG.random()*20;
			_open = false;
			health = 8;
		}
		
		override public function destroy():void
		{
			super.destroy();
			_Zombies = null;
			_botGibs = null;
			_botBullets = null;
			_gibs = null;
			_player = null;
		}
		
		override public function update():void
		{
			_timer += FlxG.elapsed;
			var limit:uint = 20;
			if(onScreen())
				limit = 4;
			if(_timer > limit)
			{
				_timer = 0;
				makeBot();
			}
			else if(_timer > limit - 0.35)
			{
				if(!_open)
				{
					_open = true;
					play("open");
				}
			}
			else if(_timer > 1)
			{
				if(_open)
				{
					play("close");
					_open = false;
				}
			}
				
			super.update();
		}
		
		override public function hurt(Damage:Number):void
		{
			FlxG.play(SndHit);
			flicker(0.2);
			FlxG.score += 50;
			super.hurt(Damage);
		}
		
		override public function kill():void
		{
			if(!alive)
				return;
			FlxG.play(SndExplode);
			FlxG.play(SndExplode2);
			super.kill();
			active = false;
			exists = true;
			solid = false;
			flicker(0);
			play("dead");
			FlxG.camera.shake(0.007,0.25);
			FlxG.camera.flash(0xffd8eba2,0.65,turnOffSlowMo);
			FlxG.timeScale = 0.35;
			makeBot();
			_gibs.at(this);
			_gibs.start(true,3);
			FlxG.score += 1000;
		}
		
		protected function makeBot():void
		{
			(_Zombies.recycle(Enemy) as Enemy).init(x + width/2, y + height/2, _botBullets, _botGibs, _player);
		}
		
		protected function turnOffSlowMo():void
		{
			FlxG.timeScale = 1.0;
		}
	}
}