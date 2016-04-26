package;

/**
 * ...
 * @author ...
 */
class DecisionDialoguePoint extends DialoguePoint 
{
	private var choices:Map<String, Int>;//input, dialogue point

	public function new(conversation:Conversation, Function:Void->Void) 
	{
		choices = new Map<String, Int>();
		super(conversation, "", -1, -1, Function);
	}
	
	override public function onReceiveMessage(message:String, sender:NewtonianSprite) 
	{
		var myChoice:Int = choices.get(message);
		if (myChoice != 0)
		{
			nextPointIndex = myChoice;
			conversation.nextPoint();
		}
		super.onReceiveMessage(message, sender);
	}
	
	public function addChoice(input:String, goesTo:Int)
	{
		choices.set(input, goesTo);
	}
}