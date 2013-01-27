package  
{
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	/**
	 * ...
	 * @author ...
	 */
	public class ItemContactListener extends b2ContactListener 
	{
		public function ItemContactListener() 
		{
			
		}
		
		override public function BeginContact(contact:b2Contact):void {
			var dataA = contact.GetFixtureA().GetBody().GetUserData();
			var dataB = contact.GetFixtureB().GetBody().GetUserData();
			if (dataA is GlowChars && dataB is Heart && GlowChars(dataA).color == Heart(dataB).color) {
				GlowChars(dataA).pickedUp = true;
				
				if (Heart(dataB) == Game.instance.square)
					GlowChars(dataA).particleFrame = 2;
				else
					GlowChars(dataA).particleFrame = 3;
					
				SoundEffects.collect.play();
				Heart(dataB).score++;
			} else if (dataA is Heart && dataB is GlowChars && GlowChars(dataB).color == Heart(dataA).color) {
				GlowChars(dataB).pickedUp = true;
				
				if (Heart(dataA) == Game.instance.square)
					GlowChars(dataB).particleFrame = 2;
				else
					GlowChars(dataB).particleFrame = 3;
					
				SoundEffects.collect.play();
				Heart(dataA).score++;
			}
		}
	}

}