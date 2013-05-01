package pixel.ui.control
{
	import flash.display.DisplayObject;
	
	/**
	 * UI组件容器接口
	 * 
	 **/
	public interface IUIContainer extends IUIControl
	{
		function GetChildById(Id:String,DeepSearch:Boolean = false):IUIControl;
		function get Children():Array;
		function removeAllChildren():void;
		
	}
}