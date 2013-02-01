package swf.tag
{
	import swf.ByteStream;
	
	import flash.utils.ByteArray;
	
	import pixel.utility.Tools;

	public class SetBackgroundColor extends GenericTag
	{
		private var _Color:uint = 0;
		public function SetBackgroundColor(Stream:ByteStream = null)
		{
			super(Tag.SETBGCOLOR,Stream);
		}
		
		override public function Decode(Stream:ByteStream):void
		{
			
		}
		
		override public function Encode():ByteStream
		{
			Stream.WriteUI8(0xFF);
			Stream.WriteUI8(0xFF);
			Stream.WriteUI8(0xFF);
			return Stream;
		}
	}
}