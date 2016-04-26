package;

import flixel.util.FlxPoint;
using FlxPointExtender;
import flixel.FlxG;

/**
 * ...
 * @author Frank Davies
 */
class OrbitComponent 
{
	public var orbitCentre:FlxPoint;//x, y
	public var orbitRadius:FlxPoint;//x radius, y radius
	public var orbitSpeed:Float;//in radians per second
	public var orbitTilt:Float;//in degrees
	public var orbitsClockwise:Bool;//if true, orbits clockwise; if false, anticlockwise
	public var curAngle:Float;
	public var orbitedObject:NewtonianSprite;
	public var orbitedId:Int;
	public var myObject:NewtonianSprite;
	
	public function new() 
	{
		orbitCentre = new FlxPoint(0, 0);
		orbitRadius = new FlxPoint(0, 0);
		orbitSpeed = 0;
		orbitTilt = 0;
		orbitsClockwise = true;
		curAngle = 0;
		orbitedObject = null;
	}
	
	public function attachToObject(attachingTo:NewtonianSprite) 
	{
		myObject = attachingTo;
		if (myObject.getOrbit() == null) myObject.attachOrbit(this);
	}
	
	public function detachFromObject()
	{
		var oldObject:NewtonianSprite = myObject;
		myObject = null;
		if (oldObject != null) oldObject.detachOrbit();
	}
	
	public function getObject():NewtonianSprite
	{
		return myObject;
	}
	
	public function onUpdate():Void
	{
		if (orbitedObject != null) orbitCentre = new FlxPoint(orbitedObject.x, orbitedObject.y);
		var nextAngle:Float;
		if (orbitsClockwise) nextAngle = curAngle + (orbitSpeed / FlxG.updateFramerate);
		else nextAngle = curAngle - (orbitSpeed / FlxG.updateFramerate);
		if (nextAngle < 0) nextAngle += (Math.PI * 2);//convert to positive format
		nextAngle = nextAngle % (Math.PI * 2);
		curAngle = nextAngle;
		
		var nextPoint:FlxPoint;
		nextPoint = new FlxPoint(orbitCentre.x + orbitRadius.x * Math.cos(curAngle), orbitCentre.y + orbitRadius.y * Math.sin(curAngle));
		nextPoint = nextPoint.rotatePoint(orbitCentre, orbitTilt, false);
		myObject.x = nextPoint.x;
		myObject.y = nextPoint.y;
	}
	
}