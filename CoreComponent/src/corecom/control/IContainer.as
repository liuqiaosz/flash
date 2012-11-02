package corecom.control
{
	public interface IContainer
	{
		function GetChildById(Id:String):IUIControl;
		function get Children():Array;
	}
}