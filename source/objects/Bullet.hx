package objects;
import flixel.util.FlxPoint;
import flixel.FlxG;

/**
 * ...
 * @author Frank Davies
 */
class Bullet extends NewtonianSprite
{	
	public var maxFlyTime:Float = 2;
	private var currentFlyTime:Float = 0;
	
	public function new(?X:Float = 0, ?Y:Float = 0) 
	{
		super(X, Y, 1e1);
		gravityEnabled = false;
		collisionsEnabled = true;
		myController = null;
		loadGraphic(AssetPaths.playerBullet__png);
		mySuperType = "Bullet";
		wraps = true;
		showInUI = false;
	}
	
	override public function update()
	{
		currentFlyTime += 1 / FlxG.updateFramerate; 
		if (currentFlyTime > maxFlyTime) {
			myGroup.remove(this);
			destroy();
			super.destroy();
		}
		else{
			super.update();
		}
	}
	
	override public function onCollide(collidedWith:NewtonianSprite) {
		super.onCollide(collidedWith);
		if(collidedWith.myType != "Bullet" && collidedWith.mySuperType != "Bullet"){
			myGroup.remove(this);
			destroy();
			super.destroy();
		}
	}
	
}