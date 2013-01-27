package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class TitleScreen extends MovieClip {
		
		
		public function TitleScreen() {
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, Click, false, 0, true);
			// constructor code
		}
		
		public function Click(e:MouseEvent):void {
			visible = false;
			Game.instance.gameStarted = true;
			Game.instance.DoNewGame();
		}
	}
	
}
