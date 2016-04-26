package;
import openfl.display3D.IndexBuffer3D;

/**
 * ...
 * @author ...
 */
class Conversation 
{
	private var dialoguePoints:Map<Int, DialoguePoint>;
	private var curPointIndex:Int;
	//private var myController:ObjectController;
	private var myState:ObjectControlState;
	
	public function new(State:ObjectControlState) 
	{
		dialoguePoints = new Map<Int, DialoguePoint>();
		curPointIndex = -1;
		myState = State;
	}
	
	public function setCurPointIndex(newIndex:Int)
	{
		curPointIndex = newIndex;
	}
	
	public function nextPoint()
	{
		curPointIndex = dialoguePoints[curPointIndex].nextPointIndex;
		if (curPointIndex != -1)
		{
			var curPoint:DialoguePoint = dialoguePoints[curPointIndex];
			if (curPoint.message != "")
			{
				myState.getController().myObject.sendChatMessage(curPoint.message);
			}
			if (curPoint.getFunction() != null)
			{
				curPoint.getFunction()();//executes found function
			}
		}
	}
	
	public function onReceiveMessage(message:String, sender:NewtonianSprite)
	{
		if (curPointIndex != -1)
		{
			dialoguePoints[curPointIndex].onReceiveMessage(message, sender);
		}
	}
	
	public function update()
	{
		if (curPointIndex != -1)
		{
			dialoguePoints[curPointIndex].update();
		}
	}
	
	public function addPoint(index:Int, message:String, Time:Float = -1, Next:Int = -1, Function:Void->Void = null)
	{
		var newPoint:DialoguePoint = new DialoguePoint(this, message, Time, Next, Function);
		dialoguePoints.set(index, newPoint);
	}
	
	public function addDecisionPoint(index:Int, Function:Void->Void = null):DecisionDialoguePoint
	{
		var newPoint:DecisionDialoguePoint = new DecisionDialoguePoint(this, Function);
		dialoguePoints.set(index, newPoint);
		return newPoint;
	}
	
}