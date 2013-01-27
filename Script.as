package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class Script 
	{
		var currentWait:Number = 0;
		var time:Number = 0;
		var i:int = 0;
		
		private static var script:Array = [
			new WaitEvent(300),
			new TextDrop(250, 50, "TEXTDROP", Game.Color_Blue),
			new WaitEvent(120),
			new TextDrop(450, 50, "AANOTHER", Game.Color_Red),
			new WaitEvent(180),
			new TextDrop(50, 50, "TERXDERP", Game.Color_Red),
			new TextDrop(550, 50, "OBLOGOTA", Game.Color_Blue),
			new WaitEvent(240),
			new TextDrop(50, 50, "ONE", Game.Color_Blue),
			new WaitEvent(30),
			new TextDrop(100, 50, "WORD", Game.Color_Red),
			new WaitEvent(30),
			new TextDrop(150, 50, "AFTER", Game.Color_Blue),
			new WaitEvent(30),
			new TextDrop(250, 50, "ANOTHER", Game.Color_Red),
			new WaitEvent(200),
			new TextDrop(350, 32, "A", Game.Color_Blue),
			new TextDrop(250, 80, "TOWER", Game.Color_Red),
			new TextDrop(330, 128, "OF", Game.Color_Blue),
			new TextDrop(270, 176, "WORDS", Game.Color_Red),
			new WaitEvent(300),
		new TextDrop(50, 50, "LOVE", Game.Color_Red),
			new WaitEvent(30),
		new TextDrop(150, 50, "LOVE", Game.Color_Blue),
					new WaitEvent(30),
		new TextDrop(250, 50, "LOVE", Game.Color_Red),
					new WaitEvent(30),
		new TextDrop(350, 50, "LOVE", Game.Color_Blue),
					new WaitEvent(30),
		new TextDrop(450, 50, "LOVE", Game.Color_Red),
					new WaitEvent(30),
		new TextDrop(550, 50, "LOVE", Game.Color_Blue),
		new WaitEvent(300),
		new TextDrop(150, 50, "R", Game.Color_Blue),
					new WaitEvent(30),
		new TextDrop(200, 50, "E", Game.Color_Red),
					new WaitEvent(30),
		new TextDrop(250, 50, "L", Game.Color_Blue),
					new WaitEvent(30),
		new TextDrop(300, 50, "A", Game.Color_Red),
					new WaitEvent(30),
		new TextDrop(350, 50, "T", Game.Color_Blue),
					new WaitEvent(30),
		new TextDrop(400, 50, "I", Game.Color_Red),
					new WaitEvent(30),
		new TextDrop(450, 50, "O", Game.Color_Blue),
					new WaitEvent(30),
		new TextDrop(500, 50, "N", Game.Color_Red),
					new WaitEvent(30),
		new TextDrop(550, 50, "S", Game.Color_Blue),
					new WaitEvent(30),
		new TextDrop(600, 50, "H", Game.Color_Red),
					new WaitEvent(30),
		new TextDrop(650, 50, "I", Game.Color_Blue),
					new WaitEvent(30),
		new TextDrop(700, 60, "P", Game.Color_Red),
		
			new WaitEvent(6000),
		];
			
		
		public function Script() 
		{
			
		}
		
		public function Tick() {
			time++;
			if (time > currentWait) {
				while (i < script.length && script[i] is TextDrop) {
					var thisDrop:TextDrop = TextDrop(script[i]);
					Game.instance.MakeGlowText(thisDrop.x, thisDrop.y, thisDrop.text, thisDrop.color);
					i++;
				}
				if (i < script.length) {
					var thisWait:WaitEvent = WaitEvent(script[i]);
					currentWait = thisWait.waitTime;
					time = 0;
					i++;
				} else {
					// we're done!
				}
			}
		}
		
	}

}