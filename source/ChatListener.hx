package;

/**
 * ...
 * @author ...
 */
class ChatListener 
{

	public var myObjectController:ObjectController;
	
	public function new(Object:ObjectController = null) 
	{
		myObjectController = Object;
	}
	
	public function onReceiveMessage(message:String, sender:NewtonianSprite)
	{
		myObjectController.onReceiveMessage(message, sender);
	}
	
	public function attachToController(controller:ObjectController)
	{
		myObjectController = controller;
	}
	
	public function destroy()
	{
		myObjectController.chatListener = null;
	}
}