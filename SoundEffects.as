package  
{
	import flash.media.Sound;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author ...
	 */
	public class SoundEffects 
	{
		public static var jump:Sound;
		public static var collect:Sound;
		public static var beeper:Sound;
		
		public static function Init() {
			jump = new Sound(new URLRequest("Jump.mp3"));
			collect = new Sound(new URLRequest("Pickup.mp3"));
			beeper = new Sound(new URLRequest("beeper.wav"));
		}
		
		public function SoundEffects() 
		{
			
		}
		
	}

}