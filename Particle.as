// note: for Lua, may need to use a group because the rotation here, needs to be done on the MC

package  {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	public class Particle extends MovieClip {
		var in_posx:Number = 0;
		var in_posy:Number = 0;
		var in_velx:Number = 0;
		var in_vely:Number = 0;
		
		var posx0:Number = 0;
		var posy0:Number = 0;
		var posx1:Number = 0;
		var posy1:Number = 0;
		var posx:Number = 0;
		var posy:Number = 0;
		var velx:Number = 0;
		var vely:Number = 0;
		var ax:Number = 0;
		var ay:Number = 0;
		var maxage:Number = 0;
		var age:Number = 0;
		var dRotation:Number = 0;
		var respawn:Boolean = false;
		var alpha0:Number = 1;
		var alpha1:Number = 0;
		var scale0:Number = 1;
		var scale1:Number = 0;
		var rotation0:Number = 0;
		var rotation1:Number = 0;
		
		public function Particle(_frame:int) {
			gotoAndStop(_frame);
			//mc.cacheAsBitmap = true;
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		public function Save():void {
			in_posx = posx;
			in_posy = posy;
			in_velx = velx;
			in_vely = vely;
		}
		
		public function Spawn():void {
			age = 0;
			posx = Misc.Lerp(posx0, posx1, Math.random());
			posy = Misc.Lerp(posy0, posy1, Math.random());
			dRotation = Misc.Lerp(rotation0, rotation1, Math.random());
			Update();
		}
		
		public function Update():void {
			age += Game.dt;
			posx += velx * Game.dt;
			posy += vely * Game.dt;
			velx += ax * Game.dt;
			vely += ay * Game.dt;
			rotation += dRotation * Game.dt;
			var t:Number = Misc.Clamp(age / maxage, 0, 1);
			//mc.alpha = Misc.Clamp(Misc.Lerp(alpha0, alpha1, t), 0, 1);
			alpha = Misc.Clamp(Misc.Lerp(alpha0, alpha1, t), 0, 1);
			scaleX = scaleY = Misc.Clamp(Misc.Lerp(scale0, scale1, t*t), 0, 1);
			
			if (age >= maxage) {
				if (respawn) {
					posx = in_posx;
					posy = in_posy;
					velx = in_velx;
					vely = in_vely;
					scaleX = scaleY = 1;
					Spawn();
					alpha = 0; // avoid first frame artifacts
				}
				else {
					visible = false;
				}
			}
			x = posx;
			y = posy;
		}
	}
}