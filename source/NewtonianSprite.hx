package ;

import flixel.effects.particles.FlxEmitter;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.util.FlxPoint;
import flixel.util.FlxVector;
import flixel.FlxG;
import haxe.Log;
using flixel.util.FlxSpriteUtil;
using FlxPointExtender;

/**
 * ...
 * @author Frank Davies
 */
 
class NewtonianSprite extends FlxSprite
{
	
	public var _mass:Float;//mass in kg (I justify the _ as 'mass' is a default value and won't let me do what I want)
	public var _moveVector:FlxVector;
	public var gravityEnabled:Bool;
	public var collisionsEnabled:Bool;
	public var myGroup:PhysicsGroup;
	public var myAllegiance:Int;
	public var myObservers:Array<ObjectObserver>;
	public var internalFlags:Map<String,String>;
	public var rigid:Bool;
	
	//CONTROL VARIABLES
	private var myController:ObjectController;
	
	private var myWeapon:WeaponComponent;
	
	private var myThrust:ThrustComponent;
	
	private var myEmitters:Array<FlxEmitter>;//just here to make sure emitters render
	
	private var myOrbit:OrbitComponent;
	
	//private var myEmitter:FlxEmitter;
	
	public var mySuperType:String;
	public var myType:String;
	
	public var name:String;
	public var isPlayer:Bool;
	public var wraps:Bool;
	public var killMe:Bool;
	
	public var showInUI:Bool;
	
	public var spaceNode:QuadTreeNode;
	
	public function new(?X:Float = 0, ?Y:Float = 0, ?Mass:Float = 1e0):Void
	{
		super(X, Y);
		_moveVector = new FlxVector();
		_mass = Mass;
		myController = null;
		myWeapon = null;
		myThrust = null;
		myOrbit = null;
		isPlayer = false;
		showInUI = true;
		killMe = false;
		wraps = false;
		name = "VOID";
		ID = -1;
		myAllegiance = 0;//0: Inanimate, 1: Ally, 2: Neutral, 3: Enemy
		myType = Type.getClassName(Type.getClass(this));
		myObservers = new Array<ObjectObserver>();
		internalFlags = new Map<String, String>();
		pixelPerfectRender = false;
		spaceNode = null;
		rigid = true;
	}
	
	public function sendChatMessage(message:String)
	{
		myGroup.sendChatMessage(message, this);
	}
	
	public function addVelocityVector(VelocityVector:FlxVector):Void
	{
		_moveVector = _moveVector.addNew(VelocityVector);
		if (_moveVector.length > PhysicsGroup._maxSpeed && myThrust == null) _moveVector.length = PhysicsGroup._maxSpeed;
		else if (myThrust != null) {
			if (_moveVector.length > myThrust.thrustMaxSpeed && !myThrust.boosting) _moveVector.length = myThrust.thrustMaxSpeed;
			else if (_moveVector.length > myThrust.boostMaxSpeed && myThrust.boosting) _moveVector.length = myThrust.boostMaxSpeed;
		}
	}
	
	public function onAdded()
	{
		if (myController != null)
		{
			myController.onAdded();
		}
	}
	
	public function addForceVector(ForceVector:FlxVector):Void
	{
		var VelocityVector = ForceVector.clone();
		VelocityVector.length = (ForceVector.length / _mass);
		addVelocityVector(VelocityVector);
	}
	
	public function gravitateTowards(Gravitator:NewtonianSprite):Void
	{
		if (Gravitator != this && gravityEnabled)
		{
			var _curObjPos =  new FlxPoint(x + origin.x, y + origin.y);
			var _baseObjPos = new FlxPoint(Gravitator.x + Gravitator.origin.x, Gravitator.y + Gravitator.origin.y);
			// ^ these would become unnecessary if your vectors were aligned with the centre of your objects
			var _gravityVector:FlxVector = new FlxVector(_curObjPos.x, _curObjPos.y);
			_gravityVector.radians = Math.atan2(_baseObjPos.y - _curObjPos.y, _baseObjPos.x - _curObjPos.x); 
			_gravityVector.length = PhysicsGroup._gConstant * ((Gravitator._mass * _mass) / (Math.pow(_baseObjPos.distanceTo(_curObjPos), 2)));
			/*if (Gravitator.name == "Sol" && name == "Player")
			{
				trace("Gravity on " + name + " from " + Gravitator.name + " is " + Math.round(_gravityVector.length) + "N");
				var distanceToGravitator:Float = Math.round(Gravitator.getMidpoint().distanceTo(this.getMidpoint()));
				trace("Distance from " + Gravitator.name + " is " + distanceToGravitator + " px (" + (distanceToGravitator * PhysicsGroup._pixelToKmScaleFactor) + " km)");
			}*/
			// ^ calculates gravitational force
			addForceVector(_gravityVector);
		}
	}
	
	override public function update()
	{
		if (killMe == true)
		{
			myGroup.remove(this,true);
			destroy();
			super.destroy();
		}
		else{
		if (myController != null) myController.onUpdate();
		if (myWeapon != null) myWeapon.onUpdate();
		if (myThrust != null) myThrust.onUpdate();
		if (myOrbit != null) myOrbit.onUpdate();
		//for(object in 
		if (_moveVector.length > PhysicsGroup._maxSpeed) _moveVector.length = PhysicsGroup._maxSpeed;
		
			velocity.x = _moveVector.dx * _moveVector.length;
			//velocity.x = Math.pow(_moveVector.dx, 2) * _moveVector.length;
		
		
			velocity.y = _moveVector.dy * _moveVector.length;
			//velocity.y = Math.pow(_moveVector.dy, 2) * _moveVector.length * -1;
		super.update();
		}
	}
	
	public function onCollide(collidingSprite:NewtonianSprite) 
	{
		if (myController != null) myController.onCollide(collidingSprite);
		
		if (collidingSprite.rigid == true && this.rigid == true)
		{
			//_moveVector.zero();
			FlxObject.separate(this, collidingSprite);
			
			var forceVector:FlxVector = _moveVector.clone();
			var forceVectorOther:FlxVector = collidingSprite._moveVector.clone();
			forceVector = forceVector.addNew(collidingSprite._moveVector);
			forceVector.scale(collidingSprite._mass + _mass);
			
			collidingSprite.addForceVector(forceVector);
			
			forceVector.negate();
			
			addForceVector(forceVector);
		}
		//trace(forceVector);
	}
	
	/*public function getScreenX()
	{
		return x - FlxG.camera.scroll.x; 
	}
	
	public function getScreenY()
	{
		return y - FlxG.camera.scroll.y;
	}*/
	
	//CONTROLLER COMPONENT FUNCTIONS
	
	public function getController()
	{
		return myController;
	}
	
	public function attachController(newController:ObjectController)
	{
		myController = newController;
		if(myController.getAttachedObject() == null) myController.attachToObject(this);
	}
	
	public function detachController()
	{
		var oldController:ObjectController = myController;
		myController = null;
		if(oldController != null) oldController.detachFromObject();
	}
	
	//WEAPON COMPONENT FUNCTIONS
	
	public function attachWeapon(newWeapon:WeaponComponent)
	{
		myWeapon = newWeapon;
		if(myWeapon.getObject() == null) myWeapon.attachToObject(this);
	}
	
	public function detachWeapon()
	{
		var oldWeapon:WeaponComponent = myWeapon;
		myWeapon = null;
		if(oldWeapon != null) oldWeapon.detachFromObject();
	}
	
	public function getWeapon()
	{
		return myWeapon;
	}
	
	//MOVEMENT COMPONENT FUNCTIONS
	
	public function attachThrust(newThrust:ThrustComponent)
	{
		myThrust = newThrust;
		if(myThrust.getObject() == null) myThrust.attachToObject(this);
	}
	
	public function detachThrust()
	{
		var oldThrust:ThrustComponent = myThrust;
		myThrust = null;
		if(oldThrust != null) oldThrust.detachFromObject();
	}
	
	public function getThrust()
	{
		return myThrust;
	}
	
	//ORBIT
	
	public function attachOrbit(newOrbit:OrbitComponent)
	{
		myOrbit = newOrbit;
		if(myOrbit.getObject() == null) myOrbit.attachToObject(this);
	}
	
	public function detachOrbit()
	{
		var oldOrbit:OrbitComponent = myOrbit;
		myOrbit = null;
		if(oldOrbit != null) oldOrbit.detachFromObject();
	}
	
	public function getOrbit()
	{
		return myOrbit;
	}
		
	//OBSERVERS
	
	public function addObserver(newObserver:ObjectObserver)
	{
		newObserver.observeObject(this);
		myObservers.push(newObserver);
	}
	
	public function removeObserver(toRemove:ObjectObserver)
	{
		myObservers.remove(toRemove);
	}
	
	override public function destroy():Void 
	{
		for (observer in myObservers)
		{
			if (observer != null)
			{
				observer.onDestroy();
			}
		}
		if (myController != null) myController.destroy();
		if (myWeapon != null) myWeapon.destroy();
		if (myThrust != null) myThrust.destroy();
		super.destroy();
	}
	
	//SAVE AND LOAD
	
	public function getSaveData():NewtonianSaveData
	{
		var curObject:NewtonianSaveData;
		curObject = new NewtonianSaveData();
		curObject.name = name;
		curObject.type = myType;
		curObject.x = x;
		curObject.y = y;
		curObject.ID = ID;
		curObject.vectorAngle = _moveVector.radians;
		curObject.vectorLength = _moveVector.length;
		curObject.allegiance = myAllegiance;
		if (myController != null) 
		{
			curObject.controllerType = Type.getClassName(Type.getClass(myController));
			curObject.curState = myController.curStateIndex;
		}
		if (myWeapon != null) curObject.weaponType = Type.getClassName(Type.getClass(myWeapon));
		if (myThrust != null) curObject.thrustType = Type.getClassName(Type.getClass(myThrust));
		if (myOrbit != null)
		{
			curObject.orbitData = new OrbitSaveData();
			curObject.orbitData.curAngle = myOrbit.curAngle;
			if (myOrbit.orbitedObject != null) curObject.orbitData.orbitedObjectId = myOrbit.orbitedObject.ID;
			else curObject.orbitData.orbitedObjectId = -1;
			curObject.orbitData.orbitsClockwise = myOrbit.orbitsClockwise;
			curObject.orbitData.orbitX = myOrbit.orbitCentre.x;
			curObject.orbitData.orbitY = myOrbit.orbitCentre.y;
			curObject.orbitData.orbitWidth = myOrbit.orbitRadius.x;
			curObject.orbitData.orbitHeight = myOrbit.orbitRadius.y;
			curObject.orbitData.orbitTilt = myOrbit.orbitTilt;
			curObject.orbitData.orbitSpeed = myOrbit.orbitSpeed;
		}
		for (key in internalFlags.keys())
		{
			if (curObject.internalFlags == null)
			{
				curObject.internalFlags = new Map<String, String>();
			}
			curObject.internalFlags.set(key.toString(), internalFlags.get(key).toString());
		}
		return curObject;
	}
	
	public function stop()
	{
		velocity = new FlxPoint(0, 0);
		_moveVector = new FlxVector();
	}
}