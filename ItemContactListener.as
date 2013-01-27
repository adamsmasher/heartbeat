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
			if (dataA is Item && dataB is Heart) {
				Item(dataA).pickedUp = true;
				Heart(dataB).score++;
			} else if (dataA is Heart && dataB is Item) {
				Item(dataB).pickedUp = true;
				Heart(dataA).score++;
			}
		}
	}

}