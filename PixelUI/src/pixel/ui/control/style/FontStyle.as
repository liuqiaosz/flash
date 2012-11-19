package pixel.ui.control.style
{
	import flash.utils.ByteArray;

	public class FontStyle implements IStyle
	{
		public function FontStyle()
		{
		}
		
		public function Decode(Data:ByteArray):void
		{
			_FontSize = Data.readByte();
			_FontColor = Data.readShort();
		}
		
		public function Encode():ByteArray
		{
			var Data:ByteArray = new ByteArray();
			Data.writeByte(_FontSize);
			Data.writeShort(_FontColor);
			return Data;
		}
		
		public function get ToString():String
		{
			return "";
		}
		
		protected var _FontSize:int = 12;
		public function set FontSize(Value:int):void
		{
			_FontSize = Value;
		}
		public function get FontSize():int
		{
			return _FontSize;
		}
		
		protected var _FontColor:uint = 0x000000;
		public function set FontColor(Value:uint):void
		{
			_FontColor = Value;
		}
		public function get FontColor():uint
		{
			return _FontColor;
		}
		
		protected var _FontBold:Boolean = false;
		public function set FontBold(Value:Boolean):void
		{
			_FontBold = Value;
		}
		public function get FontBold():Boolean
		{
			return _FontBold;
		}
		protected var _FontAlign:int = FontTextAlignEnmu.ALIGN_CENTER;
		public function set FontAlign(Value:int):void
		{
			_FontAlign = Value;
		}
		public function get FontAlign():int
		{
			return _FontAlign;
		}
	}
}