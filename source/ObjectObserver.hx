package;

/**
 * ...
 * @author ...
 */
class ObjectObserver
{

	private var observedObject:NewtonianSprite;
	
	public function new(object:NewtonianSprite = null) 
	{
		observeObject(object);
	}
	
	public function observeObject(object:NewtonianSprite)
	{
		if (object != null)
		{
			observedObject = object;
		}
	}
	
	public function onUpdate()
	{
		
	}
	
	public function onDestroy()
	{
		observedObject = null;
	}
	
	public function getObject():NewtonianSprite
	{
		return observedObject;
	}
	
}