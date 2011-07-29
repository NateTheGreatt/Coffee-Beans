package  
{
	import org.flixel.*;
	
	public class Wall extends FlxSprite
	{
		
		public function Wall(type:String, tile:FlxPoint)
		{
			immovable = true;
			
			switch(type) {
				case "left":
					makeGraphic(2, 24, 0x000000ff);
					x = tile.x-12;
					y = tile.y-12;
				break;
				
				case "right":
					makeGraphic(2, 24, 0x000000ff);
					x = tile.x+10;
					y = tile.y-12;
				break;
				
				case "top":
					makeGraphic(24, 2, 0x000000ff);
					x = tile.x-12;
					y = tile.y-12;
				break;
				
				case "bottom":
					makeGraphic(24, 2, 0x000000ff);
					x = tile.x-12;
					y = tile.y+10;
				break;
			}
			
		}
		
	}

}