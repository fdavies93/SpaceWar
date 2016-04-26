package background;

/**
 * ...
 * @author Frank Davies
 */
class BackgroundStarRed extends BackgroundObject 
{

	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.backgroundStarRed__png);
	}
	
}