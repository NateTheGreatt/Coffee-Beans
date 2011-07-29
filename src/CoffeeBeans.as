package

{

	import org.flixel.*;

	[SWF(width="640", height="480", backgroundColor="#000000")]

	[Frame(factoryClass="Preloader")]



	public class CoffeeBeans extends FlxGame

	{

		public function CoffeeBeans()

		{

			//super(320,240,MenuState,2, 60, 60);
			super(640, 480, MenuState, 1, 60, 60);
			forceDebugger = true;
		}

	}

}

