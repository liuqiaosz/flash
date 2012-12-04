package pixel.ui.control.style
{
	import flash.utils.ByteArray;
	
	import pixel.utility.bitmap.gif.GIFFrame;

	public class UIImageStyle extends UIStyle
	{
		private var _isGif:Boolean = false;
		public function get isGif():Boolean
		{
			return _isGif;
		}
		
		
		private var _gif:ByteArray = null;
		public function set gif(value:ByteArray):void
		{
			_gif = value;
			if(null != value)
			{
				_isGif = true;
			}
			else
			{
				_isGif = false;
			}
		}
		
		public function get gif():ByteArray
		{
			return _gif;
		}
		public function UIImageStyle()
		{
			super();
		}
		
		override public function Encode():ByteArray
		{
			var data:ByteArray = super.Encode();
			data.writeByte(int(_isGif));
			if(_isGif)
			{
				data.writeBytes(_gif);
			}
			return data;
		}
		
		override public function Decode(Data:ByteArray):void
		{
			super.Decode(Data);
			_isGif = Boolean(Data.readByte());
			if(_isGif)
			{
				_gif = new ByteArray();
				Data.readBytes(_gif);
			}
		}
	}
}