package controllers.states;

/**
 * ...
 * @author ...
 */
class TestState2 extends ObjectControlState
{

	public function new(Controller:ObjectController) 
	{
		super(Controller);
		//setConversation(new TestConversation2(this));
	}
	
	override public function onUpdate() 
	{
		super.onUpdate();
		var observed:Array<NewtonianSprite> = myController.spaceObserver.getObservedList();
		myController.myObject.getThrust().stopThrust();
		//for (object in observed)
		//{
			//trace(object.name);
		//}
		if (observed.length > 0)
		{
			myController.changeState("active");
		}
	}
}