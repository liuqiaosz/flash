package pixel.ui.export
{
	import flash.utils.ByteArray;
	import pixel.ui.control.UIControl;

	public interface IPixelUIImport
	{
		function decode(source:ByteArray):UIControl;
	}
}