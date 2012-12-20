package pixel.utility
{
	import flash.utils.ByteArray;

	/**
	 * 序列化接口
	 **/
	public interface ISerializable
	{
		//function Encode():ByteArray;
		//function Decode(Data:ByteArray):void;
		function encode():ByteArray;
		function decode(data:ByteArray):void;
	}
}