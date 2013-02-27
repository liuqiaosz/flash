package bleach.scene.ui
{
	import flash.display.DisplayObject;
	
	import pixel.utility.IDispose;
	import pixel.utility.IUpdate;

	public interface IPopUp extends IUpdate,IDispose
	{
		function get content():DisplayObject
	}
}