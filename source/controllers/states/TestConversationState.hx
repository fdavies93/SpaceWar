package controllers.states;

/**
 * ...
 * @author ...
 */
class TestConversationState extends ObjectControlState
{

	public function new(newController:ObjectController) 
	{
		super(newController);
		setConversation(new TestConversation(this));
	}
	
	override public function onUpdate() 
	{
		myController.myObject.getThrust().stopThrust();
		super.onUpdate();
	}
	
}