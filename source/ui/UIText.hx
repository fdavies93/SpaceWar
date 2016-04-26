package ui;
import flixel.text.FlxText;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class UIText extends FlxText 
{
	public var xOffset:Float;
	public var yOffset:Float;

	public function new(X:Float = 0, Y:Float = 0, text:String = "") 
	{
		super(0, 0, 0, text);
		xOffset = X;
		yOffset = Y;
	}
	
	override public function draw():Void 
	{
		x = xOffset + FlxG.camera.scroll.x;
		y = yOffset + FlxG.camera.scroll.y;
		super.draw();
	}
	
}