package levels;
import objects.Portal;

/**
 * ...
 * @author ...
 */
class LevelAndromeda extends Level
{

	override public function create():Void 
	{
		levelName = "Andromeda";
		width = 6400;
		height = 6400;
		wraparoundEnabled = false;
		
		super.create();
		
		attachCameraToPlayer();
	}
	
	override public function onFirstCreated() 
	{
		var testShip:objects.PlayerShip = new objects.PlayerShip(0, 0);
		var theController:controllers.PlayerController = new controllers.PlayerController();
		testShip.attachController(theController);
		
		var southPortal:Portal = new Portal(0, 2600);
		southPortal.setDestination("Sol", 0, -1900);
		
		physicsGroup.add(testShip);
		physicsGroup.add(southPortal);
		generateStarfield(1000);
		super.onFirstCreated();
	}
	
}