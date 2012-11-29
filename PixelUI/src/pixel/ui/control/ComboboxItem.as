package pixel.ui.control
{
	import flash.utils.ByteArray;
	
	import pixel.ui.core.NSPixelUI;
	import pixel.utility.ISerializable;
	import pixel.utility.Tools;

	use namespace NSPixelUI;
	
	public class ComboboxItem implements ISerializable
	{
		protected var _Label:String = "";
		public function set Label(Value:String):void
		{
			_Label = Value;
		}
		public function get Label():String
		{
			return _Label;
		}
		protected var _Value:String = "";
		public function set Value(Data:String):void
		{
			_Value = Data;
		}
		public function get Value():String
		{
			return _Value;
		}
		
		protected var _fontColor:uint = 0x000000;
		public function set fontColor(value:uint):void
		{
			_fontColor = value;
		}
		public function get fontColor():uint
		{
			return _fontColor;
		}
		
		protected var _fontSize:int = 12;
		public function set fontSize(value:int):void
		{
			_fontSize = value;
		}
		public function get fontSize():int
		{
			return _fontSize;
		}
		
		protected var _fontBold:Boolean = false;
		public function set fontBold(value:Boolean):void
		{
			_fontBold = value;
		}
		public function get fontBold():Boolean
		{
			return _fontBold;
		}
		public function ComboboxItem(LabelV:String = "",ValueV:String = "",
									 fontColor:uint = 0x000000,
									 fontSize:int = 12,
									 fontBold:Boolean = false)
		{
			_Label = LabelV;
			_Value = ValueV;
			_fontColor = fontColor;
			_fontSize = fontSize;
			_fontBold = fontBold;
		}
		
		public function Encode():ByteArray
		{
			var data:ByteArray = new ByteArray();
			
			var len:int = Tools.StringActualLength(_Label);
			data.writeShort(len);
			data.writeMultiByte(_Label,"cn-gb");
			
			len = Tools.StringActualLength(_Value);
			data.writeShort(len);
			data.writeMultiByte(_Value,"cn-gb");
			
			data.writeUnsignedInt(_fontColor);
			data.writeByte(_fontSize);
			data.writeByte(int(_fontBold));
			return data;
		}
		public function Decode(data:ByteArray):void
		{
			var len:int = data.readShort();
			_Label = data.readMultiByte(len,"cn-gb");
			
			len = data.readShort();
			_Value = data.readMultiByte(len,"cn-gb");
			_fontColor = data.readUnsignedInt();
			_fontSize = data.readByte();
			_fontBold = Boolean(data.readByte());
		}
	}
}