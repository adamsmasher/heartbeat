package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Item extends MovieClip {
		var pickedUp:Boolean = false;
		
		public function Item() {
			Game.instance.addChild(this);
			Game.instance.items.push(this);
		}
		
		public function Tick(e:Event):void {
			if (pickedUp) {
				Misc.RemoveSpriteIfInside(this, Game.instance);
				Misc.RemoveObject(this, Game.instance.items);
			}
		}
	}
}
