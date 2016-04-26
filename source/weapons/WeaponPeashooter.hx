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
		bulletReloadTime = 1;
		bulletSpawnAngle = 0;
		bulletSpeed = 300;
		bulletSpawnDistance = 25;
	}
	
}