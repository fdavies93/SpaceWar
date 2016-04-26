package;
import background.BackgroundStarBlue;
import background.BackgroundStarRed;
import background.BackgroundStarYellow;
import flixel.FlxCamera;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.group.FlxTypedGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.util.FlxSpriteUtil;
import ui.UserInterface;

/**
 * ...
 * @author Frank Davies
 */ 

class Level extends FlxSubState
{
	public var myState:PlayState;
	public var UIGroup:ui.UserInterface;
	public var physicsGroup:PhysicsGroup;//done
	public var backgroundGroup:BackgroundGroup;//done
	public var levelCamera:FlxCamera;//doesn't need saving; insufficiently complex
	public var wraparoundEnabled:Bool;//handle under progress data flags
	public var width:Float;//typical
	public var height:Float;//typical
	public var progressFlags:Map <String, String>;
	public var levelName:String;
	public var type:String;
	public var created:Bool;
	private var changePlayerPos:FlxPoint;
	private var player:NewtonianSprite;//player id
	
	override public function new()
	{
		super();
		created = false;
		physicsGroup = new PhysicsGroup(this);
		backgroundGroup = new BackgroundGroup();
		UIGroup = new ui.UserInterface();
		UIGroup.myLevel = this;
		progressFlags = new Map<String, String>();
		changePlayerPos = null;
	}
	
	override public function create():Void
	{
		super.create();
		//wraparoundEnabled = false;
		add(backgroundGroup);
		add(physicsGroup);
		add(UIGroup);
		
		if (!created) onFirstCreated();
		
		afterCreated();
		
		//myState.saveLevel("flash");
		//myState.saveLevel(levelName);
	}
	
	public function onAddPhysicsObject(Object:NewtonianSprite)
	{
		UIGroup.onAddPhysicsObject(Object);
	}
	
	public function onLoad()
	{
		//myState.saveLevel(levelName);
		//myState.saveLevel("flash");
	}
	
	public function getPlayer():NewtonianSprite
	{
		for (object in physicsGroup)
		{
			if (object != null)
			{
				if (object.isPlayer) return object;
			}
		}
		return null;
	}
	
	private function wraparound(curObject:NewtonianSprite):Void // this is cheap and dirty, but good enough for the limited use it's getting
	{
		if (curObject.wraps && FlxG.camera.target != null) {
			if (curObject.x > FlxG.camera.scroll.x + FlxG.camera.width) curObject.x = FlxG.camera.scroll.x - curObject.width;
			else if (curObject.x < FlxG.camera.scroll.x - curObject.width) curObject.x = FlxG.camera.scroll.x + FlxG.camera.width;
			if (curObject.y > FlxG.camera.scroll.y + FlxG.camera.height) curObject.y = FlxG.camera.scroll.y - curObject.height;
			else if (curObject.y < FlxG.camera.scroll.y - curObject.height) curObject.y = FlxG.camera.scroll.y + FlxG.camera.height;
		}
	}
	
	public function onFirstCreated() {
		created = true;
		//myState.saveLevel(levelName);
		//myState.saveLevel("flash");
	}
	
	public function afterCreated()
	{
		if (changePlayerPos != null)
		{
			getPlayer().x = changePlayerPos.x;
			getPlayer().y = changePlayerPos.y;
			changePlayerPos = null;
		}
		myState.saveLevel(levelName);
		myState.saveLevel("flash");
	}
	
	override public function update()
	{
		super.update();
		if (wraparoundEnabled) physicsGroup.forEach(wraparound);
	}
	
	public function attachCamera(mySprite:NewtonianSprite):Void
	{
		FlxG.camera.follow(mySprite);
	}
	
	private function attachCameraIfPlayer(mySprite:NewtonianSprite):Void
	{
		//trace("xxx");
		if (mySprite.isPlayer) FlxG.camera.follow(mySprite);
	}
	
	public function attachCameraToPlayer()
	{
		physicsGroup.forEach(attachCameraIfPlayer);
	}
	
	public function changePlayerPosOnLoad(x:Float, y:Float)
	{
		changePlayerPos = new FlxPoint(x, y);
	}
	
	public function generateStarfield(starNumber:Int)
	{
		var newSprite:BackgroundObject;
		var newSpriteX:Float;
		var newSpriteY:Float;
		var curGraphic:Int;
		for (o in 0...starNumber)
		{
			newSpriteX = (Math.random() * width) - (width/2);
			newSpriteY = (Math.random() * height) - (height / 2);
			curGraphic = Math.floor(Math.random() * 3);
			
			newSprite = new BackgroundObject(0, 0);
			switch(curGraphic)
			{
			case 0:
				newSprite = new background.BackgroundStarBlue(newSpriteX,newSpriteY);
			case 1:
				newSprite = new background.BackgroundStarRed(newSpriteX,newSpriteY);
			case 2:
				newSprite = new background.BackgroundStarYellow(newSpriteX,newSpriteY);
			}
			
			backgroundGroup.add(newSprite);
		}
	}
	
	public function getSaveData():LevelSaveData
	{
		var returnData = new LevelSaveData();
		returnData.backgroundData = backgroundGroup.getSaveData();
		returnData.physicsData = physicsGroup.getSaveData();
		returnData.progressFlags = progressFlags;
		return returnData;
	}
	
	public function empty():Void
	{
		physicsGroup.clear();
		backgroundGroup.clear();
		for (key in progressFlags.keys())
		{
			progressFlags.remove(key);
		}
	}
	
	override public function destroy():Void 
	{	
		UIGroup = null;
		super.destroy();
	}
}