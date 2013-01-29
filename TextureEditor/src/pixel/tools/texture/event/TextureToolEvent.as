package pixel.tools.texture.event
{
	import flash.events.Event;

	public class TextureToolEvent extends Event
	{
		public static const TEXTURE_UPDATEPREVIEW:String = "UpdatePreview";
		public static const TEXTURE_APPLYCHANGE:String = "ApplyChange";
		public static const TEXTURE_APPLYENCODE:String = "ApplyEncode";
		public static const TEXTURE_SAVETPK:String = "SaveTPK";
		
		private var _value:Object = null;
		public function set value(data:Object):void
		{
			_value = data;
		}
		public function get value():Object
		{
			return _value;
		}
		public function TextureToolEvent(type:String,bubbles:Boolean=true)
		{
			super(type,bubbles);
		}
	}
}