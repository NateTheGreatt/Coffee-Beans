//Code generated with DAME. http://www.dambots.com

package 
{
	import org.flixel.*;
	public class Level_1 extends BaseMap
	{
		//Embedded media...
		[Embed(source="data/mapCSV_Group1_Ground.csv", mimeType="application/octet-stream")] public var CSV_Group1Ground:Class;
		[Embed(source="data/tileset.png")] public var Img_Group1Ground:Class;
		[Embed(source="data/mapCSV_Group1_Walls.csv", mimeType="application/octet-stream")] public var CSV_Group1Walls:Class;
		[Embed(source="data/walltiles.png")] public var Img_Group1Walls:Class;

		//Tilemaps
		public var layerGroup1Ground:FlxTilemap;
		public var layerGroup1Walls:FlxTilemap;

		//Sprites


		public function Level_1(addToStage:Boolean = true, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerGroup1Ground = new FlxTilemap;
			layerGroup1Ground.loadMap( new CSV_Group1Ground, Img_Group1Ground, 24,24, FlxTilemap.OFF, 0, 1, 1 );
			layerGroup1Ground.x = 0.000000;
			layerGroup1Ground.y = 0.000000;
			layerGroup1Ground.scrollFactor.x = 1.000000;
			layerGroup1Ground.scrollFactor.y = 1.000000;
			layerGroup1Walls = new FlxTilemap;
			layerGroup1Walls.loadMap( new CSV_Group1Walls, Img_Group1Walls, 24,24, FlxTilemap.OFF, 0, 1, 1 );
			layerGroup1Walls.x = 0.000000;
			layerGroup1Walls.y = 0.000000;
			layerGroup1Walls.scrollFactor.x = 1.000000;
			layerGroup1Walls.scrollFactor.y = 1.000000;

			//Add layers to the master group in correct order.
			masterLayer.add(layerGroup1Ground);
			masterLayer.add(layerGroup1Walls);


			if ( addToStage )
			{
				FlxG.state.add(masterLayer);
			}

			mainLayer = layerGroup1Ground;
			wallsLayer = layerGroup1Walls;

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 1200;
			boundsMaxY = 1200;

		}


	}
}
