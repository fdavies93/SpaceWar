package;

/**
 * ...
 * @author ...
 */
class SpacialGrid 
{
	private var width:Int;
	private var height:Int;
	private var rows:Int;
	private var columns:Int;
	private var bucketSize:Int;
	
	private var cellHeight:Float;
	private var cellWidth:Float;
	
	private var bucket:Array<Array<NewtonianSprite>>>;
	
	public function new(w:Int, h:Int, r:Int, c:Int, bs:Int) 
	{
		width = w;
		height = h;
		rows = r;
		columns = c;
		cellHeight = height / rows;//possible source of fp precision
		cellWidth = width / columns;
		bucketSize = bs;
		bucket = new Array<Array<Array<NewtonianSprite>>>();
		for (x in 0...rows)
		{
			bucket.push(new Array<Array<NewtonianSprite>>());
			for (y in bucket)
			{
				y.push(new Array<NewtonianSprite>());
			}
			
		}
	}
	
	public function addSprite(sprite:NewtonianSprite)
	{
		bucket[Math.floor(sprite.x / cellWidth)][Math.floor(sprite.y / cellHeight)].push(sprite);
	}
	
}