package  {
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	public class Game extends MovieClip {
		var world:b2World = null;
		var time:Number = 0;
		
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
			world = new b2World(new b2Vec2(0, 0), false);
			addEventListener(Event.ENTER_FRAME, Tick, false, 0, true);
			gotoAndStop(2);
			CreateStaticBody(topborder, -1);
			CreateStaticBody(bottomborder, -1);
			CreateStaticBody(leftborder, -1);
			CreateStaticBody(rightborder, -1);
			//Audio.ChangeMusic(IntroMusicLoop);
			rope.SetTrack(1);
		}
		
		public function Tick(e:Event):void {
			time = time + dt;
			world.Step(dt, 5, 5);
		}
		
		public function CreateStaticBody(_mc:MovieClip, _groupIndex:int = 0) {
			var bodyDef:b2BodyDef = new b2BodyDef;
			bodyDef.position = new b2Vec2(_mc.x * Game.ToBox, _mc.y * Game.ToBox);
			bodyDef.linearDamping = 0.0;
			bodyDef.angularDamping = 0.0;
			bodyDef.type = b2Body.b2_staticBody;
			var body:b2Body = world.CreateBody(bodyDef);
			
			var polygonShape:b2PolygonShape = new b2PolygonShape;
			var ex:Number = _mc.width * 0.5;
			var ey:Number = _mc.height * 0.5;
			polygonShape.SetAsBox(ex * Game.ToBox, ey * Game.ToBox);
			var fixtureDef:b2FixtureDef = new b2FixtureDef;
			fixtureDef.shape = polygonShape;
			fixtureDef.density = 1;
			fixtureDef.restitution = 0.5;
			fixtureDef.friction = 0.5;
			fixtureDef.filter.groupIndex = _groupIndex;
			var fixture:b2Fixture = body.CreateFixture(fixtureDef);
			fixture.SetRestitution(0);
			addEventListener(Event.ENTER_FRAME, Tick, false, 0, true);
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






















