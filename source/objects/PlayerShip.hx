package objects;

import thrusters.ThrusterPlayerShip;
import weapons.WeaponPeashooter;

/**
 * ...
 * @author Frank Davies
 */
class PlayerShip extends NewtonianSprite
{

	public function new(?X:Float = 0, ?Y:Float = 0) 
	{
		super(X, Y, 1e3);
		loadRotatedGraphic(AssetPaths.ship2__png, 360,-1,true,true);
		centerOrigin();
		gravityEnabled = true;
		collisionsEnabled = true;
		mySuperType = "Ship";
		name = "Player";
		myAllegiance = 1;
		//attachWeapon(new WeaponPeashooter());
		
		attachThrust(new ThrusterPlayerShip());
		
		wraps = true;
	}
	
	override public function onCollide(collidedWith:NewtonianSprite)
	{
		super.onCollide(collidedWith);
		if (collidedWith.mySuperType == "CosmicBody" || collidedWith.mySuperType == "Bullet") {
			myGroup.remove(this);
			destroy();
			if(isPlayer) myGroup.myLevel.myState.loadLevel("flash");
		}
		/*else{
			_moveVector = _moveVector.negate();
		}*/
	}
	
	/*override public function kill():Void 
	{
		
		super.kill();
	}*/
	
	override public function update()
	{
		//trace("x: " + x + " y: " +y);
		super.update();
	}
}