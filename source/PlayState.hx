package;

import flixel.FlxState;
import flixel.FlxSubState;
import flixel.util.FlxSave;
import haxe.Serializer;
import haxe.Unserializer;
import Level;
import levels.LevelSol;
import levels.LevelAndromeda;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var levelMap:Map<String,Class<Level>>;
	private var myLevel:Level;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	 
	override public function create():Void
	{
		destroySubStates = true;//?
		
		levelMap = ["Sol" => LevelSol, "Andromeda" => LevelAndromeda];		
		
		var curSave = new FlxSave();
		curSave.bind("flash");
		curSave.data.exists = false;
		curSave.close();
		
		curSave = new FlxSave();
		
		for (key in levelMap.keys())//makes sure data is overwritten when new instance of game is opened
		{
			curSave.bind(key);
			curSave.data.exists = false;
			curSave.close();
		}
		
		loadLevelFromString("Sol");
		
		super.create();
	}
	
	public function loadLevelFromString(levelString:String):Void
	{
		var newLevel:Level = Type.createInstance(levelMap[levelString], new Array());
		newLevel.myState = this;
		myLevel = newLevel;
		openSubState(newLevel);
	}
	
	public function saveLevel(levelName:String):Void
	{
		//CONFIRMED: TYPING IS CAPABLE OF DETERMINING ORIGINAL CLASS TYPE EVEN AFTER VAST AMOUNTS OF RECASTING ETC
		var curLevel:Level = cast subState;
		var levelData:LevelSaveData = curLevel.getSaveData();
		var serialiser:Serializer = new Serializer();
		var flashSave:FlxSave = new FlxSave();
		flashSave.bind(levelName);
		
		flashSave.data.exists = false;
		
		flashSave.data.levelType = Type.getClassName(Type.getClass(curLevel));
		//TAKE NOTE: THEY'RE STORED (KEY, STRING, ...)
		//Progress flags
		for (key in levelData.progressFlags.keys())
		{
			serialiser.serialize(key);
			serialiser.serialize(levelData.progressFlags[key]);
		}
		serialiser.serialize("COMPLETE");
		flashSave.data.progressFlags = serialiser.toString();
		//Background data
		serialiser = new Serializer();
		var curBackData:BackgroundObjectSaveData;
		for (object in curLevel.backgroundGroup)
		{
			if (object != null)
			{
				curBackData = object.getSaveData();
				serialiser.serialize(Type.getClassName(Type.getClass(object)));
				serialiser.serialize(curBackData.x);
				serialiser.serialize(curBackData.y);
			}
		}
		serialiser.serialize("COMPLETE");
		flashSave.data.backgroundGroup = serialiser.toString();
		//Physics objects (!)
		serialiser = new Serializer();
		var curPhysData:NewtonianSaveData;
		for (object in curLevel.physicsGroup)
		{
			if (object != null)
			{
				curPhysData = object.getSaveData();
				serialiser.serialize(curPhysData.type);
				serialiser.serialize(curPhysData.ID);
				serialiser.serialize(curPhysData.name);
				serialiser.serialize(curPhysData.x);
				serialiser.serialize(curPhysData.y);
				serialiser.serialize(curPhysData.vectorAngle);
				serialiser.serialize(curPhysData.vectorLength);
				serialiser.serialize(curPhysData.controllerType);
				serialiser.serialize(curPhysData.curState);
				serialiser.serialize(curPhysData.weaponType);
				serialiser.serialize(curPhysData.thrustType);
				serialiser.serialize(curPhysData.allegiance);
				if (curPhysData.orbitData != null)
				{
					serialiser.serialize("TRUE");
					serialiser.serialize(curPhysData.orbitData.orbitX);
					serialiser.serialize(curPhysData.orbitData.orbitY);
					serialiser.serialize(curPhysData.orbitData.orbitedObjectId);
					serialiser.serialize(curPhysData.orbitData.orbitWidth);
					serialiser.serialize(curPhysData.orbitData.orbitHeight);
					serialiser.serialize(curPhysData.orbitData.orbitTilt);
					serialiser.serialize(curPhysData.orbitData.orbitSpeed);
					serialiser.serialize(curPhysData.orbitData.orbitsClockwise);
					serialiser.serialize(curPhysData.orbitData.curAngle);
				}
				else serialiser.serialize("FALSE");
				if (curPhysData.internalFlags != null)
				{
					serialiser.serialize("TRUE");
					for (key in curPhysData.internalFlags.keys())
					{
						serialiser.serialize(key.toString());
						serialiser.serialize(curPhysData.internalFlags.get(key));
					}
					serialiser.serialize("DONE");
				}
				else serialiser.serialize("FALSE");
			}
		}
		serialiser.serialize("COMPLETE");
		flashSave.data.physicsGroup = serialiser.toString();
		flashSave.data.exists = true;
		flashSave.close();
	}
	
	public function loadLevel(levelName:String):Void
	{
		var flashSave:FlxSave = new FlxSave();
		var newLevel:Level;
		var unserialiser:Unserializer;
		var curValue:Dynamic;
		var curString:String;
		var curInt:Int;
		var curPos:Int = 0;
		var exit:Bool = false;
		flashSave.bind(levelName);
		if (flashSave.data.exists)
		{
			newLevel = Type.createInstance(Type.resolveClass(flashSave.data.levelType),new Array());
			//newLevel.progressFlags = new Map<String,String>();
			//newLevel.create();
			newLevel.clear();
			newLevel.myState = this;
			//progress flags
			var keyValueArray:Array<String> = new Array<String>();
			unserialiser = new Unserializer(flashSave.data.progressFlags);
			curValue = unserialiser.unserialize();
			curString = cast(curValue, String);
			while (!exit)
			{ 
				if (curString != "COMPLETE")
				{
					for (i in 0...2)
					{
						keyValueArray.push(curString);
						curValue = unserialiser.unserialize();
						curString = cast(curValue, String);
					}
					newLevel.progressFlags.set(keyValueArray[0], keyValueArray[1]);
					for(i in 0...2) keyValueArray.pop();
				}
				else exit = true;
			}
			//background objects
			unserialiser = new Unserializer(flashSave.data.backgroundGroup);
			exit = false;
			curString = "";
			var curBackData:BackgroundObjectSaveData = new BackgroundObjectSaveData();
			var curBackObject:BackgroundObject;
			curValue = unserialiser.unserialize();
			curString = cast(curValue, String);
			while (!exit)
			{
				if (curString != "COMPLETE")
				{
					for (i in 0...3)
					{
						switch(i)
						{
							//type, x, y, controller, weapon, thrust
							case 0:
								curBackData.type = curString;
							case 1:
								curBackData.x = cast curValue;
							case 2:
								curBackData.y = cast curValue;
						}
						curValue = unserialiser.unserialize();
						if(Type.getClass(curValue) == String) curString = cast(curValue, String);
					}
					curBackObject = Type.createInstance(Type.resolveClass(curBackData.type), [curBackData.x, curBackData.y]);
					newLevel.backgroundGroup.add(curBackObject);
				}
				else exit = true;
			}
			//physics objects (holy fuck batman)
			unserialiser = new Unserializer(flashSave.data.physicsGroup);
			var curPhysData:NewtonianSaveData;
			curString = "";
			exit = false;
			curValue = unserialiser.unserialize();
			curString = cast(curValue, String);
			while (!exit)
			{
				if (curString != "COMPLETE")
				{
					curPhysData = new NewtonianSaveData();
					for (i in 0...14)
					{
						//type, id, name, x, y, controller, weapon, thrust, orbit exists(orbit data), flags exist (flag data)
						switch(i)
						{
							case 0:
								curPhysData.type = curString;
							case 1:
								curPhysData.ID = cast curValue;
							case 2:
								curPhysData.name = curString;
							case 3:
								curPhysData.x = cast curValue;
							case 4:
								curPhysData.y = cast curValue;
							case 5:
								curPhysData.vectorAngle = cast curValue;
							case 6:
								curPhysData.vectorLength = cast curValue;
							case 7:
								curPhysData.controllerType = curString;
							case 8:
								curPhysData.curState = curString;
							case 9:
								curPhysData.weaponType = curString;
							case 10:
								curPhysData.thrustType = curString;
							case 11:
								curPhysData.allegiance = cast curValue;
							case 12:
								if (curString == "TRUE")//i.e. orbit data exists
								{
									curPhysData.orbitData = new OrbitSaveData();
									for (i2 in 0...9)//x, y, object id, width, height, tilt, speed, clockwise, curAngle
									{
										curValue = unserialiser.unserialize();
										switch(i2)
										{
											case 0:
												curPhysData.orbitData.orbitX = cast(curValue, Float);
											case 1:
												curPhysData.orbitData.orbitY = cast(curValue, Float);
											case 2:
												curPhysData.orbitData.orbitedObjectId = cast(curValue, Int);
											case 3:
												curPhysData.orbitData.orbitWidth = cast(curValue, Float);
											case 4:
												curPhysData.orbitData.orbitHeight = cast(curValue, Float);
											case 5:
												curPhysData.orbitData.orbitTilt = cast(curValue, Float);
											case 6:
												curPhysData.orbitData.orbitSpeed = cast(curValue, Float);
											case 7:
												curPhysData.orbitData.orbitsClockwise = cast(curValue, Bool);
											case 8:
												curPhysData.orbitData.curAngle = cast(curValue, Float);
										}
									}
									//trace(curPhysData.orbitData.orbitWidth + " " + curPhysData.orbitData.orbitHeight + " " + curPhysData.orbitData.orbitsClockwise + " " + curPhysData.orbitData.curAngle);
								}
							case 13:
								var curKey:String = "";
								if (curString == "TRUE")//i.e. physics data exists
								{
									curPhysData.internalFlags = new Map<String, String>();
									curValue = unserialiser.unserialize();
									curString = cast(curValue, String);
									while (curString != "DONE")
									{	
										for (i2 in 0...2)
										{
											//trace(curString);
											switch (i2)
											{
												case 0:
													curKey = curString;
												case 1:
													curPhysData.internalFlags.set(curKey, curString);
											}
											curValue = unserialiser.unserialize();
											curString = cast(curValue, String);
										}
									}
								}
						}
						curValue = unserialiser.unserialize();
						if(Type.getClass(curValue) == String) curString = cast(curValue, String);
					}
					newLevel.physicsGroup.addPhysicsObjectBySaveData(curPhysData);
				}
				else exit = true;
			}
			flashSave.close();
			closeSubState();
			myLevel = newLevel;
			newLevel.physicsGroup.resolveOrbits();
			newLevel.created = true;
			openSubState(newLevel);
			newLevel.onLoad();
		}
		else {
			loadLevelFromString(levelName);
		}
		
	}
	
	public function changeLevel(newLevel:String, playerX:Float, playerY:Float)
	{
		loadLevel(newLevel);
		myLevel.changePlayerPosOnLoad(playerX, playerY);
		//myLevel.getPlayer().x = playerX;
		//myLevel.getPlayer().y = playerY;
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}
}