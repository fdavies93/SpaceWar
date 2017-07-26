package objects;

/**
 * ...
 * @author ...
 */
class Asteroid extends NewtonianSprite
{

	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(X, Y, 1e5);
		loadRotatedGraphic(AssetPaths.meteor1__png, 360);
		collisionsEnabled = true;
		pixelPerfectRender = false;
		showInUI = false;
		mySuperType = "Ship";
	}
	
	override public function onCollide(collidedWith:NewtonianSprite)
	{
		super.onCollide(collidedWith);
	}
}