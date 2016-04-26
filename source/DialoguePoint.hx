package;

import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class DialoguePoint 
{

	public var message:String;
	public var autoplayTime:Float;
	public var nextPointIndex:Int;
	private var curTime:Float;
	private var conversation:Conversation;
	private var myFunction:Void->Void;
	
	public function new(myConversation:Conversation, Message:String, Time:Float = -1, Next:Int = -1, newFunction:Void->Void = null) 
	{
		conversation = myConversation;
		message = Message;
		autoplayTime = Time;
		nextPointIndex = Next;
		myFunction = newFunction;
		curTime = 0;
	}
	
	public function update()
	{
		if (autoplayTime != -1)
		{
			if (curTime >= autoplayTime)
			{
				curTime = 0;
				conversation.nextPoint();
			}
			curTime += 1 / FlxG.updateFramerate;
		}
	}
	
	public function onReceiveMessage(message:String, sender:NewtonianSprite)
	{
		
	}
	
	public function getFunction():Void->Void
	{
		return myFunction;
	}
}