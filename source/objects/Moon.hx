package objects;

/**
 * ...
 * @author ...
 */
class Moon extends NewtonianSprite
{

	public function new(?X:Float = 0, ?Y: Float = 0)
	{
		super(X, Y, 2e2);
		//3e23
		loadGraphic(AssetPaths.moon__png);
		collisionsEnabled = true;
		mySuperType = "CosmicBody";
		pixelPerfectRender = false;
	}
	
	override public function update() 
	{
		super.update();
		//trace(x + " " + y);
	}
	
}