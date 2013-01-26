package  {
	import Box2D.Collision.b2Bound;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Contacts.b2ContactEdge;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Heart extends MovieClip {
		var ex:Number = 0;
		var ey:Number = 0;
		var movingLeft:Boolean = false;
		var movingRight:Boolean = false;
		var body:b2Body = null;
		var playing:Boolean = false;
		
		public function Heart() {		
			var bodyDef:b2BodyDef = new b2BodyDef;
			bodyDef.position = new b2Vec2(x * Game.ToBox, y * Game.ToBox);
			bodyDef.linearDamping = 0.0;
			bodyDef.angularDamping = 0.0;
			bodyDef.type = b2Body.b2_dynamicBody;
			body = Game.instance.world.CreateBody(bodyDef);
			body.SetUserData(this);
			
			var polygonShape:b2PolygonShape = new b2PolygonShape;
			ex = width * 0.5;
			ey = height * 0.5;
			polygonShape.SetAsBox(ex * Game.ToBox, ey * Game.ToBox);
			var fixtureDef:b2FixtureDef = new b2FixtureDef;
			fixtureDef.shape = polygonShape;
			fixtureDef.density = 1;
			fixtureDef.restitution = 0.5;
			fixtureDef.friction = 0.5;
			var fixture:b2Fixture = body.CreateFixture(fixtureDef);
			fixture.SetRestitution(0);
			addEventListener(Event.ENTER_FRAME, Tick, false, 0, true);
			trace("Heart starts");
		}
		
		public function Tick(e:Event):void {
			DoInputMotion();
			x = body.GetPosition().x * Game.ToFlash;
			y = body.GetPosition().y * Game.ToFlash;
			if (body.GetLinearVelocity().x <= 0)
				scaleX = 1;
			else
				scaleX = -1;
			if ((movingLeft || movingRight) && !playing) {
				gotoAndPlay(4);
				playing = true;
			}
			else {
				playing = false;
				gotoAndStop(3);
			}
		}
		
		public function DoInputMotion() {
			if (movingRight) {
				body.ApplyImpulse(new b2Vec2(3000, 0), body.GetPosition());
			} else if (movingLeft) {
			    body.ApplyImpulse(new b2Vec2( -3000, 0), body.GetPosition());
			}
		}
		
		public function StartMoving() {
			movingRight = true;
		}
		
		public function StopMoving() {
		    movingRight = false;
		}
		
		public function Jump() {
			var v:b2Vec2 = body.GetLinearVelocity();
			var contacts:b2ContactEdge = body.GetContactList();
			if (contacts) {
				body.SetLinearVelocity(new b2Vec2(v.x, -10000));
			}
		}
	}
}