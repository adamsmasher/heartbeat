package  {
	import flash.display.MovieClip;
	
	public class Item extends MovieClip {
		var pickedUp:Boolean = false;
		
		public function Item() {
			Game.instance.addChild(this);
			Game.instance.items.push(this);
		}
		
		public function Collected() {
			if (!pickedUp) {
				pickedUp = true;
				Misc.RemoveSpriteIfInside(this, Game.instance);
				Misc.RemoveObject(this, Game.instance.items);
			}
		}
	}
}
