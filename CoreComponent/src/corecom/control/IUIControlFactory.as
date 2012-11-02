package corecom.control
{
	import flash.utils.ByteArray;

	public interface IUIControlFactory
	{
		function Encode(Control:IUIControl):ByteArray;
		function Decode(Data:ByteArray):IUIControl;
	}
}