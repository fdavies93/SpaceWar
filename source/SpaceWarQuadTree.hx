package;
import flixel.system.FlxList;
import flixel.system.FlxQuadTree;
using SpaceWarQuadTree;

/**
 * ...
 * @author ...
 */

//Adds functionality related to physics to the basic quadtree structure
//PROBABLY BEST IF THIS BECOMES A STATIC EXTENSION (to FlxQuadTree)
@:access(flixel.system.FlxQuadTree)//fixes problems with accessing private variables in FlxQuadTree through static extension
class SpaceWarQuadTree
{	
	/*
	 * Call this BEFORE update and resolving collsions
	 */ 
	public static function applyGravity(toUpdate:FlxQuadTree, gravitatorX:Float, gravitatorY:Float, gravitatorMass:Float)
	{
		
	}
	
	/* Reallocate objects to new nodes based on their current position.
	 * Allows the quadtree to become useful when dealing with a large number of moving objects
	 * (i.e. in SpaceWar) at the cost of some efficiency.
	 */
	public static function update(toUpdate:FlxQuadTree):FlxList
	{
		var _iterator:FlxList = _headA;
		var listHead:FlxList = null;//possible problem (horrifying memory leaks)
		var curEntry:FlxList = null;
		while (_iterator != null)
		{
			//if object's out of bounds, let the next node up deal with it; otherwise do nothing
			if (_iterator.object.x < x || _iterator.object.x > x + _halfWidth || _iterator.object.y < y || _iterator.object.y > y + _halfHeight)
			{
				if (listHead == null)
				{
					listHead = FlxList.recycle();
					listHead.object = _iterator.object;
					listHead.next = null;
				}
				else
				{
					curEntry = FlxList.recycle();
					curEntry.object = _iterator.object;
					curEntry.next = listHead;
					listHead
				}
			}
			//deal with everything from nodes below (i.e. that couldn't find a place)
			var se:FlxList = toUpdate._southEastTree.update();
			var sw:FlxList = toUpdate._southWestTree.update();
			var ne:FlxList = toUpdate._northEastTree.update();
			var nw:FlxList = toUpdate._northWestTree.update();
			_iterator = _iterator.next;
		}
	}
}