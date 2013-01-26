package  {
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	public class Game extends MovieClip {
		var world:b2World = null;
		
		public static var StageWidth:Number = 800;
		public static var StageHeight:Number = 500;
		public static var ToBox:Number = 1.0 / 4.0;
		public static var ToFlash:Number = 1.0 / ToBox;
		public static var instance:Game = null;
		public static var dt:Number = 1.0 / 30.0;
		
		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, Added, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
		}
		
		public function Added(e:Event):void {
			instance = this;
			removeEventListener(Event.ADDED_TO_STAGE, Added, false);
			Init();
		}
		
		public function Init():void {
			world = new b2World(new b2Vec2(0, 100), false);
			addEventListener(Event.ENTER_FRAME, Tick, false, 0, true);
		}
		
		public function Tick(e:Event):void {
			world.Step(dt, 5, 5);
		}
		
		public function KeyDown(e:KeyboardEvent) {
			
		}
		
		public function KeyDown(e:KeyboardEvent) {
			if (e.keyCode == Keyboard.LEFT) {
				square.movingLeft = true;
			} else if (e.keyCode == Keyboard.RIGHT) {
				square.movingRight = true;
			} else if ( e.keyCode == Keyboard.SPACE) {
				square.Jump();
			}
		}
		
		public function KeyUp(e:KeyboardEvent) {
			if (e.keyCode == Keyboard.LEFT) {
				square.movingLeft = false;
			} else if (e.keyCode == Keyboard.RIGHT) {
				square.movingRight = false;
			}
		}
	}
}






















