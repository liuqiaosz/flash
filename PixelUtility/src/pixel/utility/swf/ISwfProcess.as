package pixel.utility.swf
{
	import flash.utils.ByteArray;

	public interface ISwfProcess
	{
		function Encode(SwfFile:Swf):ByteArray;
		function Decode(Source:ByteArray):Swf;
	}
}