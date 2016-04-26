package ui;
import flixel.group.FlxTypedGroup;
import flixel.util.FlxSort;
import flixel.FlxG;
import ui.ChatMessageBox;
import ui.InputBox;
import ui.NavigationArrows;
import ui.UIComponent;

/**
 * ...
 * @author ...
 */
class UserInterface extends FlxTypedGroup<ui.UIComponent> 
{
	public var myLevel:Level;
	public var myChatBox:ui.ChatMessageBox;
	
	public function new() 
	{
		super();
		add(new ui.NavigationArrows());
		add(new ui.InputBox(0, FlxG.height - 20));
		myChatBox = new ui.ChatMessageBox(0, 0);
		add(myChatBox);
	}
	
	public function onAddPhysicsObject(Object:NewtonianSprite) 
	{
		for (component in this)
		{
			if (component != null)
			{
				component.onAddPhysicsObject(Object);
			}
		}
	}
	
	/*public function sendMessage(theMessage:String)
	{
		
	}*/
	
	override public function add(Object:ui.UIComponent):ui.UIComponent 
	{
		var returnValue:ui.UIComponent = super.add(Object);
		Object.myInterface = this;
		Object.onAdded();
		sort(sortByDepth, FlxSort.ASCENDING);
		return returnValue;
	}
	
	private function sortByDepth(Order:Int, Component1:ui.UIComponent, Component2:ui.UIComponent)
	{
		return FlxSort.byValues(Order, Component1.depth, Component2.depth);
	}
	
}