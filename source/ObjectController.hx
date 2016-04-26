package;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.FlxG;

/**
 * ...
 * @author Frank Davies
 */
class ObjectController 
{
	public var myObject:NewtonianSprite;
	public var chatListener:ChatListener;
	private var controlStates:Map<String, ObjectControlState>;//i.e. state name, control state
	public var curStateIndex:String;
	public var spaceObserver:SpaceObserver;
	
	public function new()
	{
		myObject = null;
		chatListener = null;
		controlStates = new Map<String, ObjectControlState>();
		curStateIndex = null;
		spaceObserver = null;
	}
	
	public function getAttachedObject()
	{
		return myObject;
	}
	
	public function attachToObject(attachingTo:NewtonianSprite) 
	{
		myObject = attachingTo;
		if (myObject.getController() == null) myObject.attachController(this);
		//onAttached();
	}
	
	public function detachFromObject()
	{
		var oldObject:NewtonianSprite = myObject;
		myObject = null;
		if (oldObject != null) oldObject.detachController();
	}
	
	public function onUpdate()
	{
		if (controlStates.get(curStateIndex) != null)
		{
			controlStates.get(curStateIndex).onUpdate();
		}
		/*if (myConversation != null)
		{
			myConversation.update();
		}*/
		//code to fire events such as onCollide etc. can go here
	}
	
	public function onCollide(collidingWith:NewtonianSprite) 
	{
		if (controlStates.get(curStateIndex) != null)
		{
			controlStates.get(curStateIndex).onCollide(collidingWith);
		}
	}
	
	public function onReceiveMessage(message:String, sender:NewtonianSprite)
	{
		if (controlStates.get(curStateIndex) != null)
		{
			controlStates.get(curStateIndex).onReceiveMessage(message, sender);
		}
		/*if (myConversation != null)
		{
			myConversation.onReceiveMessage(message, sender);
		}*/
	}
	
	public function addChatListener()
	{
		chatListener = new ChatListener(this);
		//myObject.myGroup.addChatListener(chatListener);
	}
	
	public function addSpaceObserver(radius:Float)
	{
		spaceObserver = new SpaceObserver(this, radius);
	}
	
	public function onAdded()
	{
		if (controlStates.get(curStateIndex) != null)
		{
			controlStates.get(curStateIndex).onAdded();
		}
	}
	
	public function changeState(changeTo:String)
	{
		if (controlStates.get(changeTo) != null)
		{
			controlStates.get(curStateIndex).onExitState();
			curStateIndex = changeTo;
			controlStates.get(curStateIndex).onEnterState();
		}
		else trace("State " + changeTo + " not found.");
	}
	
	public function destroy()
	{
		if (chatListener != null) chatListener.myObjectController = null;
		if (spaceObserver != null) spaceObserver.myController = null;
		myObject = null;
		chatListener = null;
	}
}