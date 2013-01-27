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
		/*	// wait a while to let the player get accustomed to controls
			new WaitEvent(300),
			// drop one colour, so they can see that blue can pick up blue and red can't (R:0, B:9)
			new TextDrop(300, 50, "I LOVE THEE", Game.Color_Blue),
			new WaitEvent(120),
			// now drop red, so they see that the letters and players are colour coded (R:13, B:9)
			new TextDrop(225, 100, "COUNT THE WAYS", Game.Color_Red),
			new WaitEvent(180),
			// drop two simultaneously to show the tension (R: 24, B: 22)
			new TextDrop(50, 50, "JUMP IN A FIRE", Game.Color_Red),
			new TextDrop(400, 50, "ON A SUMMERS DAY", Game.Color_Blue),
			new WaitEvent(240),
			// explode words (R: 36, B: 36)
			new TextDrop(320, 130, "FOREVER", Game.Color_Blue),
			new WaitEvent(30),
			new TextDrop(320, 130, "IS A WORD", Game.Color_Red),
			new WaitEvent(90),
			new TextDrop(320, 130, "FOREVER", Game.Color_Blue),
			new WaitEvent(30),
			new TextDrop(320, 130, "FADES", Game.Color_Red),
			new WaitEvent(200),
			// drop a tower of words (R: 52, B: 53) 
			new TextDrop(300, 32, "ATTRACTION", Game.Color_Blue),
			new TextDrop(300, 80, "REPULSION", Game.Color_Red),
			new TextDrop(300, 128, "LONGING", Game.Color_Blue),
			new TextDrop(300, 176, "BOREDOM", Game.Color_Red),
			new WaitEvent(300),
			// write LOVE and HATE on opposite sides of the screen
			new TextDrop(150, 75, "LOVE", Game.Color_Blue),
			new TextDrop(575, 75, "HATE", Game.Color_Red),
			new WaitEvent(150),
			// write LOVE/HATE across the screen, alternating (R: 56, B:53)
			new TextDrop(50, 50, "HATE", Game.Color_Red),
			new WaitEvent(30),
			new TextDrop(150, 50, "LOVE", Game.Color_Blue),
			new WaitEvent(30),
			new TextDrop(250, 50, "HATE", Game.Color_Red),
			new WaitEvent(30),
			new TextDrop(350, 50, "LOVE", Game.Color_Blue),
			new WaitEvent(30),
			new TextDrop(450, 50, "HATE", Game.Color_Red),
			new WaitEvent(30),
			new TextDrop(550, 50, "LOVE", Game.Color_Blue),
			new WaitEvent(30),
			new TextDrop(600, 50, "HATE", Game.Color_Red),
			new WaitEvent(300),
			// drop the word "RELATIONSHIP" one letter at a time (maintains R,B)
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
			new WaitEvent(300), 
			// draw five words - two low, two high - you can jump on words to get higher (R:69, B:81)
			new TextDrop(50, 50, "HAPPINESS", Game.Color_Blue),
			new TextDrop(280, 50, "SETTLING", Game.Color_Red),
			new TextDrop(500, 50, "CONTENTMENT", Game.Color_Blue),
			new TextDrop(165, 175, "APART", Game.Color_Red),
			new TextDrop(390, 175, "TOGETHER", Game.Color_Blue), */
			// sentence drop
		new TextDrop(50, 75, "THIS", Game.Color_Blue),
		new WaitEvent(15),
		new TextDrop(200, 75, "IS", Game.Color_Red),
		new WaitEvent(15),
		new TextDrop(350, 75, "A", Game.Color_Blue),
		new WaitEvent(15),
		new TextDrop(600, 75, "SENTENCE", Game.Color_Red),
		new WaitEvent(150),
		
			// random argument
			// game over goes here
			new WaitEvent(6000),
		];
			
		
		public function Script() 
		{
			
		}
		
		public function Tick() {
			if (Game.instance.gameOver)
				return;
				
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