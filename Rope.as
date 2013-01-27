package  {
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	public class Rope extends MovieClip {
		var segments:Array = new Array;
		var leftSegment:RopeSegment = null;
		var tugSegment:RopeSegment = null;
		var currSegmentPos:Point = new Point;
		var sinTime:Number = 0;
		var amp:Number = 0;
		var sinSpeed:Number = 0;
		var pullSegments:Array = new Array;
		
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
				var t:Number = i / (segments.length - 1.0);
				//segments[i].Init(i == 0 || i == segments.length - 1);
				segments[i].Init(i == 0, Misc.Lerp(20, 20, t));
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
			
			tugSegment = segments[i - 1];
			leftSegment = segments[0];
			currSegmentPos.x = tugSegment.initialx;
			currSegmentPos.y = tugSegment.initialy;
			
			/*
			for (i = 0; i < 8; i++) {
				var index:int = Math.floor(segments.length * i / 4.0);
				if (index == segments.length)
					index = segments.length - 1;
				pullSegments.push(segments[index]);
			}
			*/
			
			addEventListener(Event.ENTER_FRAME, Tick, false, 0, true);
		}
		
		public function CreateRevolute(_seg1:RopeSegment, _seg2:RopeSegment):void {
			// assumes seg1 is directly to the left of seg2
			var revDef:b2RevoluteJointDef = new b2RevoluteJointDef;
			//revDef.Initialize(_body.body, nodeBody, new b2Vec2(_anchor.x * T.ToBox, _anchor.y * T.ToBox));
			revDef.Initialize(_seg1.body, _seg2.body, new b2Vec2((_seg1.x + _seg1.ex) * Game.ToBox, (_seg2.y + _seg2.ey) * Game.ToBox));
			revDef.collideConnected = false;
			revDef.lowerAngle = -Math.PI * 0.1;
			revDef.upperAngle = Math.PI * 0.1;
			var rev:b2RevoluteJoint = b2RevoluteJoint(Game.instance.world.CreateJoint(revDef));
		}
		
		var beats:Array = null;
		var track:int = 0;
		var trackLength:Number = 0;
		var currBeatIndex:int = 0;
		var nextBeat:Number = 0;
		var beatDelay:Number = 0;
		var sign:Number = 1;
		public function SetTrack(_track:int):void {
			track = _track;
			currBeatIndex = 0;
			nextBeat = 0;
			if (_track == 1) {
				trackLength = Audio.ChangeMusic(Soundtrack);
				beats = new Array(1, 2, 3, 4, 5, 6);
				beatDelay = 1.0;
			}
			else if (_track == 2) {
				
			}
			else if (_track == 3) {
				
			}
		}
		
		public function OnNewGame():void {
			var i:int;
			for (i = 0; i < segments.length; i++) {
				segments[i].SetPosition(segments[i].initialx, segments[i].initialy);
				segments[i].SetVelocity(0, 0);
			}
			leftSegment.body.SetType(b2Body.b2_staticBody);
			tugSegment.body.SetType(b2Body.b2_staticBody);
		}
		
		const sinTimeDelay:Number = Math.PI * 4.25;
		public function Tick(e:Event):void {
			var i:int;
			var t:Number = 0;
			
			if (!Game.instance.gameStarted)
				return;
			
			if (Game.instance.gameOver && Game.instance.gameOverTime > 3) {
			}
			else {
				tugSegment.SetPosition(tugSegment.initialx, tugSegment.initialy);	
				if (beats && nextBeat < Game.instance.time) {
					//currSegmentPos.x = tugSegment.initialx;
					//currSegmentPos.y = tugSegment.initialy + Misc.Random(-500, 500);
					nextBeat = Game.instance.time + beatDelay;
					currBeatIndex = (currBeatIndex + 1) % beats.length;
					sinSpeed = Math.PI*2.0 / beatDelay;
					sinTime = 0;
					amp = 350;
					//sign *= -1;
				}
				if (sinTime < Math.PI * 2.0) {
					sinTime = sinTime + sinSpeed * Game.dt;
					var val:Number = Math.sin(sinTime) * amp;
					
					for (i = 0; i < segments.length; i++) {
						t = i / Number(segments.length - 1);
						var timeOffset:Number = Misc.Lerp(sinTimeDelay, 0, t);
						var finalTime:Number = Misc.Clamp(sinTime - timeOffset, -Math.PI * 2.0, Math.PI * 2.0);
						val = Math.sin(finalTime) * amp * sign;
						//segments[i].SetPosition(segments[i].initialx, segments[i].initialy + val);
						//segments[i].ApplyForce(0, val * 100);
						segments[i].SetVelocity(0, val);
					}
					// keep tugsement position constant
					tugSegment.SetPosition(tugSegment.initialx, tugSegment.initialy);
					
					//tugSegment.SetPosition(tugSegment.initialx, tugSegment.initialy - val);
					//for (i = 0; i < pullSegments.length; i++) {
						//if (i%2)
						//	pullSegments[i].SetPosition(pullSegments[i].initialx, pullSegments[i].initialy - val);
						//else
						//	pullSegments[i].SetPosition(pullSegments[i].initialx, pullSegments[i].initialy + val);
					//}
					sinTime += Game.dt;
				}
			}
		}
	}
}












