package
{
	import com.mcleodgaming.util.Dictionary; //Import the Dictionary class
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Main extends MovieClip
	{
		/**
		 * Initializes the program
		 */
		public function Main()
		{
			//A few tests of the Dictionary class
			var objectsDict:Dictionary = new Dictionary(Object);
			var integerDict:Dictionary = new Dictionary(int);
			
			objectsDict.push("foo", { param1: "parameter in my object" });
			
			integerDict.push("dog", 143);
			integerDict.push("cat", 751);
			integerDict.push("bird", 331);
			
			writeLine("> Objects dictionary contains " + objectsDict.length + " value(s)");
			writeLine("> Objects dictionary contains " + objectsDict.getKey("foo") + " at key \"foo\"");
			writeLine("");
			writeLine("> Integer dictionary contains " + integerDict.length + " value(s)");
			writeLine("> Integer dictionary contains " + integerDict.getKey("dog") + " at key \"dog\"");
			writeLine("> Integer dictionary contains " + integerDict.getKey("bird") + " at key \"bird\"");
			
			//Usage of getValue()
			writeLine("> Integer dictionary contains " + integerDict.getKey("cat") + " at key \"" +  integerDict.getValue(751) + "\"");
			
		}
		
		/**
		 * Simple print function
		 */
		public function writeLine(str:String)
		{
			this.output_txt.appendText(str + "\n");
		}
	}
}
