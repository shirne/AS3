package
{
	import com.mcleodgaming.util.Key; //Import the Key class
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Main extends MovieClip
	{
		/**
		 * Initializes the program
		 */
		public function Main()
		{
			//Initialize the Key class
			Key.init();
			
			//Key.beginCapture(this); //Alternative: If you do not choose the stage as the target, an item within the stage will need to have focus
			Key.beginCapture(this.stage);
			
			this.addEventListener(Event.ENTER_FRAME, checkKeyPress);
		}
		
		
		/**
		 * Checks the state of the keyboard each frame
		 * @param	e The triggered event object
		 */
		public function checkKeyPress(e:Event)
		{
			//Easily have the entire keyboard state at your disposal during any frame
			var pressingSpace = Key.isDown(Key.SPACEBAR);
			var pressingShift = Key.isDown(Key.A);
			var pressingUp = Key.isDown(Key.UP);
			var pressingDown = Key.isDown(Key.DOWN);
			var pressingLeft = Key.isDown(Key.LEFT);
			var pressingRight = Key.isDown(Key.RIGHT);
			
			//Perform actions based on what is being pressed
			space_txt.text = (pressingSpace) ? "yes" : "no";
			shift_txt.text = (pressingShift) ? "yes" : "no";
			
			var mc:MovieClip = this.getChildByName("square") as MovieClip;
			
			if (pressingLeft)
				mc.x -= 5;
			else if (pressingRight)
				mc.x += 5;
				
			if (pressingUp)
				mc.y -= 5;
			else if (pressingDown)
				mc.y += 5;
		}
	}
}
