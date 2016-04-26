package ui;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class UIArrow extends ui.UISprite 
{

	public var spriteObserver:ObjectObserver;
	public var observedAllegiance:Int;
	public var text:FlxText;
	
	public function new() 
	{
		spriteObserver = null;
		text = new FlxText();
		text.alignment = "left";
		text.pixelPerfectRender = false;
		pixelPerfectRender = false;
		super();
	}
	
	override public function onAdded() 
	{
		allegianceCheck(spriteObserver.getObject());
		super.onAdded();
	}
	
	private function allegianceCheck(Object:NewtonianSprite)
	{
		switch(Object.myAllegiance)
		{
			case 0: //inanimate
				loadRotatedGraphic(AssetPaths.uiArrowBlue__png, 360, -1, true, true);
				text.color = 0x2791E7;
			case 1: //friendly
				loadRotatedGraphic(AssetPaths.uiArrowGreen__png, 360, -1, true, true);
				text.color = 0x36DC32;
			case 2: //neutral
				loadRotatedGraphic(AssetPaths.uiArrowAmber__png, 360, -1, true, true);
				text.color = 0xDE8916;
			case 3: //enemy
				loadRotatedGraphic(AssetPaths.uiArrowRed__png, 360, -1, true, true);
				text.color = 0xD21A1A;
		}
		observedAllegiance = spriteObserver.getObject().myAllegiance;
	}
	
	override public function update():Void 
	{
		var myObject = spriteObserver.getObject();
		if(myObject != null){
			if (observedAllegiance != myObject.myAllegiance)
			{
				allegianceCheck(myObject);
			}
			var screenOffset:FlxPoint = myObject.getScreenXY();
			if (myObject.isOnScreen())
			{
				//angle = 45;
				xOffset = screenOffset.x;
				yOffset = screenOffset.y;
				text.text = myObject.name;
			}
			else
			{
				var curAngle:Float = Math.atan2(myObject.y - (FlxG.camera.scroll.y + FlxG.height / 2), myObject.x - (FlxG.camera.scroll.x + FlxG.width / 2));
				angle = (curAngle / (Math.PI * 2)) * 360;
				xOffset = (Math.cos(curAngle) * ((FlxG.width / 2) - width)) + (FlxG.width / 2) - (width / 2);
				yOffset = (Math.sin(curAngle) * ((FlxG.height / 2) - height)) + (FlxG.height / 2) - (height / 2);
				text.text = "";
			}
			super.update();
		}
		else destroy();
	}
	
	override public function draw():Void 
	{
		text.x = x + (spriteObserver.getObject().width / 2 - (text.get_width() / 2));
		text.y = y + (spriteObserver.getObject().height);
		if(text.text != "VOID") text.draw();
		if(!spriteObserver.getObject().isOnScreen()) super.draw();//draw main arrow
	}
}