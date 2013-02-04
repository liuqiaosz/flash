package pixel.ui.control.style
{
	import flash.utils.ByteArray;

	public class UIRadioStyle extends UIStyle
	{
		private var _selectColor:uint = 0x000000;
		public function set selectColor(value:uint):void
		{
			_selectColor = value;
		}
		public function get selectColor():uint
		{
			return _selectColor;
		}
		
		private var _focusColor:uint = 0xCCCCCC;
		public function set focusColor(value:uint):void
		{
			_focusColor = value;
		}
		public function get focusColor():uint
		{
			return _focusColor
		}
		private var _focusAlpha:Number = 0.8;
		public function set focusAlpha(value:Number):void
		{
			_focusAlpha = value;
		}
		public function get focusAlpha():Number
		{
			return _focusAlpha
		}
		public function UIRadioStyle()
		{
			super();
		}
		
		override public function encode():ByteArray
		{
			var data:ByteArray = super.encode();
			data.writeUnsignedInt(_selectColor);
			data.writeUnsignedInt(_focusColor);
			data.writeFloat(_focusAlpha);
			return data;
		}
		override public function decode(data:ByteArray):void
		{
			super.decode(data);
			_selectColor = data.readUnsignedInt();
			_focusColor = data.readUnsignedInt();
			_focusAlpha = data.readFloat();
		}
	}
}