package;
import flixel.effects.particles.FlxTypedEmitter.Bounds;
import flixel.util.FlxVector;
import flixel.FlxG;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.util.FlxColor;

/**
 * ...
 * @author Frank Davies
 */
class ThrustComponent 
{
	private var myObject:NewtonianSprite;
	private var myEmitter:FlxEmitter;
	private var particle:FlxParticle;
	
	//normal thrust
	public var thrustForce:Float;//in newtons
	public var thrustMaxSpeed:Float;//in pps
	public var rotationSpeed:Float;//in degrees per second
	
	//boost thrust
	public var boosting:Bool;
	public var boostForce:Float;//in newtons
	public var boostMaxSpeed:Float;//in pps
	
	public var firstUpdate:Bool;
	
	public function new() 
	{
		thrustForce = 0;
		thrustMaxSpeed = 0;
		rotationSpeed = 0;
		boosting = false;
		boostForce = 0;
		boostMaxSpeed = 0;
		firstUpdate = true;
		myEmitter = new FlxEmitter(0, 0, 200);
	}
	
	public function forwardThrust()
	{
		var thrustVector:FlxVector = new FlxVector(0,0);
		thrustVector.length = thrustForce;
		thrustVector.degrees = myObject.angle;
		myObject.addForceVector(thrustVector);
	}
	
	public function stopThrust()
	{
		var thrustVector:FlxVector = new FlxVector();
		thrustVector.length = thrustForce;
		thrustVector.degrees = (myObject._moveVector.degrees + 180) % 360;
		myObject.addForceVector(thrustVector);
	}
	
	public function boostOn()
	{
		boosting = true;
	}
	
	public function boostOff()
	{
		var thrustVector:FlxVector = new FlxVector();
		if (boosting)
		{
			thrustVector.length = boostForce;
			thrustVector.degrees = myObject.angle;
		}
		boosting = false;
		myObject.addForceVector(thrustVector);
	}
	
	public function rotateLeft()
	{
		myObject.angle -= rotationSpeed / FlxG.updateFramerate;
	}
	
	public function rotateRight()
	{
		myObject.angle += rotationSpeed / FlxG.updateFramerate;
	}
	
	public function onUpdate()
	{
		if (boosting)
		{
			var thrustVector:FlxVector = new FlxVector();
			thrustVector.length = boostForce;
			thrustVector.degrees = myObject.angle;
			myObject.addForceVector(thrustVector);
		}
		if (firstUpdate)
		{
			myObject.myGroup.myLevel.add(myEmitter);
			myEmitter.start(false, 3, 0.25);
			firstUpdate = false;
		}
		myEmitter.x = myObject.x;
		myEmitter.y = myObject.y;
	}
	
	public function attachToObject(attachingTo:NewtonianSprite) 
	{
		myObject = attachingTo;
		if (myObject.getThrust() == null) myObject.attachThrust(this);
		//temporary; messing with the emitter
		//myEmitter = new FlxEmitter(myObject.x, myObject.y, 200);
		myEmitter.x = myObject.x;
		myEmitter.y = myObject.y;
		myEmitter.setXSpeed(-50, 50);
		myEmitter.setYSpeed( -50, 50);
		for (i in 0...100)
		{
			particle = new FlxParticle();
			particle.makeGraphic(2, 2, FlxColor.WHITE);
			// Make sure the particle doesn't show up at (0, 0)
			particle.visible = false; 
			myEmitter.add(particle);
			particle = new FlxParticle();
			particle.makeGraphic(1, 1, FlxColor.WHITE);
			particle.visible = false;
			myEmitter.add(particle);
		}
		//myObject.myGroup.myLevel.add(myEmitter);
		//myEmitter.start(false, 3, 0.25);
	}
	
	public function detachFromObject()
	{
		var oldObject:NewtonianSprite = myObject;
		myObject = null;
		if (oldObject != null) oldObject.detachThrust();
	}
	
	public function getObject():NewtonianSprite
	{
		return myObject;
	}
	
	public function getClone():ThrustComponent
	{
		var newThrust:ThrustComponent = new ThrustComponent();
		newThrust.boostForce = boostForce;
		newThrust.boostMaxSpeed = boostMaxSpeed;
		newThrust.boosting = boosting;
		newThrust.rotationSpeed = rotationSpeed;
		newThrust.thrustForce = thrustForce;
		newThrust.thrustMaxSpeed = thrustMaxSpeed;
		return newThrust;
	}
	
	public function destroy()
	{
		
	}
}