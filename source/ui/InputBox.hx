package ui;

import flixel.addons.ui.FlxInputText;
import flixel.FlxG;
import openfl.text.TextFormat;
import ui.UIComponent;

/**
 * ...
 * @author ...
 */
class InputBox extends ui.UIComponent 
{

	public var myInput:FlxInputText;
	public var playerWatcher:ObjectObserver;
	
	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(X,Y);
		myInput = new FlxInputText();
		myInput.caretColor = 0xFFFFFF;
		myInput.backgroundColor = 0x3045AD;
		myInput.background = true;
		myInput.pixelPerfectRender = false;
		myInput.setFormat(AssetPaths.nokiafc22__ttf,8,0xFFFFFF);
		playerWatcher = new ObjectObserver();
		myInput.visible = false;
		//myInput.color = 0x000000;
	}
	
	override public function update()
	{
		myInput.update();
		if (myInput.hasFocus)
		{
			myInterface.myLevel.physicsGroup.allowInput = false;
			if (FlxG.keys.justPressed.ENTER)
			{
				//trace(myInput.text);
				playerWatcher.getObject().sendChatMessage(myInput.text);
				myInput.text = "";
				myInput.hasFocus = false;
				myInput.visible = false;
			}
		}
		else
		{
			myInterface.myLevel.physicsGroup.allowInput = true;
			if (FlxG.keys.justPressed.ENTER)
			{
				myInput.visible = true;
				myInput.hasFocus = true;
			}
		}
		super.update();
	}
	
	override public function draw()
	{
		myInput.x = FlxG.camera.scroll.x + xOffset;
		myInput.y = FlxG.camera.scroll.y + yOffset;
		//myInput.caretIndex = 0;
		myInput.caretIndex = myInput.text.length;
		if(myInput.visible) myInput.draw();
		super.draw();
	}
	
	override public function onAddPhysicsObject(Object:NewtonianSprite) 
	{
		if (Object.isPlayer)
		{
			playerWatcher.observeObject(Object);
		}
		super.onAddPhysicsObject(Object);
	}
	
}