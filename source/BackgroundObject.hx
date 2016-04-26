package;
import flixel.FlxSprite;
import flixel.FlxG;

/**
 * ...
 * @author Frank Davies
 */
class BackgroundObject extends FlxSprite 
{

	public var type:String;
	//public var scrollFactor:Float;//determines speed of change relative to camera observed object
	//public var xOffset;
	//public var yOffset;
	
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		//xOffset = X;
		//yOffset = Y;
		//scrollFactor = 1.0;//i.e. defaults to moving at same speed as background
		scrollFactor.x = 0.00390625;
		scrollFactor.y = 0.00390625;
		pixelPerfectRender = false;
		
		type = Type.getClassName(Type.getClass(this));
	}
	
	public function getSaveData():BackgroundObjectSaveData 
	{
		var saveData:BackgroundObjectSaveData = new BackgroundObjectSaveData();
		saveData.type = type;
		saveData.x = x;
		saveData.y = y;
		return saveData;
	}
	
	/*override public function draw()
	{
		x = (FlxG.camera.scroll.x * scrollFactor) + xOffset;
		y = (FlxG.camera.scroll.y * scrollFactor) + yOffset;
		super.draw();
	}*/
}