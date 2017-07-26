package objects;

/**
 * ...
 * @author ...
 */
class SpaceStation extends NewtonianSprite
{

	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(X, Y, 9e17);
		//3e23
		loadGraphic(AssetPaths.spacestation__png);
		collisionsEnabled = false;
		mySuperType = "Ship";
		myAllegiance = 1;
		pixelPerfectRender = false;
	}
	
	override public function update()
	{
		velocity.x = 0;
		velocity.y = 0;
	}
}