package;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Frank Davies
 */
class QuadTreeNode 
{
	public static var bucketSize = 4;
	
	public var position:FlxPoint;
	public var size:FlxPoint;
	public var parent:QuadTreeNode;
	public var children:Array<Array<QuadTreeNode>>;
	public var bucket:Array<NewtonianSprite>;
	
	public function new() 
	{
		bucket = new Array<NewtonianSprite>();
		parent = null;
		
		for (y in 0...2)
		{
			children.push(new Array<QuadTreeNode>());
			for (x in 0...2)
			{
				children[x].push(null);	
			}
		}
		size = new FlxPoint(0, 0);
		position = new FlxPoint(0, 0);
	}
	
	//Creates 4 child nodes below this node; each of 4 corners at 1/2 dimensions
	public function split()
	{
		var newSize:FlxPoint = new FlxPoint();
		newSize.x = parent.size.x / 2;
		newSize.y = parent.size.y / 2;
		var curCoords:FlxPoint = new FlxPoint();
		
		for (y in 0...2)
		{
			for (x in 0...2)
			{
				children[x][y] = new QuadTreeNode();
				children[x][y].size.copyFrom(newSize);
				children[x][y].position.x = position.x + (newSize.x * x);
				children[x][y].position.y = position.y + (newSize.y * y);
			}
		}
	}
	
	//Puts everything from this node's bucket into children; removes them from self
	public function reallocateContentsToChildren()
	{
		var placeX:Int = 0;
		var placeY:Int = 0;
		for (obj in bucket)
		{
			if (obj.x < (position.x + (size.x / 2))) placeX = 0;
			else placeX = 1;
			if (obj.y < (position.y + (size.y / 2))) placeY = 0;
			else placeY = 1;
			
			children[placeX][placeY].bucket.push(obj);
			bucket.remove(obj);
		}
	}
	
	
}