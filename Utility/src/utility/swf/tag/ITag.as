package utility.swf.tag
{
	import utility.swf.ByteStream;

	public interface ITag
	{
		function Encode():ByteStream;
		function Decode(Stream:ByteStream):void;
		function get Source():Object;
	}
}