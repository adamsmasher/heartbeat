package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Item extends MovieClip {
		var pickedUp:Boolean = false;
		var killed:Boolean = false;
		
		public function Item() {
			Game.instance.addChild(this);
			Game.instance.items.push(this);
		}
		
		public function Tick(e:Event):void {
			if (pickedUp) {
				if (!killed) {
					Misc.RemoveSpriteIfInside(this, Game.instance);
					Misc.RemoveObject(this, Game.instance.items);
					Collected();
					killed = true;
				}
			}
		}
		
		public function Collected() {
		}
	}
}

/*
different colored letter
collision on specific color
clock countdown
*/