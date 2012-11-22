package pixel.utility.swf.tag
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.JPEGLoaderContext;
	import flash.utils.ByteArray;
	
	import pixel.utility.swf.ByteStream;
	import pixel.utility.swf.event.SWFEvent;

	public class BitJPEG2 extends GenericBit
	{
		public function BitJPEG2(Stream:ByteStream = null)
		{
			super(Tag.DEFINEJPEG2,Stream);
		}
		
		override public function Decode(Stream:ByteStream):void
		{
			_TagId = Stream.ReadUI16();
			_BitmapBytes = Stream.ReadBytes();
			Reader = new Loader();
			Reader.contentLoaderInfo.addEventListener(Event.COMPLETE,LoadComplete);
			var Context:JPEGLoaderContext = new JPEGLoaderContext();
			
			Reader.loadBytes(_BitmapBytes.Bytes,Context);
		}
		
		private var Reader:Loader = null;
		private function LoadComplete(event:Event):void
		{
			Reader.contentLoaderInfo.removeEventListener(Event.COMPLETE,LoadComplete);
			_Image = Reader.content as Bitmap;
			dispatchEvent(new SWFEvent(SWFEvent.ASYNCLOAD_COMPLETE));
		}
		
		private var _Image:Bitmap = null;
		override public function get Source():Object
		{
			if(_Image)
			{
				return _Image;
			}
			return null;
		}
	}
}