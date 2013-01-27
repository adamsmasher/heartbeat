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
			new TextDrop(50, 50, "TEXTDROP", Game.Color_Blue),
			new WaitEvent(30),
			new TextDrop(550, 50, "ANOTHER", Game.Color_Red),
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