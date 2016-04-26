package thrusters;

/**
 * ...
 * @author Frank Davies
 */
class ThrusterPlayerShip extends ThrustComponent
{

	public function new() 
	{
		super();
		rotationSpeed = 180;
		thrustForce = 5e6;
		thrustMaxSpeed = 200;
		boostForce = 1e6;
		boostMaxSpeed = 1000;
	}
	
}