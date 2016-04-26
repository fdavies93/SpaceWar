package controllers.states;

import flixel.util.FlxVector;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class PlayerActiveState extends ObjectControlState
{
	
	public function new(Controller:ObjectController) 
	{
		super(Controller);
	}
	
	override public function onUpdate() 
	{
		if (myController.myObject.myGroup.allowInput)
		{
			var myVector:FlxVector = new FlxVector(myController.myObject.x, myController.myObject.y);
			if (FlxG.keys.pressed.A && myController.myObject.getThrust() != null) {
				myController.myObject.getThrust().boostOff();
				myController.myObject.getThrust().rotateLeft();			
			}
			if (FlxG.keys.pressed.D && myController.myObject.getThrust() != null) {
				myController.myObject.getThrust().boostOff();
				myController.myObject.getThrust().rotateRight();
			}
			if (FlxG.keys.pressed.W && myController.myObject.getThrust() != null) myController.myObject.getThrust().forwardThrust();
			if (FlxG.keys.pressed.S && myController.myObject.getWeapon() != null) {
				if (myController.myObject.getThrust() != null) myController.myObject.getThrust().boostOff();
				myController.myObject.getWeapon().shoot();
			}
			if (FlxG.keys.justPressed.Q && myController.myObject.getThrust() != null)
			{
				if (myController.myObject.getThrust().boosting) myController.myObject.getThrust().boostOff();
				else myController.myObject.getThrust().boostOn();
			}
			if (FlxG.keys.pressed.E && myController.myObject.getThrust() != null) {
				myController.myObject.getThrust().boostOff();
				myController.myObject.getThrust().stopThrust();
			}
			
			if (FlxG.keys.pressed.PAGEUP)
			{
				//myController.myObject.myGroup.myLevel.myState.loadLevel("Sol");
				myController.myObject.myGroup.myLevel.myState.changeLevel("Sol", 2000, 2000);
			}
			if (FlxG.keys.pressed.PAGEDOWN)
			{
				myController.myObject.myGroup.myLevel.myState.loadLevel("Andromeda");
			}
		}
		if (myController.myObject.angle >= 360) myController.myObject.angle = myController.myObject.angle % 360;
		else if (myController.myObject.angle < 0) myController.myObject.angle = 360 + myController.myObject.angle;
		super.onUpdate();
	}
	
}