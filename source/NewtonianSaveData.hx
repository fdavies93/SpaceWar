package;

/**
 * ...
 * @author Frank Davies
 */
class NewtonianSaveData
{
	public var type : String;
	public var name : String;
	public var x : Float;
	public var y : Float;
	public var weaponType : String;
	public var thrustType : String;
	public var controllerType : String;
	public var curState:String;
	public var orbitData : OrbitSaveData;//can be nulled
	public var ID:Int;
	public var vectorLength : Float;
	public var vectorAngle : Float; //in radians
	public var allegiance : Int;
	public var internalFlags : Map<String,String>;
	
	public function new() {
		weaponType = "NULL";
		thrustType = "NULL";
		controllerType = "NULL";
		orbitData = null;
		internalFlags = null;
	}
}