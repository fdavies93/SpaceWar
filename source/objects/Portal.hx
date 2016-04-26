package objects;
import Std;

/**
 * ...
 * @author ...
 */
class Portal extends NewtonianSprite
{

	//private var destinationName:String;
	//private var destinationX:Float;
	//private var destinationY:Float;
	
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.portal__png);
		gravityEnabled = false;
		collisionsEnabled = true;
		myAllegiance = 0;
		name = "Portal";
	}
	
	override public function onCollide(collidingSprite:NewtonianSprite) 
	{
		if (collidingSprite.isPlayer)
		{
			var destinationName:String = internalFlags.get("destinationName");
			var destinationX:Float = Std.parseFloat(internalFlags.get("destinationX"));
			var destinationY:Float = Std.parseFloat(internalFlags.get("destinationY"));
			collidingSprite.stop();
			myGroup.myLevel.myState.saveLevel(myGroup.myLevel.levelName);
			myGroup.myLevel.myState.changeLevel(destinationName, destinationX, destinationY);
		}
		super.onCollide(collidingSprite);
	}
	
	public function setDestination(Name:String, X:Float, Y:Float)
	{
		internalFlags.set("destinationName", Name);
		internalFlags.set("destinationX", Std.string(X));
		internalFlags.set("destinationY", Std.string(Y));
	}
	
	override public function onAdded() 
	{
		super.onAdded();
		name = "Portal to " + internalFlags.get("destinationName");
	}
	
}