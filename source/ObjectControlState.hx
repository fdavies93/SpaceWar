package;

/**
 * ...
 * @author ...
 */
class ObjectControlState 
{
	private var conversation:Conversation;
	private var myController:ObjectController;

	public function new(Controller:ObjectController) 
	{
		myController = Controller;
		conversation = null;
	}
	
	public function setConversation(newConversation:Conversation)
	{
		conversation = newConversation;
	}
	
	public function getController():ObjectController
	{
		return myController;
	}
	
	public function onUpdate()
	{
		if (conversation != null)
		{
			conversation.update();
		}
	}
	
	public function onCollide(collidingWith:NewtonianSprite)
	{
		
	}
	
	public function onReceiveMessage(message:String, sender:NewtonianSprite)
	{
		if (conversation != null)
		{
			conversation.onReceiveMessage(message, sender);
		}
	}
	
	public function onAdded()
	{
		
	}
	
	public function onEnterState()
	{
		
	}
	
	public function onExitState()
	{
		
	}
	
}