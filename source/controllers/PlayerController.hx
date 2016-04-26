package controllers;

import controllers.states.PlayerActiveState;
import flixel.FlxG;
import flixel.util.FlxVector;

/**
 * ...
 * @author Frank Davies
 */
class PlayerController extends ObjectController 
{
	
	public function new() 
	{
		super();
		controlStates.set("active", new PlayerActiveState(this));
		curStateIndex = "active";
	}
	
	override public function onUpdate() 
	{
		//trace(myObject.velocity);
		/*if (myObject.myGroup.allowInput)
		{
			var myVector:FlxVector = new FlxVector(myObject.x, myObject.y);
			if (FlxG.keys.pressed.A && myObject.getThrust() != null) {
				myObject.getThrust().boostOff();
				myObject.getThrust().rotateLeft();			
			}
			if (FlxG.keys.pressed.D && myObject.getThrust() != null) {
				myObject.getThrust().boostOff();
				myObject.getThrust().rotateRight();
			}
			if (FlxG.keys.pressed.W && myObject.getThrust() != null) myObject.getThrust().forwardThrust();
			if (FlxG.keys.pressed.S && myObject.getWeapon() != null) {
				if (myObject.getThrust() != null) myObject.getThrust().boostOff();
				myObject.getWeapon().shoot();
			}
			if (FlxG.keys.justPressed.CONTROL)
			{
				myObject.myGroup.myLevel.myState.saveLevel("flash");
			}
			if (FlxG.keys.justPressed.TAB)
			{
				myObject.myGroup.myLevel.myState.loadLevel("flash");
			}
			if (FlxG.keys.justPressed.Q && myObject.getThrust() != null)
			{
				if (myObject.getThrust().boosting) myObject.getThrust().boostOff();
				else myObject.getThrust().boostOn();
			}
			if (FlxG.keys.pressed.E && myObject.getThrust() != null) {
				myObject.getThrust().boostOff();
				myObject.getThrust().stopThrust();
			}
			
			if (FlxG.keys.pressed.DELETE)
			{
				myObject.myGroup.myLevel.myState.loadLevel("flash");
			}
		}
		if (myObject.angle >= 360) myObject.angle = myObject.angle % 360;
		else if (myObject.angle < 0) myObject.angle = 360 + myObject.angle;*/
		super.onUpdate();//fires other events like onCollide
	}
	
	override public function attachToObject(attachingTo:NewtonianSprite) 
	{
		super.attachToObject(attachingTo);
		myObject.isPlayer = true;
	}
	
	override public function detachFromObject() 
	{
		myObject.isPlayer = false;
		super.detachFromObject();
	}
}