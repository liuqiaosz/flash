package pixel.ui.control
{
	import flash.display.BitmapData;
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
		
		protected var _hasIcon:Boolean = false;
		public function set hasIcon(value:Boolean):void
		{
			_hasIcon = value;
		}
		public function get hasIcon():Boolean
		{
			return _hasIcon;
		}
		
		protected var _importIcon:Boolean = false;
		public function set importIcon(value:Boolean):void
		{
			_importIcon = value;
		}
		public function get importIcon():Boolean
		{
			return _importIcon;
		}
		
		protected var _icon:BitmapData = null;
		public function set icon(value:BitmapData):void
		{
			_icon = value;
		}
		public function get icon():BitmapData
		{
			return _icon;
		}
		
		protected var _iconId:String = "";
		public function set iconId(value:String):void
		{
			_iconId = value;
		}
		public function get iconId():String
		{
			return _iconId;
		}
		
		protected var _libId:String = "";
		public function set libId(value:String):void
		{
			_libId = value;
		}
		public function get libId():String
		{
			return _libId;
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
		
		public function encode():ByteArray
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
			
			data.writeByte(int(_hasIcon));
			
			//是否加载图标
			if(_hasIcon)
			{
				data.writeByte(int(_importIcon));
				//图标是否打包
				if(_importIcon)
				{
					data.writeByte(_icon.width);
					data.writeByte(_icon.height);
					data.writeBytes(_icon.getPixels(_icon.rect));
				}
				else
				{
					data.writeByte(_libId.length);
					data.writeUTFBytes(_libId);
					data.writeByte(_iconId.length);
					data.writeUTFBytes(_iconId);
				}
			}
			return data;
		}
		public function decode(data:ByteArray):void
		{
			var len:int = data.readShort();
			_Label = data.readMultiByte(len,"cn-gb");
			
			len = data.readShort();
			_Value = data.readMultiByte(len,"cn-gb");
			_fontColor = data.readUnsignedInt();
			_fontSize = data.readByte();
			_fontBold = Boolean(data.readByte());
			
			_hasIcon = Boolean(data.readByte());
			
			if(_hasIcon)
			{
				_importIcon = Boolean(data.readByte());
				if(_importIcon)
				{
					var imgW:int = data.readByte();
					var imgH:int = data.readByte();
					var pixels:ByteArray = new ByteArray();
					data.readBytes(pixels,0,imgW * imgH);
					var img:BitmapData = new BitmapData(imgW,imgH);
					img.setPixels(img.rect,pixels);
				}
				else
				{
					len = data.readByte();
					_libId = data.readUTFBytes(len);
					len = data.readByte();
					_iconId = data.readUTFBytes(len);
				}
			}
		}
	}
}