package pixel.ui.control.style
{
	import flash.utils.ByteArray;
	
	import pixel.utility.Tools;

	public class FontStyle implements IStyle
	{
		public function FontStyle()
		{
		}
		
		public function decode(Data:ByteArray):void
		{
			_FontSize = Data.readByte();
			_FontColor = Data.readUnsignedInt();
			
			_FontBold = Boolean(Data.readByte());
			_FontAlign = Data.readByte();
			var Len:int = Data.readByte();
			_FontFamily = Data.readMultiByte(Len,"cn-gb");
		}
		
		public function encode():ByteArray
		{
			var Data:ByteArray = new ByteArray();
			Data.writeByte(_FontSize);
			Data.writeUnsignedInt(_FontColor);
			
			//2012-11-23 ADD
			Data.writeByte(int(_FontBold));
			Data.writeByte(_FontAlign);
			var Len:int = Tools.StringActualLength(_FontFamily);
			Data.writeByte(Len);
			Data.writeMultiByte(_FontFamily,"cn-gb");
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
		protected var _FontAlign:int = FontTextAlignEnmu.ALIGN_LEFTTOP;
		public function set FontAlign(Value:int):void
		{
			_FontAlign = Value;
		}
		public function get FontAlign():int
		{
			return _FontAlign;
		}
		
		protected var _FontFamily:String = "Times New Roman";
		public function set FontFamily(value:String):void
		{
			_FontFamily = value;
		}
		public function get FontFamily():String
		{
			return _FontFamily;
		}
	}
}