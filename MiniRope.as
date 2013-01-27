package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class MiniRope extends MovieClip {
		var heart1:Heart = null;
		var heart2:Heart = null;
		
		var numLines:int = 0;
		public function MiniRope(_heart1:Heart, _heart2:Heart) {
			Game.instance.addChildAt(this, 1);
			heart1 = _heart1;
			heart2 = _heart2;
			addEventListener(Event.ENTER_FRAME, Tick, false, 0, true);
		}
		
		public function Tick(e:Event):void {
			if (!Game.instance.gameStarted) {
				visible = false;
				return;
			}
			visible = true;
			
			x = heart1.x;
			y = heart1.y;
			rotation = Misc.ToDegrees(Math.atan2(heart2.y - heart1.y, heart2.x - heart1.x));
			var d:Number = Misc.Dist(heart1.x, heart1.y, heart2.x, heart2.y);
			scaleX = d / 100;
			scaleY = Misc.Lerp(1.5, 0.5, Misc.Saturate(d / 400));
		}
	}
}