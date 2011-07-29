package
{
	public class EnemySorter extends FlxGroup
	{
		public function FlxSortGroup():void
		{
			super();
		}
		
		override public function update():void
		{
			members.sort(y_sorting);
			super.update();
		}
		
		private function y_sorting(a:FlxObject, b:FlxObject):Number
		{
			var aY:Number = a.y;
			var bY:Number = b.y;
			
			if (aY > bY)
			{
				return 1;
			} else if (aY <  bY)
			{
				return -1;
			} else {
				return 0;
			}
		}
	}
}