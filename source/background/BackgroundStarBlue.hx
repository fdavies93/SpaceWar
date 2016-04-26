package background;
import flixel.FlxSprite;

/**
 * ...
 * @author Frank Davies
 */
class BackgroundStarBlue extends BackgroundObject
{

	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.backgroundStarBlue__png);
	}
	
}