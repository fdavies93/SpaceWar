package;
import flixel.group.FlxTypedGroup;

/**
 * ...
 * @author Frank Davies
 */
class BackgroundGroup extends FlxTypedGroup<BackgroundObject> 
{

	public function new() 
	{
		super();
		active = false;
	}

	public function getSaveData():Array<BackgroundObjectSaveData>
	{
		var returnData:Array<BackgroundObjectSaveData> = new Array<BackgroundObjectSaveData>();
		for (object in this)
		{
			if (object != null)	returnData.push(object.getSaveData());
		}
		return returnData;
	}
	
}