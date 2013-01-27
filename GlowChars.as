package  {
	import flash.display.MovieClip;
	import Box2D.Collision.b2Bound;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Contacts.b2ContactEdge;
	import flash.events.Event;
	
	public class GlowChars extends Item {
		var ex:Number = 0;
		var ey:Number = 0;
		var body:b2Body = null;
		
		public function GlowChars() {
			
		}
		
		public function MakeIntoPhysicsObject():void {
			var bodyDef:b2BodyDef = new b2BodyDef;
			bodyDef.position = new b2Vec2(x * Game.ToBox, y * Game.ToBox);
			bodyDef.linearDamping = 0.0;
			bodyDef.angularDamping = 0.0;
			bodyDef.type = b2Body.b2_dynamicBody;
			body = Game.instance.world.CreateBody(bodyDef);
			body.SetUserData(this);
			
			var polygonShape:b2PolygonShape = new b2PolygonShape;
			ex = 25 * 0.5;
			ey = 25 * 0.5;
			polygonShape.SetAsBox(ex * Game.ToBox, ey * Game.ToBox);
			var fixtureDef:b2FixtureDef = new b2FixtureDef;
			fixtureDef.shape = polygonShape;
			fixtureDef.density = 1;
			fixtureDef.restitution = 0.5;
			fixtureDef.friction = 0.5;
			var fixture:b2Fixture = body.CreateFixture(fixtureDef);
			fixture.SetRestitution(0);
			addEventListener(Event.ENTER_FRAME, Tick, false, 0, true);
		}
		
		public function Tick(e:Event):void {
			body.ApplyImpulse(new b2Vec2(0, 50), body.GetPosition());
			x = body.GetPosition().x * Game.ToFlash;
			y = body.GetPosition().y * Game.ToFlash;
			rotation = Misc.ToDegrees(body.GetAngle());
		}
	}
}






















