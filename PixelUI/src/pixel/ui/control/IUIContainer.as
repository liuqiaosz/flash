package pixel.ui.control
{
	public interface IUIContainer
	{
		function GetChildById(Id:String,DeepSearch:Boolean = false):IUIControl;
		function get Children():Array;
		function removeAllChildren():void;
	}
}