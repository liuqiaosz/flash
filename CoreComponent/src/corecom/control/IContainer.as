package corecom.control
{
	public interface IContainer
	{
		function GetChildById(Id:String,DeepSearch:Boolean = false):IUIControl;
		function get Children():Array;
	}
}