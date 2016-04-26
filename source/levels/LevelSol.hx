package levels;
import flixel.FlxSubState;
import flixel.util.FlxPoint;
import objects.Asteroid;
import objects.CosmicBody;
import objects.PlayerShip;
import controllers.PlayerController;
import controllers.RepeatController;
import objects.Portal;

/**
 * ...
 * @author Frank Davies
 */
class LevelSol extends Level
{

	override public function create()
	{
		levelName = "Sol";
		width = 6400;
		height = 6400;
		wraparoundEnabled = false;
		
		//PUT THIS AT THE END OF ALL LEVELS
		
		super.create();
	}
	
	override public function onFirstCreated()
	{
		var testShip:objects.PlayerShip = new objects.PlayerShip(-5.1e3, 0);
		var theController:controllers.PlayerController = new controllers.PlayerController();
		testShip.attachController(theController);
		
		var sol:CosmicBody = new CosmicBody(0, 0);
		sol.name = "Sol";
		sol.mass = 2e30;//pretty much the real mass
		
		var earth:CosmicBody = new CosmicBody( -1000, 0);
		earth.name = "Earth";
		earth.mass = 6e24;//also the real mass
		var earthOrbit:OrbitComponent = new OrbitComponent();
		earthOrbit.orbitedObject = sol;
		earthOrbit.orbitRadius = new FlxPoint(1.4e4, 1.4e4);//140,000,000
		earthOrbit.orbitSpeed = Math.PI / 365;
		earthOrbit.orbitsClockwise = true;
		earthOrbit.curAngle = Math.PI / 2;
		earth.attachOrbit(earthOrbit);
		
		var moon:CosmicBody = new CosmicBody(-1250, 0);
		moon.name = "Moon";
		moon.mass = 7.3e22;
		var moonOrbit:OrbitComponent = new OrbitComponent();
		moonOrbit.orbitedObject = earth;
		moonOrbit.orbitRadius = new FlxPoint(40, 40);//384,400km
		moonOrbit.orbitSpeed = Math.PI / 30;
		moonOrbit.orbitsClockwise = false;
		moonOrbit.curAngle = Math.PI / 2;
		moon.attachOrbit(moonOrbit);
		
		var curRock:Asteroid;
		curRock = new Asteroid( -5e3, 0);
		physicsGroup.add(curRock);
		curRock = new Asteroid( 5e3, 0);
		physicsGroup.add(curRock);
		/*for (i in 0...5)
		{
			for (i2 in 0...5)
			{
				curRock = new Asteroid(-5e3 + (i * 100), -5e3 + (i2 * 100));
				physicsGroup.add(curRock);
			}
		}*/
		
		/*var gOrbit:OrbitComponent = new OrbitComponent();
		gOrbit.orbitCentre = new FlxPoint(0, 0);
		gOrbit.orbitRadius = new FlxPoint(1000, 1000);
		gOrbit.orbitsClockwise = true;
		gOrbit.orbitSpeed = Math.PI / 360;
		gOrbit.curAngle = Math.PI / 2;
		gravitator.attachOrbit(gOrbit);*/
		
		var northGate:Portal = new Portal(0, -2000);
		northGate.setDestination("Andromeda", 0, 2500);
		
		physicsGroup.add(testShip);
		//physicsGroup.add(sol);
		//physicsGroup.add(earth);
		//physicsGroup.add(northGate);
		//physicsGroup.add(moon);
		
		var repeatShip:objects.PlayerShip = new objects.PlayerShip(1500, 1500);
		repeatShip.myAllegiance = 2;
		repeatShip.name = "aiTest";
		
		var repeatController:controllers.RepeatController = new controllers.RepeatController();
		repeatShip.attachController(repeatController);
		
		//physicsGroup.add(repeatShip);
		
		//var tryAgain:PlayerShip = new PlayerShip(3000, 3000);
		//physicsGroup.add(tryAgain);
		
		progressFlags.set("FirstSection", "Incomplete");//okay
		progressFlags.set("CameraAttachedTo", Std.string(testShip.ID));//yep
		generateStarfield(1000);
		
		attachCamera(testShip);
		//myState.saveLevel("flash");
		//myState.saveLevel(levelName);
		super.onFirstCreated();
		//trace("xxx");
	}
	
	override public function onLoad()
	{
		var myString:String = progressFlags["CameraAttachedTo"];
		var cameraId:Int = Std.parseInt(myString);
		for (object in physicsGroup)
		{
			if (object != null) 
			{
				if (object.ID == cameraId) attachCamera(object);
			}
		}
		super.onLoad();
		//myState.saveLevel("flash");
		//trace("xxx");
	}
}