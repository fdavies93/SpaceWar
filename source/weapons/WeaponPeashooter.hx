package weapons;

/**
 * ...
 * @author Frank Davies
 */
class WeaponPeashooter extends WeaponComponent 
{

	public function new() 
	{
		super();
		bulletFireAngle = 0;
		bulletReloadTime = 0.25;
		bulletSpawnAngle = 0;
		bulletSpeed = 1000;
		bulletSpawnDistance = 50;
	}
	
}