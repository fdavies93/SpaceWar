package;
import flixel.util.FlxPoint;

/**
 * ...
 * @author ...
 */
class SpacialPartition 
{
	public static var gridTopLeft:FlxPoint = new FlxPoint(-32768, -32768);
	public static var gridSize:FlxPoint = new FlxPoint(65536, 65536);
	
	private var head:QuadTreeNode;
	
	public function new() 
	{
		head = new QuadTreeNode;
		head.position.copyFrom(gridTopLeft);
		head.size.copyFrom(gridSize);
	}
	
	public function buildQuadTree(group:PhysicsGroup)
	{
		
	}
	
	public function allocateObject(object:NewtonianSprite)
	{
		
	}
	
	public function calculateGravitation(gravitatorList:Array<NewtonianSprite>)
	{
		//calculate range of gravitators
		//apply gravitation to all objects in range of gravitators
	}
	
}