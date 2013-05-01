package pixel.ui.export
{
	import flash.utils.ByteArray;
	
	import pixel.ui.control.IUIControl;
	import pixel.ui.control.UIControl;
	import pixel.utility.ISerializable;

	
	public interface IPixelUIExport
	{
		function encode(control:IUIControl):ByteArray;
		
	}
}