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
		
		public static function Init() {
			jump = new Sound(new URLRequest("Jump.mp3"));
			collect = new Sound(new URLRequest("Pickup.mp3"));
		}
		
		public function SoundEffects() 
		{
			
		}
		
	}

}