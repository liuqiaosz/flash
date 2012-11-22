package pixel.utility.swf.tag
{
	import pixel.utility.swf.ByteStream;

	public interface ITag
	{
		function Encode():ByteStream;
		function Decode(Stream:ByteStream):void;
		function get Source():Object;
	}
}