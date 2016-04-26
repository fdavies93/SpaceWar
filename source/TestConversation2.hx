package;

/**
 * ...
 * @author ...
 */
class TestConversation2 extends Conversation 
{

	public function new(State:ObjectControlState) 
	{
		super(State);
		addPoint(0, "", 1, 1);
		addPoint(1, "Nope.", 1, 2);
		addPoint(2, "We will now go back to your usual program.", 1, -1);
		setCurPointIndex(0);
	}
	
	private function changeToActive():Void
	{
		myState.getController().changeState("active");
	}
	
}