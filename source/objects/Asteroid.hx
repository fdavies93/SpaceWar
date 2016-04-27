package objects;

/**
 * ...
 * @author ...
 */
class Asteroid extends NewtonianSprite
{

	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(X, Y, 1e10);
		//loadRotatedGraphic(AssetPaths.asteroid__gif, 360);
		collisionsEnabled = true;
		pixelPerfectRender = false;
		mySuperType = "CosmicBody";
	}
	
}