package utility.swf.tag
{
	import utility.swf.ByteStream;
	
	import flash.utils.ByteArray;

	public class FileAttribute extends GenericTag
	{
		private var _Value:uint = 0;
		private var _Flag:uint = 8;
		public function FileAttribute(Stream:ByteStream = null)
		{
			super(Tag.FILEATTR,Stream);
		}
		
		override public function Decode(Stream:ByteStream):void
		{
			_Flag = Stream.ReadUI8();
		}
		
		override public function Encode():ByteStream
		{
			Stream.WriteUI8(_Flag);
			Stream.WriteUI16(0);
			Stream.WriteUI8(0);
			return Stream;
		}
	}
}