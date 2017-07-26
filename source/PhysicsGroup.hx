package;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.FlxG;
import flixel.system.FlxQuadTree;
import flixel.util.FlxVector;

/**
 * ...
 * @author Frank Davies
 */
class PhysicsGroup extends FlxTypedGroup<NewtonianSprite> 
{
	public static var _gConstant:Float = 6.67408e-20;//mess with this for a smaller universe ;)
	//6.67408e-11 = REAL GRAVITATIONAL CONSTANT
	public static var _maxSpeed:Float = 1000;//in px/s; a 'universal speed limit
	public static var _gravitatorMass:Float = 1e18;//the cutoff point above which an object attracts other objects 
	//converts to m/s via scaleFactor
	public var myLevel:Level;
	public var curId:Int;
	public var allowInput:Bool;
	public var chatListeners:Array<ChatListener>;
	public var spaceObservers:Array<SpaceObserver>;
	public var quadTree:FlxQuadTree;
	
	public function new(level:Level) 
	{
		curId = 0;
		myLevel = level;
		allowInput = true;
		chatListeners = new Array<ChatListener>();
		spaceObservers = new Array<SpaceObserver>();
		//quadTree = FlxQuadTree.recycle;
		super();
	}
	
	override public function update():Void
	{
		super.update();
		for (observer in spaceObservers)
		{
			observer.clearObservedList();
		}
		
		var object:NewtonianSprite;
		var object2:NewtonianSprite;
		
		var i:Int = this.members.length-1;
		var i2:Int = i-1;
		
		while(i >= 1)
		{
			object = this.members[i];
			while(i2 >= 0)
			{
				
				object2 = this.members[i2];
				
				if (object != object2)
				{
					//gravity check
					if (object._mass >= 1e24 && object2.gravityEnabled) object2.gravitateTowards(object); 
					
					//collision check
					if (object.collisionsEnabled && object2.collisionsEnabled)
					{
						if (object.overlaps(object2)) {
							object.onCollide(object2);
							object2.onCollide(object);
						}
					}
				}
				i2--;
			}
			i--;
			i2 = i - 1;
			
			for (observer in spaceObservers)//might need refactoring
			{
				if (observer.myController != null) observer.addObservedObject(object);
				//this can be refined based on spacial division too
				else spaceObservers.remove(observer);
			}
		}
		
		/*for (object in this)//naughty naughty, very naughty
		{
			for (object2 in this)
			{
				
			}
			
			for (observer in spaceObservers)//might need refactoring
			{
				if (observer.myController != null) observer.addObservedObject(object);
				//this can be refined based on spacial division too
				else spaceObservers.remove(observer);
			}
		}*/
	}
	
	override public function add(Object:NewtonianSprite):NewtonianSprite 
	{
		Object.myGroup = this;
		if(Object.ID == -1){//i.e. not on load
			Object.ID = curId;
			curId++;
		}
		else if(Object.ID > curId){//on load; makes sure curId is always set correctly after load (for orbits etc)
			curId = Object.ID + 1;
		}
		var curObjectController = Object.getController();
		if (curObjectController != null) 
		{
			if (curObjectController.chatListener != null) addChatListener(curObjectController.chatListener);
			if (curObjectController.spaceObserver != null) addSpaceObserver(curObjectController.spaceObserver);
		}
		//add object to quad tree
		//quadTree.add(Object, FlxQuadTree.A_LIST);
		//if (Object.mass >= _gravitatorMass) quadTree.add(Object, FlxQuadTree.B_LIST);
		//this not correct : we need giant invisible discs ;)
		myLevel.onAddPhysicsObject(Object);
		Object.onAdded();
		return super.add(Object);
	}
	
	public function sendChatMessage(message:String, sender:NewtonianSprite)
	{
		myLevel.UIGroup.myChatBox.receiveMessage(message, sender);
		for (listener in chatListeners)
		{
			if (listener.myObjectController != null)
			{
				listener.onReceiveMessage(message, sender);
			}
			else 
			{
				chatListeners.remove(listener);
			}
		}
		//AI code etc. here
	}
	
	public function getSaveData():PhysicsGroupSaveData 
	{
		var returnData = new PhysicsGroupSaveData();
		returnData.curId = curId;
		for (object in this)
		{
			if (object != null) returnData.objects.push(object.getSaveData());
		}
		return returnData;
	}
	
	public function getById(objectId:Int):NewtonianSprite
	{
		for (object in this)
		{
			if (object != null)
			{
				if (object.ID == objectId) return object;
			}
		}
		return null;
	}
	
	public function addPhysicsObjectBySaveData(saveData:NewtonianSaveData)
	{
		//type, id, name, x, y, controller, weapon, thrust, orbit exists(orbit data)
		var newObject:NewtonianSprite = Type.createInstance(Type.resolveClass(saveData.type), new Array());
		var newController:ObjectController;
		
		newObject.ID = saveData.ID;
		newObject.name = saveData.name;
		newObject.x = saveData.x;
		newObject.y = saveData.y;
		newObject._moveVector.length = saveData.vectorLength;
		newObject._moveVector.rotateByRadians(saveData.vectorAngle);
		newObject.myAllegiance = saveData.allegiance;
		//newObject.addVelocityVector(addVector);
		if (saveData.controllerType != "NULL") 
		{
			newObject.attachController(Type.createInstance(Type.resolveClass(saveData.controllerType), new Array()));
			newObject.getController().changeState(saveData.curState);
		}
		if (saveData.weaponType != "NULL") newObject.attachWeapon(Type.createInstance(Type.resolveClass(saveData.weaponType), new Array()));
		if (saveData.thrustType != "NULL") newObject.attachThrust(Type.createInstance(Type.resolveClass(saveData.thrustType), new Array()));
		if (saveData.orbitData != null)//x, y, object id, width, height, tilt, speed, clockwise, curAngle
		{
			var newOrbit:OrbitComponent = new OrbitComponent();
			newOrbit.orbitCentre.x = saveData.orbitData.orbitX;
			newOrbit.orbitCentre.y = saveData.orbitData.orbitY;
			newOrbit.orbitRadius.x = saveData.orbitData.orbitWidth;
			newOrbit.orbitRadius.y = saveData.orbitData.orbitHeight;
			newOrbit.orbitTilt = saveData.orbitData.orbitTilt;
			newOrbit.orbitSpeed = saveData.orbitData.orbitSpeed;
			newOrbit.orbitsClockwise = saveData.orbitData.orbitsClockwise;
			newOrbit.curAngle = saveData.orbitData.curAngle;
			newOrbit.orbitedId = saveData.orbitData.orbitedObjectId;
			newObject.attachOrbit(newOrbit);
		}
		if (saveData.internalFlags != null)
		{
			for (key in saveData.internalFlags.keys())
			{
				newObject.internalFlags.set(key, saveData.internalFlags.get(key));
			}
		}
		add(newObject);
	}
	
	//chat listeners
	
	public function addChatListener(listener:ChatListener)
	{
		chatListeners.push(listener);
	}
	
	public function removeChatListener(listener:ChatListener)
	{
		for (curListener in chatListeners)
		{
			if (curListener == listener)
			{
				curListener.destroy();
			}
		}
		chatListeners.remove(listener);
	}
	
	//space observers
	
	public function addSpaceObserver(observer:SpaceObserver)
	{
		spaceObservers.push(observer);
	}
	
	public function removeSpaceObserver(observer:SpaceObserver)
	{
		for (curObserver in spaceObservers)
		{
			if (curObserver == observer)
			{
				curObserver.destroy();
			}
		}
		spaceObservers.remove(observer);
	}
	
	public function resolveOrbits()
	{
		for (object in this)
		{
			if (object.getOrbit() != null)
			{
				if (object.getOrbit().orbitedId != -1)
				{
					for (object2 in this)
					{
						if (object2.ID == object.getOrbit().orbitedId)
						{
							object.getOrbit().orbitedObject = object2;
						}
					}
				}
			}
		}
	}
}