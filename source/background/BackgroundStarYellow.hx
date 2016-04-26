package background;
import flixel.FlxSprite;

/**
 * ...
 * @author Frank Davies
 */
class BackgroundStarYellow extends BackgroundObject
{

	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.backgroundStarYellow__png);
	}
	
}