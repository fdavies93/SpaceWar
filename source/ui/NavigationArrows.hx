package ui;

import flixel.FlxG;
import ui.UIArrow;
import ui.UIComponent;

/**
 * ...
 * @author ...
 */
class NavigationArrows extends ui.UIComponent 
{

	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(X,Y);
	}
	
	override public function update():Void 
	{
		super.update();
	}
	
	
	override public function onAddPhysicsObject(Object:NewtonianSprite) 
	{
		if (Object.showInUI)
		{
			var watcher:ObjectObserver = new ObjectObserver();
			var watchingArrow:ui.UIArrow = new ui.UIArrow();
			watchingArrow.spriteObserver = watcher;
			Object.addObserver(watcher);
			add(watchingArrow);
		}
		super.onAddPhysicsObject(Object);
	}
	
}