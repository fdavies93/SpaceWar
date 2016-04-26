package ui;
import flixel.text.FlxBitmapTextField;
import flixel.text.FlxText;
import flixel.text.FlxTextField;
import flixel.text.pxText.PxBitmapFont;
import flixel.FlxG;
import ui.UIText;

/**
 * ...
 * @author ...
 */
class ChatMessageBox extends ui.UIComponent
{

	//public var myMessages:FlxText;
	public var myMessages:Array<Array<ui.UIText>>;
	public var maxMessages:Int;
	public var messageSpacing:Int;
	
	public function new(X:Float = 0, Y:Float = 0) 
	{
		super(X, Y);
		//var myFont:PxBitmapFont = new PxBitmapFont();
		myMessages = new Array<Array<ui.UIText>>();
		maxMessages = 10;
		messageSpacing = 12;
		//myMessages.setFormat(AssetPaths.nokiafc22__ttf,8,0xFFFFFF);
	}
	
	public function receiveMessage(text:String, sender:NewtonianSprite)
	{
		var newLine:Array<ui.UIText> = new Array<ui.UIText>();
		if (myMessages.length + 1 > maxMessages) 
		{
			while (myMessages[0].length > 0) {
				myMessages[0][0].destroy();
				myMessages[0].shift();
			}
			myMessages.shift();
		}
		for (entry in myMessages)//set older entries to correct position
		{
			for (entry2 in entry) entry2.yOffset = (myMessages.indexOf(entry) * messageSpacing) + yOffset;
		}
		newLine.push(new ui.UIText(xOffset, myMessages.length * messageSpacing, sender.name + ": "));
		switch(sender.myAllegiance)
		{
			case 0:
				newLine[0].setFormat(AssetPaths.nokiafc22__ttf, 8, 0x2791E7);
			case 1:
				newLine[0].setFormat(AssetPaths.nokiafc22__ttf, 8, 0x36DC32);
			case 2:
				newLine[0].setFormat(AssetPaths.nokiafc22__ttf, 8, 0xDE8916);
			case 3:
				newLine[0].setFormat(AssetPaths.nokiafc22__ttf, 8, 0xD21A1A);
		}
		newLine.push(new ui.UIText(xOffset + newLine[0].width, myMessages.length * messageSpacing, text));
		myMessages.push(newLine);
		//myMessages.text += (sender.name + ": " + text + "\n");
	}
	
	override public function update():Void 
	{
		super.update();
		//myMessages.update();
	}
	
	override public function draw():Void 
	{
		super.draw();
		for (message1 in myMessages)
		{
			for (message2 in message1) message2.draw();
		}
		//myMessages.x = FlxG.camera.scroll.x + xOffset;
		//myMessages.y = FlxG.camera.scroll.y + yOffset;
		//myMessages.draw();
	}
}