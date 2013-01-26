package  {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import flash.geom.Matrix;
	import flash.geom.Point;
	//import Playtomic.*;
	
	public class Misc {
		public function Misc() {
		}
		
		public static const Epsilon:Number = 0.00001;
		public static const BigInt:int = 999999;
		public static var id:int = 0;
		
		public static function GetID():int {
			id++;
			return id;
		}
		
		public static function Angle(_val:Number):Number {
			return -_val;
		}
		
		public static function ToDegrees(_val:Number):Number {
			return _val * 180.0 / Math.PI;
		}
		
		public static function ToRadians(_val:Number):Number {
			return _val * Math.PI / 180.0;
		}
		
		public static function Clamp(_val:Number, _min:Number, _max:Number):Number {
			if (_val < _min)
				return _min;
			if (_val > _max)
				return _max;
			return _val;
		}
		
		public static function ClampInt(_val:int, _min:int, _max:int):int {
			if (_val < _min)
				return _min;
			if (_val > _max)
				return _max;
			return _val;
		}
		
		public static function Sat(_val:Number):Number {
			if (_val < 0)
				return 0;
			if (_val > 1)
				return 1;
			return _val;
		}
		
		public static function Saturate(_val:Number):Number {
			if (_val < 0)
				return 0;
			if (_val > 1)
				return 1;
			return _val;
		}
		
		public static function Sign(_val:Number):Number {
			if (_val >= 0)
				return 1;
			return -1;
		}
		
		public static function CompFloat(_a:Number, _b:Number) {
			return Math.abs(_a - _b) < Epsilon;
		}
		
		public static function CompFloatWithin(_x:Number, _a:Number, _b:Number):Boolean {
			return (_x + Epsilon >= _a && _x - Epsilon <= _b);
		}
		
		public static function IsDigit(_c:int):Boolean {
			return _c >= 48 && _c <= 57;
		}
		
		public static function IsLetter(_c:int):Boolean {
			return (_c >= 65 && _c <= 90) || (_c >= 97 && _c <= 122);
		}
		
		public static function SetDamageTint(_obj:DisplayObject, _amt:Number):void {
			var ctrans:ColorTransform = _obj.transform.colorTransform;
			var invRedness:Number = _amt * 0.2;
			ctrans.greenMultiplier = 1.0 - invRedness;
			ctrans.blueMultiplier = 1.0 - invRedness;
			ctrans.redMultiplier = 1.0 + _amt * 0.9;
			_obj.transform.colorTransform = ctrans;
		}
		
		public static function Random(_x0:Number, _x1:Number):Number {
			return _x0 + Math.random() * (_x1 - _x0);
		}
		
		public static function RandomSign():Number {
			if (Math.random() < 0.5)
				return 1;
			return -1;
		}
		
		public static function RandomInt(_x0:int, _x1:int):int {
			//return _x0 + Math.floor((Math.random() * (_x1 - _x0)) + 0.5);
			return _x0 + Math.floor((Math.random() * (_x1 - _x0 + 1)));
		}
		
		public static function Roll(_outof:int):Boolean {
			return (RandomInt(1, _outof) == 1);
		}
		
		/*
		public static function SortActors(_layer:Sprite):void {
			_layer
		}
		
		public static function RemoveActor(_item:Actor, _array:Array):Boolean {
			if (_item == null || _array == null)
				return false;
			var i:int;
			for (i = 0; i < _array.length; i++) {
				if (_array[i] == _item) {
					_array.splice(i, 1);
					return true;
				}
			}
			return false;
		}
		*/
		
		public static function RemoveAll(_sprite:Sprite):void {
			while (_sprite.numChildren > 0)
				_sprite.removeChildAt(0);
		}
		
		public static function Length(_x:Number, _y:Number):Number {
			return Math.sqrt(_x * _x + _y * _y);
		}
		
		public static function Length2(_x:Number, _y:Number):Number {
			return _x * _x + _y * _y;
		}
		
		public static function Contains(_array:Array, _item:Object):Boolean {
			var i:int;
			for (i = 0; i < _array.length; i++) {
				if (_array[i] == _item) {
					return true;
				}
			}
			return false;
		}
		
		public static function PointInside(_x:Number, _y:Number, _mc:MovieClip):Boolean {
			if(_x >= _mc.x - _mc.width &&
				_x <= _mc.x + _mc.width &&
				_y >= _mc.y - _mc.height &&
				_y <= _mc.y + _mc.height)
			{
				return true;
			}
			return false;
		}
		
		public static function PointInsideAABB(_x:Number, _y:Number, _mc:MovieClip, _epsilon:Number = 0.0):Boolean {				
			var p:Point = _mc.localToGlobal(new Point);
			var hx:Number = _mc.width * 0.5;
			var hy:Number = _mc.height * 0.5;
			var xmin:Number = p.x - (hx + _epsilon);
			var xmax:Number = p.x + (hx + _epsilon);
			var ymin:Number = p.y - (hy + _epsilon);
			var ymax:Number = p.y + (hy + _epsilon);
			return (_x >= xmin && _x <= xmax && _y >= ymin && _y <= ymax);
		}
		
		public static function PointInsideAABB2(_x:Number, _y:Number, _collx:Number, _colly:Number, _collWidth:Number, _collHeight:Number, _epsilon:Number = 0.01):Boolean {
			var hx:Number = _collWidth * 0.5;
			var hy:Number = _collHeight * 0.5;
			var xmin:Number = _collx - (hx + _epsilon);
			var xmax:Number = _collx + (hx + _epsilon);
			var ymin:Number = _colly - (hy + _epsilon);
			var ymax:Number = _colly + (hy + _epsilon);
			return (_x >= xmin && _x <= xmax && _y >= ymin && _y <= ymax);
		}
		
		public static function lineIntersectLine(Ax:Number,Ay:Number,Bx:Number,By:Number,Ex:Number,Ey:Number,Fx:Number,Fy:Number,as_seg:Boolean=true):Point {
			var ipx:Number = 0;
			var ipy:Number = 0;
			var a1:Number = 0;
			var a2:Number = 0;
			var b1:Number = 0;
			var b2:Number = 0;
			var c1:Number = 0;
			var c2:Number = 0;
		 
			a1= By-Ay;
			b1= Ax-Bx;
			c1= Bx*Ay - Ax*By;
			a2= Fy-Ey;
			b2= Ex-Fx;
			c2= Fx*Ey - Ex*Fy;
		 
			var denom:Number=a1*b2 - a2*b1;
			if (denom == 0) {
				return null;
			}
			ipx=(b1*c2 - b2*c1)/denom;
			ipy=(a2*c1 - a1*c2)/denom;
		 
			//---------------------------------------------------
			//Do checks to see if intersection to endpoints
			//distance is longer than actual Segments.
			//Return null if it is with any.
			//---------------------------------------------------
			if(as_seg){
				if(Math.pow(ipx - Bx, 2) + Math.pow(ipy - By, 2) > Math.pow(Ax - Bx, 2) + Math.pow(Ay - By, 2))
				{
				   return null;
				}
				if(Math.pow(ipx - Ax, 2) + Math.pow(ipy - Ay, 2) > Math.pow(Ax - Bx, 2) + Math.pow(Ay - By, 2))
				{
				   return null;
				}
		 
				if(Math.pow(ipx - Fx, 2) + Math.pow(ipy - Fy, 2) > Math.pow(Ex - Fx, 2) + Math.pow(Ey - Fy, 2))
				{
				   return null;
				}
				if(Math.pow(ipx - Ex, 2) + Math.pow(ipy - Ey, 2) > Math.pow(Ex - Fx, 2) + Math.pow(Ey - Fy, 2))
				{
				   return null;
				}
			}
			return new Point(ipx, ipy);
		}
		
		public static function BoxTest(_x1:Number, _y1:Number, _ex1:Number, _ey1:Number, _x2:Number, _y2:Number, _ex2:Number, _ey2:Number):Boolean {
			// check if box1 is to the left
			if (_x1 + _ex1 < _x2 - _ex2)
				return false;
			// check if box1 is to the right
			if (_x1 - _ex1 > _x2 + _ex2)
				return false;
			// check if box1 is above
			// note: using flipped y coordinates
			if (_y1 + _ey1 < _y2 - _ey2)
				return false;
			// check if box1 is below
			// note: using flipped y coordinates
			if (_y1 - _ey1 > _y2 + _ey2)
				return false;
			// otherwise, these two boxes must be overlapping
			return true;
		}
		
		public static function Dot(_x1:Number, _y1:Number, _x2:Number, _y2:Number):Number {
			return _x1 * _x2 + _y1 * _y2;
		}
		
		public static function RayCircle(
			_circlex:Number, 
			_circley:Number, 
			_rad:Number, 
			_line1x:Number, 
			_line1y:Number, 
			_line2x:Number, 
			_line2y:Number):Boolean
		{
			var ab2:Number;
			var acab:Number;
			var h2:Number;
			var acx:Number = _circlex - _line1x;
			var acy:Number = _circley - _line1y;
			var abx:Number = _line2x - _line1x;
			var aby:Number = _line2y - _line1y;
			ab2 = Dot(abx, aby, abx, aby);
			acab = Dot(acx, acy, abx, aby);
			var t:Number = acab / ab2;
			t = Saturate(t);
			
			var hx:Number = (abx * t + _line1x) - _circlex;
			var hy:Number = (aby * t + _line1y) - _circley;
			h2 = Misc.Dot(hx, hy, hx, hy);
			
			return h2 <= _rad * _rad;
		}

		/*
		 * public static bool IntersectLineCircle(Vector2 location, float radius, Vector2 lineFrom, Vector2 lineTo)
		{
			float ab2, acab, h2;
			Vector2 ac = location - lineFrom;
			Vector2 ab = lineTo - lineFrom;
			Vector2.Dot(ref ab, ref ab, out ab2);
			Vector2.Dot(ref ac, ref ab, out acab);
			float t = acab / ab2;

			if (t < 0)
				t = 0;
			else if (t > 1)
				t = 1;

			Vector2 h = ((ab * t) + lineFrom) - location;
			Vector2.Dot(ref h, ref h, out h2);

			return (h2 <= (radius * radius));
		}
		*/
		
		// Attaches _mcChild to _mcParent while preserving the current position and rotation of the child.
		// That way, the child takes any additional transformation to the parent into consideration.
		public static function Attach(_mcChild:MovieClip, _mcParent:MovieClip):void {
			var pos:Point = new Point(_mcChild.x, _mcChild.y);
			var oldRot:Number = _mcChild.rotation;
			pos = _mcParent.globalToLocal(pos);
			_mcParent.addChild(_mcChild);
			_mcChild.rotation = oldRot;
			_mcChild.x = pos.x;
			_mcChild.y = pos.y;
		}
		
		public static function RandomizeFrame(_mc:MovieClip):int {
			_mc.gotoAndStop(Math.floor(1 + Math.random() * _mc.totalFrames) as int);
			return _mc.currentFrame;
		}
		
		public static function GetCenter(_mc:Sprite):Point {
			return new Point(_mc.x + _mc.width * 0.5, _mc.y + _mc.height * 0.5);
		}
		
		public static function Dist2(_x0:Number, _y0:Number, _x1:Number, _y1:Number):Number {
			var xd:Number = _x1 - _x0;
			var yd:Number = _y1 - _y0;
			return xd * xd + yd * yd;
		}
		
		public static function Dist(_x0:Number, _y0:Number, _x1:Number, _y1:Number):Number {
			var xd:Number = _x1 - _x0;
			var yd:Number = _y1 - _y0;
			return Math.sqrt(xd * xd + yd * yd);
		}
		
		public static function Lerp(_x0:Number, _x1:Number, _t:Number):Number {
			return _x0 + (_x1 - _x0) * _t;
		}
		
		// Does not take into consideration the owner of the _mc.
		// Assumes the _mc at 0 is the origin x
		public static function SnapToCenterX(_mc:Sprite, _mcParent:Sprite):void {
			_mc.x = (_mcParent.width - _mc.width ) * 0.5;
		}
		
		// Does not take into consideration the owner of the _mc.
		// Assumes the _mc at 0 is the origin y
		public static function SnapToCenterY(_mc:Sprite, _mcParent:Sprite):void {
			_mc.y = (_mcParent.height - _mc.height ) * 0.5;
		}
		
		public static function Remove(_item:Class, _array:Array):int {
			var i:int = 0;
			var count:int = 0;
			while (i < _array.length) {
				if (_array[i] == _item) {
					_array.splice(i, 1);
					count++;
				}
				else
					i = i + 1;
			}
			return count;
		}
		
		/*
		// What is a better way of doing this, rather than copying and pasting?
		public static function RemoveJoint(_item:b2Joint, _array:Array):int {
			var i:int = 0;
			var count:int = 0;
			while (i < _array.length) {
				if (_array[i] == _item) {
					_array.splice(i, 1);
					count++;
				}
				else
					i = i + 1;
			}
			return count;
		}
		*/
		
		public static function FindMovieClip(_mc:MovieClip, _name:String):MovieClip {
			var i:int;
			var obj:DisplayObject;
			var mc:MovieClip;
			if (_mc == null) {
				trace("could not find MovieClip " + _name + " because parent was null");
				return null;
			}
			for (i = 0; i < _mc.numChildren; i++) {
				obj = _mc.getChildAt(i);
				//var classname:String = getQualifiedClassName(obj);
				//if (classname == "flash.display::MovieClip") {
				mc = obj as MovieClip;
				if (mc != null && mc.name == _name)
					return mc;
				//}
			}
			return null;
		}
		
		public static function getClass(obj:Object):Class {
			return Class(getDefinitionByName(getQualifiedClassName(obj)));
		}
		
		public static function FindButton(_mc:MovieClip, _name:String):SimpleButton {
			var i:int;
			var obj:DisplayObject;
			var button:SimpleButton;
			for (i = 0; i < _mc.numChildren; i++) {
				obj = _mc.getChildAt(i);
				if (getQualifiedClassName(obj) == "flash.display::SimpleButton") {
					button = obj as SimpleButton;
					if (button.name == _name)
						return button;
				}
			}
			return null;
		}

		static const SpasmMaxTime:Number = Math.PI * 2.0;
		public static function AnimSpasmTick(_sprite:Sprite, _scaleX:Number, _scaleY:Number, _amp:Number, _speed:Number, _time:Number):Number {
			_time += Game.dt * _speed;
			var t:Number = Clamp(_time / SpasmMaxTime, 0, 1)
			var amp:Number = _amp * (1 - Math.pow(t, 8))
			var scale:Number = 1 + Math.sin(_time) * amp;
			_sprite.scaleX = scale * _scaleX;
			_sprite.scaleY = scale * _scaleY;
			return _time;
		}
		
		public static function AnimSpasmTick_JustY(_sprite:Sprite, _scaleY:Number, _amp:Number, _time:Number):Number {
			_time += Game.dt * 20;
			var t:Number = Clamp(_time / SpasmMaxTime, 0, 1)
			var amp:Number = _amp * (1 - Math.pow(t, 8))
			var scale:Number = 1 + Math.sin(_time) * amp;
			_sprite.scaleY = scale * _scaleY;
			return _time;
		}
		
		public static function RemoveSpriteIfInside(_sprite:Sprite, _other:Sprite):Boolean {
			if (_sprite == null || _other == null)
				return false;
				
			var i:int;
			for (i = 0; i < _other.numChildren; i++) {
				if (_other.getChildAt(i) == _sprite) {
					_other.removeChild(_sprite);
					return true;
				}
			}
			return false;
		}
		
		//-----------------------------------------------------
		
		public static function CommonRollOver(e:MouseEvent):void {
			e.target.scaleX = e.target.scaleY = 1.05;
		}
		
		public static function CommonRollOut(e:MouseEvent):void {
			e.target.scaleX = e.target.scaleY = 1.0;
		}
		
		public static function BaseFrameRollOver(e:MouseEvent):void {
			e.target.kBase.gotoAndStop(2);
		}
		
		public static function BaseFrameRollOut(e:MouseEvent):void {
			e.target.kBase.gotoAndStop(1);
		}
		
		//-----------------------------------------------------
		
		public static function RollOverMenuButton(e:MouseEvent):void {
			e.target.kBase.gotoAndStop(2);
		}
		
		public static function RollOutMenuButton(e:MouseEvent):void {
			e.target.kBase.gotoAndStop(1);
		}
		
		//-----------------------------------------------------
		
		public static function RandomArrayObj(_arr:Array):Object {
			if (_arr.length > 0)
				return _arr[RandomInt(0, _arr.length - 1)];
			else
				return null;
		}
		
		//public static function CommonSinWaveScale():Number {
		//	var s:Number = Math.sin(Game.Instance.time * 3);
		//	return 1 + s * s * 0.07;
		//}
		
		// steps from _x0 to _x1 by _diff
		// _diff is assumed to be absolute value
		public static function Step(_x0:Number, _x1:Number, _diff:Number):Number {
			if (Math.abs(_x1 - _x0) <= _diff)
				return _x1;
			return _x0 + _diff * Sign(_x1 - _x0);
		}
		
		public static function Stat_Custom(_name:String):void {
			//Log.CustomMetric(_name);
			//Log.ForceSend();
		}
		
		public static function Stat_Counter(_name:String, _num:int):void {
			//Log.LevelCounterMetric(_name, _num);
			//Log.ForceSend();
		}
		
		public static function Stat_AverageForLevel(_name:String, _level:int, _num:Number):void {
			//Log.LevelAverageMetric(_name, _level, _num);
			//Log.ForceSend();
		}
		
		public static function Stat_AverageForLevelInt(_name:String, _level:int, _num:int):void {
			//Log.LevelAverageMetric(_name, _level, _num);
			//Log.ForceSend();
		}
		
		/*
		public static function ZoomMod(_layer:Sprite, _scale:Number):void {
			var aff:Matrix = _layer.transform.matrix;
			var origin:Point = new Point(Game.StageWidth * 0.5, Game.StageHeight * 0.5);
			aff.translate( -origin.x, -origin.y);
			aff.scale(_scale, _scale);
			aff.translate(origin.x, origin.y);
			_layer.transform.matrix = aff;
		}
		
		public static function ZoomAdd(_layer:Sprite, _scale:Number):void {
			var p:Point = _layer.globalToLocal(new Point(Game.StageWidth * 0.5, Game.StageHeight * 0.5));
			_layer.scaleX += _scale;
			_layer.scaleY += _scale;
			var np:Point = _layer.localToGlobal(new Point(p.x, p.y));
			_layer.x += Game.StageWidth * 0.5 - np.x;
			_layer.y += Game.StageHeight * 0.5 - np.y;
		}
		
		public static function ZoomSet(_layer:Sprite, _scale:Number):void {
			var p:Point = _layer.globalToLocal(new Point(Game.StageWidth * 0.5, Game.StageHeight * 0.5));
			_layer.scaleX = _scale;
			_layer.scaleY = _scale;
			var np:Point = _layer.localToGlobal(new Point(p.x, p.y));
			_layer.x += Game.StageWidth * 0.5 - np.x;
			_layer.y += Game.StageHeight * 0.5 - np.y;
		}
		*/
		
		public static function ClickStopPropagation(e:MouseEvent):void {
			e.stopPropagation();
		}
		
		public static function ToDollarAmount(_amount):String {
			var s:String = Math.abs(_amount).toString();
			var i:int;
			var ns:String = "";
			var k:int = 0;
			for (i = s.length - 1; i >= 0; i--) {
				var digit:String = s.charAt(i);
				ns = digit + ns;
				k++;
				if (k == 3) {
					if (i > 0) {
						ns = "," + ns;
					}
					k = 0;
				}
			}
			return "$" + ns;
		}
		
		public static function DrawClip(clip:DisplayObject):BitmapData {
			var bounds:Rectangle = clip.getBounds(clip);
			if (bounds.width <= 0 || bounds.height <= 0)
				return null;
			var bitmap:BitmapData = new BitmapData(int(bounds.width + 0.5), int(bounds.height + 0.5), true, 0);
			var mat:Matrix = new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y);
			bitmap.draw(clip, mat);
			return bitmap;
		}
	}
}





















