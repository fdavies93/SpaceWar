package controllers;

import controllers.states.TestConversationState;
import controllers.states.TestState2;

/**
 * ...
 * @author ...
 */
class RepeatController extends ObjectController
{
	
	public function new() 
	{
		super();
		controlStates.set("active", new TestConversationState(this));
		controlStates.set("second", new TestState2(this));
		curStateIndex = "second";
		addChatListener();
		addSpaceObserver(300);
		//setConversation(new TestConversation(this));
	}
	
	override public function onUpdate() 
	{
		//myObject.sendChatMessage(myObject.x + ", " + myObject.y);
		super.onUpdate();
	}
	
	override public function onReceiveMessage(message:String, sender:NewtonianSprite) 
	{
		super.onReceiveMessage(message, sender);
	}
}