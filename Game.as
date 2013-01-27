package  {
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	public class Game extends MovieClip {
		var world:b2World = null;
		var time:Number = 0;
		var items:Array = new Array;
		var script:Script = new Script();

		public static const Color_Red:int = 1;
		public static const Color_Blue:int = 2;

		public static var StageWidth:Number = 800;
		public static var StageHeight:Number = 500;
		public static var ToBox:Number = 1.0 / 4.0;
		public static var ToFlash:Number = 1.0 / ToBox;
		public static var instance:Game = null;
		public static var dt:Number = 1.0 / 30.0;
		public static var gameOver:Boolean = false;
		public static var heartDistanceJoint:b2DistanceJoint;

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
		
		public function DoGameOver():void {
			if (!gameOver) {
				gameOver = true;
			}
		}
		
		public function Init():void {
			SoundEffects.Init();
			world = new b2World(new b2Vec2(0, 0), false);
			world.SetContactListener(new ItemContactListener());
			addEventListener(Event.ENTER_FRAME, Tick, false, 0, true);
			gotoAndStop(2);
			CreateStaticBody(topborder, -1);
			//CreateStaticBody(bottomborder, -1);
			CreateStaticBody(leftborder, -1);
			CreateStaticBody(rightborder, -1);
			//Audio.ChangeMusic(IntroMusicLoop);
			rope.SetTrack(1);
			square.other = square2;
			square2.other = square;	
			square.color = Color_Red;
			square2.color = Color_Blue;
			square.face.gotoAndStop(1);
			square2.face.gotoAndStop(2);
			
			new MiniRope(square, square2);
		}
		
		public function Tick(e:Event):void {
			time = time + dt;
			ApplyGravity();
			UpdateScoreCard();
			script.Tick();
			world.Step(dt, 10, 10);
			for (var i = 0; i < items.length; i++) {
				items[i].timeAlive++;
			}
		}
		
		public function UpdateScoreCard() {
			p1Score.text = square.score.toString();
			p2Score.text = square2.score.toString();
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
			CheckForP1Down(e.keyCode);
			CheckForP2Down(e.keyCode);
		}
		
		public function CheckForP1Down(keyCode:uint) {
			HeartKeyDown(square, keyCode, Keyboard.LEFT, Keyboard.RIGHT, Keyboard.UP);
		}
		
		public function CheckForP2Down(keyCode:uint) {
			HeartKeyDown(square2, keyCode, Keyboard.A, Keyboard.D, Keyboard.W);
		}
		
		public function HeartKeyDown(heart:Heart, keyCode:uint, leftKeyCode:uint, rightKeyCode:uint, jumpKeyCode:uint) {
			if (keyCode == leftKeyCode) {
				heart.movingLeft = true;
			} else if (keyCode == rightKeyCode) {
				heart.movingRight = true;
			} else if (keyCode == jumpKeyCode) {
				heart.Jump();
			}
		}
		
		public function KeyUp(e:KeyboardEvent) {
			CheckForP1Up(e.keyCode);
			CheckForP2Up(e.keyCode);
		}
		
		public function CheckForP1Up(keyCode:uint) {
			HeartKeyUp(square, keyCode, Keyboard.LEFT, Keyboard.RIGHT);
		}
		
		public function CheckForP2Up(keyCode:uint) {
			HeartKeyUp(square2, keyCode, Keyboard.A, Keyboard.D);
		}
		
		public function HeartKeyUp(heart:Heart, keyCode:uint, leftKeyCode:uint, rightKeyCode:uint) {
			if (keyCode == leftKeyCode) {
				heart.movingLeft = false;
			} else if (keyCode == rightKeyCode) {
				heart.movingRight = false;
			}
		}

		public function ApplyGravity() {
			square.body.ApplyImpulse(new b2Vec2(0, 1000), square.body.GetPosition());
			square2.body.ApplyImpulse(new b2Vec2(0, 1000), square2.body.GetPosition());
		}
		
		public function MakeGlowText(_x:Number, _y:Number, _text:String, _color:int):void {			
			var i:int;
			var xoffset:Number = 0;
			for (i = 0; i < _text.length; i++) {
				var code:int = _text.charCodeAt(i);
				// spacebar
				if (code == 32) {
					xoffset += 10;
				}
				else {
					var char:GlowChars = new GlowChars(_color);
					char.x = _x + xoffset;
					char.y = _y;
					// ABCDEF... to 12345...
					char.gotoAndStop(_color);
					char.base.gotoAndStop(code - 65 + 1);
					addChild(char);
					xoffset += char.width * 1.1;
					char.MakeIntoPhysicsObject();
				}
			}
		}
	}
}

















