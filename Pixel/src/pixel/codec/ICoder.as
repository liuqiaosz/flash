package pixel.codec
{
	import flash.utils.ByteArray;

	public interface ICoder
	{
		function encode():ByteArray;
		function decode(data:ByteArray):void;
	}
}