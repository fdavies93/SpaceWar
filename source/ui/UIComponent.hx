package ui;
import flixel.group.FlxTypedGroup;
import flixel.FlxSprite;
import ui.UserInterface;
import ui.UISprite;

/**
 * ...
 * @author ...
 */
class UIComponent extends FlxTypedGroup<ui.UISprite>
{

	public var hasFocus:Bool;
	public var depth:Int;//this is critical to getting the UI to display correctly
	public var xOffset:Float;
	public var yOffset:Float;
	public var myInterface:ui.UserInterface;
	
	public function new(X:Float = 0, Y:Float = 0) 
	{
		super();
		hasFocus = false;
		depth = 0;
		xOffset = X;
		yOffset = Y;
	}
	
	override public function update():Void 
	{
		super.update();
		if (hasFocus) onFocusedUpdate();
		else onUnfocusedUpdate();
	}
	
	override public function add(Object:ui.UISprite):ui.UISprite 
	{
		Object.relativeTo = this;
		Object.onAdded();
		return super.add(Object);
	}
	
	public function onFocusedUpdate()
	{
		
	}
	
	public function onUnfocusedUpdate()
	{
		
	}
	
	public function onAdded()
	{
		
	}
	
	public function onAddPhysicsObject(Object:NewtonianSprite)
	{
		
	}
}