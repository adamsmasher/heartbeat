package  {
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	
	public class Audio {		
		public static var music:Sound = null;
		public static var musicTrans:SoundTransform = null;
		public static var musicChannel:SoundChannel = null;
		public static var musicVolume:Number = 0.0;
		
		public static var musicVolumeModifer:Number = 1.0;
		public static var mainTransform:SoundTransform = new SoundTransform(1, 0);
		public static var mutedTransform:SoundTransform = new SoundTransform(0, 0);
		public static var prevMusic:Class = null;
		
		public function Audio() {
			
		}
		
		public static function ChangeMusic(_sound:Class):Number {
			if (prevMusic == _sound)
				return music.length * 0.001;
			if (musicChannel != null) {
				musicChannel.stop();
			}
			music = new _sound as Sound;
			music.play(0, 9999999, null);
			musicVolume = 0.0;
			musicTrans = new SoundTransform(0.0, 0.0);
			musicChannel = music.play(0, int.MAX_VALUE, musicTrans);
			prevMusic = _sound;
			return music.length * 0.001;
		}
	}
}


















