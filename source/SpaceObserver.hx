package;
import flixel.util.FlxPoint;

/**
 * ...
 * @author ...
 */
class SpaceObserver 
{

	public var myController:ObjectController;
	private var radius:Float;
	private var observedList:Array<NewtonianSprite>;
	
	public function new(Controller:ObjectController, Radius:Float) 
	{
		myController = Controller;
		radius = Radius;
		observedList = new Array<NewtonianSprite>();
	}
	
	public function addObservedObject(Object:NewtonianSprite)
	{
		var objectCoords:FlxPoint = Object.getMidpoint();
		if (objectCoords.distanceTo(myController.myObject.getMidpoint()) <= radius && Object != myController.myObject)
		{
			observedList.push(Object);
		}
	}
	
	public function clearObservedList()
	{
		while (observedList.length > 0)
		{
			observedList.pop();
		}
	}
	
	public function getObservedList():Array<NewtonianSprite>
	{
		return observedList;
	}
	
	public function destroy()
	{
		myController.spaceObserver = null;
	}
}