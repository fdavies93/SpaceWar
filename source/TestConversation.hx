package;

/**
 * ...
 * @author ...
 */
class TestConversation extends Conversation 
{

	public function new(State:ObjectControlState) 
	{
		super(State);
		addPoint(0, "", 1, 1);
		addPoint(1, "Greetings earthling.", 1, 2);
		addPoint(2, "This is a test of the basic conversation.", 1, 3);
		addPoint(3, "Say 'repeat' if you want me to repeat this.", 1, 4);
		//addPoint(4, "Or 'nope' if you want me to say nope.", 0, 5);
		
		var choice:DecisionDialoguePoint = addDecisionPoint(4);
		choice.addChoice("repeat", 1);
		//choice.addChoice("nope", 6);
		
		//addPoint(6, "Nope. Changing to new state...", 1, 0, changeToSecond);
		setCurPointIndex(0);
	}
	
	private function changeToSecond()
	{
		myState.getController().changeState("second");
	}
}