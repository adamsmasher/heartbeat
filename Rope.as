package  {
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import flash.display.MovieClip;
	public class Rope extends MovieClip {
		var segments:Array = new Array;
		public function Rope() {
			var i:int;
			// sort all segments left to right
			while (true) {
				var next:RopeSegment = null;
				for (i = 0; i < numChildren; i++) {
					var other:RopeSegment = RopeSegment(getChildAt(i));
					if (!other.used) {
						if (next == null || other.x < next.x) {
							next = other;
						}
					}
				}
				if (next) {
					next.used = true;
					segments.push(next);
				}
				else {
					break;
				}
			}
			
			for (i = 0; i < segments.length; i++) {
				segments[i].Init(i == 0 || i == segments.length - 1);
			}
			
			for (i = 0; i < segments.length; i++) {
				var left:int = i - 1;
				var mid:int = i;
				var right:int = i + 1;
				if (left >= 0 && left < segments.length) {
					CreateRevolute(segments[left], segments[mid]);
				}
				if (right >= 0 && right < segments.length) {
					CreateRevolute(segments[mid], segments[right]);
				}
			}
		}
		
		public function CreateRevolute(_seg1:RopeSegment, _seg2:RopeSegment):void {
			// assumes seg1 is directly to the left of seg2
			var revDef:b2RevoluteJointDef = new b2RevoluteJointDef;
			//revDef.Initialize(_body.body, nodeBody, new b2Vec2(_anchor.x * T.ToBox, _anchor.y * T.ToBox));
			revDef.Initialize(_seg1.body, _seg2.body, new b2Vec2((_seg1.x + _seg1.ex) * Game.ToBox, (_seg2.y + _seg2.ey) * Game.ToBox));
			revDef.collideConnected = false;
			var rev:b2RevoluteJoint = b2RevoluteJoint(Game.instance.world.CreateJoint(revDef));
		}
	}
}
