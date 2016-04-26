package objects;

import flixel.util.FlxPoint;
import flixel.FlxG;
import flixel.util.FlxVector;
import NewtonianSprite;
using FlxPointExtender;

/**
 * ...
 * @author Frank Davies
 */

 /*
	There's now no distinction between CosmicBodies and other types of NewtonianSprite; to make the generic type into a cosmic
	body just requires attaching a OrbitComponent.
*/
class CosmicBody extends NewtonianSprite
{
	public function new(?X:Float = 0, ?Y: Float = 0)
	{
		super(X, Y, 1e24);
		//3e23
		loadGraphic(AssetPaths.miniSun__png);
		collisionsEnabled = true;
		mySuperType = "CosmicBody";
		pixelPerfectRender = false;
	}
	
	override public function update() 
	{
		super.update();
		//trace(x + " " + y);
	}
	
}