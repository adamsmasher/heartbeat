package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	public class ParticleEffect extends Sprite {
		var particles:Array = new Array;
		var maxage:Number = 0;
		var age:Number = 0;
		var alpha0:Number = 1;
		var alpha1:Number = 0;
		
		static function Default(_x:Number, _y:Number, _ex:Number, _ey:Number, 
		_speed:Number, _frame:int, _maxAge:Number = 2, _count:int = 8, _rotation:Number = 80, _scale1:Number = 0, _alpha1:Number = 1):ParticleEffect {
			var peff:ParticleEffect = new ParticleEffect;
			var i:int;
			var p:Particle;
			
			//count = 6;
			for (i = 0; i < _count; i++) {
				p = new Particle(_frame);
				peff.particles.push(p);
				p.posx0 = _x - _ex;
				p.posx1 = _x + _ex;
				p.posy0 = _y - _ey;
				p.posy1 = _y + _ey;
				p.velx = Misc.Random( -0.25, 0.25) * _speed * Math.random();
				p.vely = Misc.Random( -0.25, 0.25) * _speed * Math.random();
				p.rotation0 = -_rotation;
				p.rotation1 = _rotation;
				p.scale1 = _scale1;
				p.alpha1 = _alpha1;
				p.maxage = Misc.Random(0.75, 1.25) * _maxAge;
				p.respawn = false;
				p.Save();
				p.Spawn();
				peff.addChild(p);
			}
			
			peff.alpha0 = 1;
			
			return peff;
		}
		
		public function ParticleEffect() {
			Game.instance.addChild(this);
			addEventListener(Event.ENTER_FRAME, Tick);
		}
		
		public function Kill():void {
			Misc.RemoveSpriteIfInside(this, Game.instance);
		}
		
		public function Tick(e:Event):void {
			var i:int;
			
			age += Game.dt;
			if (maxage != 0.0) {
				var t:Number = age / maxage;
				alpha = Misc.Clamp(Misc.Lerp(alpha0, alpha1, t), 0, 1);
				if (age >= maxage) {
					Kill();
				}
			}
			
			var numActive:int = 0;
			for (i = 0; i < particles.length; i++) {
				particles[i].Update();
				if (particles[i].visible)
					numActive++;
			}
			if (numActive == 0) {
				Kill();
			}
		}
	}
}
















