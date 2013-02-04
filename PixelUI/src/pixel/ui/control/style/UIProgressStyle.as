package pixel.ui.control.style
{
	import flash.utils.ByteArray;

	public class UIProgressStyle extends UIStyle
	{
		private var _barColor:uint = 0xCCCCCC;
		public function set barColor(value:uint):void
		{
			_barColor = value;
		}
		public function get barColor():uint
		{
			return _barColor;
		}
		private var _barAlpha:Number = 1;
		public function set barAlpha(value:Number):void
		{
			_barAlpha = value;
		}
		public function get barAlpha():Number
		{
			return _barAlpha;
		}
		public function UIProgressStyle()
		{
			super();
		}
		
		override public function encode():ByteArray
		{
			var data:ByteArray = super.encode();
			data.writeUnsignedInt(_barColor);
			data.writeFloat(_barAlpha);
			return data;
		}
		override public function decode(data:ByteArray):void
		{
			super.decode(data);
			_barColor = data.readUnsignedInt();
			_barAlpha = data.readFloat();
		}
	}
}