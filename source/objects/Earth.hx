package objects;

/**
 * ...
 * @author ...
 */
class Earth extends NewtonianSprite
{

	public function new(?X:Float = 0, ?Y: Float = 0)
	{
		super(X, Y, 6e24);
		//3e23
		loadGraphic(AssetPaths.earth__png);
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