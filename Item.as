package  {
	import flash.display.MovieClip;
	
	public class Item extends MovieClip {
		public function Item() {
			// constructor code
		}
		
		public function Collected() {
			this.x = this.y = -100;
		}
	}
}
