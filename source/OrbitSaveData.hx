package;

/**
 * ...
 * @author Frank Davies
 */
class OrbitSaveData 
{
	public var orbitX : Float;//x, y
	public var orbitY : Float;
	public var orbitWidth : Float;
	public var orbitHeight : Float;
	public var orbitSpeed : Float;//in radians per second
	public var orbitTilt : Float;//in degrees
	public var orbitsClockwise : Bool;//if true, orbits clockwise; if false, anticlockwise
	public var curAngle : Float;
	public var orbitedObjectId : Int;
	
	public function new() {
		
	}
}