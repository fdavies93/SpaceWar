package;

import flixel.util.FlxPoint;

/**
 * ...
 * @author Frank Davies
 */
class FlxPointExtender 
{
	static public function rotatePoint(toRotate:FlxPoint, originPoint:FlxPoint, rotation:Float, isRadians:Bool=true):FlxPoint
	{
		if (!isRadians) rotation = (rotation / 360) * (2 * Math.PI);
		
		var rotatedPoint:FlxPoint = new FlxPoint(toRotate.x - originPoint.x, toRotate.y - originPoint.y);
		
		var oldX = rotatedPoint.x;
		
		rotatedPoint.x = Math.round((rotatedPoint.x * Math.cos(rotation)) - (rotatedPoint.y * Math.sin(rotation)));
		rotatedPoint.y = Math.round((rotatedPoint.y * Math.cos(rotation)) + (oldX * Math.sin(rotation)));
		
		rotatedPoint.x += originPoint.x;
		rotatedPoint.y += originPoint.y;
		
		return rotatedPoint;
	}
}