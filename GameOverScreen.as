package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	public class GameOverScreen extends MovieClip {
		public function GameOverScreen() {
			replayButton.gotoAndStop(1);
			replayButton.buttonMode = true;
			replayButton.addEventListener(MouseEvent.ROLL_OUT, RollOut, false, 0, true);
			replayButton.addEventListener(MouseEvent.ROLL_OVER, RollOver, false, 0, true);
			replayButton.addEventListener(MouseEvent.CLICK, ClickReplay, false, 0, true);
		}
		
		public function Update():void {
			tiegame.visible = false;
			p2wins.visible = false;
			p1wins.visible = false;
			var player1:Heart = Game.instance.square2;
			var player2:Heart = Game.instance.square;
			if (player1.score > player2.score) {
				p1wins.visible = true;
			}
			else if (player2.score > player1.score) {
				p2wins.visible = true;
			}
			else {
				tiegame.visible = true;
			}
		}
		
		public function RollOut(e:MouseEvent):void {
			replayButton.gotoAndStop(1);
		}
		
		public function RollOver(e:MouseEvent):void {
			replayButton.gotoAndStop(2);
		}
		
		public function ClickReplay(e:MouseEvent):void {
			Game.instance.DoNewGame();
		}
	}
}
