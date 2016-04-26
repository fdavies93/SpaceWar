package controllers;

import flixel.FlxG;
import flixel.util.FlxVector;
import objects.Bullet;

/**
 * ...
 * @author Frank Davies
 */
class Player2Controller extends ObjectController 
{
	public var bulletSpeed:Float = 200;
	public var bulletSpawnDistance:Float = 25;
	public var bulletReloadTime:Float = 1;
	private var currentBulletReload:Float = 0;
	
	public function new() 
	{
		super();
	}
	
	override public function onUpdate() 
	{
		var myVector:FlxVector = new FlxVector(myObject.x, myObject.y);
		if (FlxG.keys.pressed.J)
		{
			myObject.angle -= myObject.rotationSpeed / FlxG.updateFramerate;			
		}
		if (FlxG.keys.pressed.L)
		{
			myObject.angle += myObject.rotationSpeed / FlxG.updateFramerate;
		}
		if (FlxG.keys.pressed.I)
		{
			myVector.degrees = myObject.angle;
			myVector.length = myObject.thrust;
			myObject.addForceVector(myVector);
		}
		/*if (FlxG.keys.pressed.DOWN)
		{
			myVector.degrees = myObject.angle;
			myVector.length = -myObject.thrust;
			myObject.addForceVector(myVector);
		}
		if (FlxG.keys.pressed.E)
		{
			myVector = myObject._moveVector.clone();
			myVector.length = -myObject.thrust;
			myObject.addForceVector(myVector);
		}*/
		if (FlxG.keys.pressed.K && currentBulletReload <= 0)
		{
			var newBullet:objects.Bullet = new objects.Bullet((myObject.width/2) + myObject.x + bulletSpawnDistance * Math.cos((myObject.angle / 360) * Math.PI * 2), (myObject.height/2) + myObject.y + bulletSpawnDistance * Math.sin((myObject.angle / 360) * Math.PI * 2));
			myVector.degrees = myObject.angle;
			myVector.length = bulletSpeed;
			newBullet.addVelocityVector(myVector);
			myObject.myGroup.add(newBullet);
			currentBulletReload = bulletReloadTime;
		}
		if (myObject.angle >= 360) myObject.angle = myObject.angle % 360;
		else if (myObject.angle < 0) myObject.angle = 360 + myObject.angle;
		if (currentBulletReload > 0) currentBulletReload -= 1 / FlxG.updateFramerate;
		super.onUpdate();//fires other events like onCollide
	}
}