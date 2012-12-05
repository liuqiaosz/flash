package pixel.ui.control
{
	import flash.utils.ByteArray;
	import pixel.ui.control.vo.UIMod;

	public interface IUIControlFactory
	{
		function Encode(Control:IUIControl):ByteArray;
		function encode(mod:UIMod):ByteArray;
		function Decode(Data:ByteArray):UIMod;
	}
}