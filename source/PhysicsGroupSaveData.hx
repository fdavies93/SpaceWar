package;

/**
 * ...
 * @author Frank Davies
 */
class PhysicsGroupSaveData 
{
	public var curId : Int;
	public var objects : Array<NewtonianSaveData>;
	
	public function new() 
	{
		objects = new Array<NewtonianSaveData>();
	}
	
}