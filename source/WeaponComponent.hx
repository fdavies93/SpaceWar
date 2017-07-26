package;

import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.util.FlxVector;
import objects.Bullet;

/**
 * ...
 * @author Frank Davies
 */
class WeaponComponent 
{
	public var myObject:NewtonianSprite;
	
	public var bulletSpeed:Float;//in pixels per second
	public var bulletSpawnDistance:Float;//in pixels from object centr
	public var bulletSpawnAngle:Float;//relative to firing object facing, in degrees
	public var bulletFireAngle:Float;//as above
	public var bulletReloadTime:Float;//in seconds
	public var currentBulletReload:Float;//in seconds, counting down
	private var laserSound:FlxSound;
	
	public function new() 
	{
		currentBulletReload = 0;
		laserSound = FlxG.sound.load(AssetPaths.laser2__wav);
	}
	
	public function attachToObject(attachingTo:NewtonianSprite) 
	{
		myObject = attachingTo;
		if (myObject.getWeapon() == null) myObject.attachWeapon(this);
	}
	
	public function detachFromObject()
	{
		var oldObject:NewtonianSprite = myObject;
		myObject = null;
		if (oldObject != null) oldObject.detachWeapon();
	}
	
	public function getObject():NewtonianSprite
	{
		return myObject;
	}
	
	public function shoot() {
		if(currentBulletReload <= 0){
			var newBullet:objects.Bullet = new objects.Bullet((myObject.width/2) + myObject.x + bulletSpawnDistance * Math.cos(((myObject.angle + bulletSpawnAngle) / 360) * Math.PI * 2), (myObject.height/2) + myObject.y + bulletSpawnDistance * Math.sin(((myObject.angle + bulletSpawnAngle) / 360) * Math.PI * 2));
			var bulletMotionVector:FlxVector = new FlxVector();
			bulletMotionVector.length = bulletSpeed;
			laserSound.play(true);
			bulletMotionVector.degrees = myObject.angle + bulletFireAngle;
			newBullet.myGroup = myObject.myGroup;
			newBullet.angle = myObject.angle;
			newBullet.addVelocityVector(bulletMotionVector);
			myObject.myGroup.add(newBullet);
			currentBulletReload = bulletReloadTime;
		}
	}
	
	public function onUpdate() {
		if (currentBulletReload > 0) currentBulletReload -= 1 / FlxG.updateFramerate;
	}
	
	public function getClone():WeaponComponent
	{
		var newWeapon = new WeaponComponent();
		newWeapon.bulletFireAngle = bulletFireAngle;
		newWeapon.bulletReloadTime = bulletReloadTime;
		newWeapon.bulletSpawnAngle = bulletSpawnAngle;
		newWeapon.bulletSpawnDistance = bulletSpawnDistance;
		newWeapon.bulletSpeed = bulletSpeed;
		return newWeapon;
	}
	
	public function destroy()
	{
		
	}
	
}