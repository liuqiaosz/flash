package pixel.ui.control
{
	import flash.utils.ByteArray;

	public interface IUIControlFactory
	{
		function Encode(Control:IUIControl):ByteArray;
		function Decode(Data:ByteArray):Vector.<UIControl>;
	}
}