package objects;
import flixel.util.FlxPoint;
import flixel.FlxG;
import flixel.util.FlxVector;

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
		super(X, Y, 5e-10);
		gravityEnabled = false;
		collisionsEnabled = true;
		myController = null;
		loadGraphic(AssetPaths.shot1__png);
		mySuperType = "Bullet";
		wraps = true;
		showInUI = false;
		rigid = false;
	}
	
	override public function update()
	{
		currentFlyTime += 1 / FlxG.updateFramerate; 
		if (currentFlyTime > maxFlyTime) {
			killMe = true;
		}
		else{
			super.update();
		}
	}
	
	override public function onCollide(collidedWith:NewtonianSprite) {
		super.onCollide(collidedWith);
		if (collidedWith.myType != "Bullet" && collidedWith.mySuperType != "Bullet"){
			_moveVector.scale(1e3);
			collidedWith.addForceVector(_moveVector);
			killMe = true;
		}
	}
	
}