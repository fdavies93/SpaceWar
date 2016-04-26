package ui;
import flixel.FlxSprite;
import flixel.FlxG;
import ui.UIComponent;

/**
 * ...
 * @author ...
 */
class UISprite extends FlxSprite 
{

	public var xOffset:Float;
	public var yOffset:Float;
	public var relativeTo:ui.UIComponent;
	
	public function new(X:Float = 0, Y:Float = 0) 
	{
		super();
		xOffset = X;
		yOffset = Y;
		relativeTo = null;
	}
	
	override public function update():Void 
	{
		super.update();
		
		x = xOffset + FlxG.camera.scroll.x;
		y = yOffset + FlxG.camera.scroll.y;
		
		if (relativeTo != null)
		{
			x += relativeTo.xOffset;
			y += relativeTo.yOffset;
		}
	}
	
	public function onAdded()
	{
		
	}
	
}