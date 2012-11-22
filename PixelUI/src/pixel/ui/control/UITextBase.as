package pixel.ui.control
{
	import pixel.ui.control.event.UIControlEvent;
	import pixel.ui.core.LibraryInternal;
	
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	
	import pixel.utility.Tools;
	
	use namespace LibraryInternal;
	public class UITextBase extends UIControl
	{
		private var _TextValue:String = "";
		private var _TextField:TextField = null;
		private var _Format:TextFormat = null;
		private var _DefaultFontSize:int = 12;
		private var _DefaultFontColor:uint = 0x000000;
		private var _DefaultFamily:String = "Times New Roman";
		public function UITextBase(Skin:Class,Text:String = "")
		{
			super(Skin);
			_TextField = new TextField();
			_TextValue = Text;
			_TextField.text = _TextValue;
			_TextField.selectable = false;
			_Format = new TextFormat();
			_Format.size = _DefaultFontSize;
			_Format.color = _DefaultFontColor;
			_Format.font = _DefaultFamily;
			_TextField.defaultTextFormat = _Format;
			Align = TextAlign.LEFT;
			addChild(_TextField);
		}
		
		public function set Text(Value:String):void
		{
			_TextField.text = _TextValue = Value;
		}
		public function get Text():String
		{
			return _TextField.text;
		}
		private var _AlignValue:int = TextAlign.LEFT;
		public function set Align(Value:int):void
		{
			switch(Value)
			{
				case TextAlign.CENTER:
					_TextField.autoSize = TextFieldAutoSize.CENTER;
					break;
				case TextAlign.LEFT:
					_TextField.autoSize = TextFieldAutoSize.LEFT;
					break;
				case TextAlign.RIGHT:
					_TextField.autoSize = TextFieldAutoSize.RIGHT;
					break;
				default:
			}
			_AlignValue = Value;
		}
		public function get Align():int
		{
			return _AlignValue;
		}
		
		public function set FontFamily(Value:String):void
		{
			_Format.font = Value;
			_TextField.defaultTextFormat = _Format;
			_TextField.text = _TextField.text;
		}
		
		public function get TextWidth():int
		{
			return _TextField.textWidth;
		}
		public function get TextHeight():int
		{
			return _TextField.textHeight;
		}
		
		public function set FontSize(Value:int):void
		{
			_Format.size = Value;
			_TextField.defaultTextFormat = _Format;
			_TextField.text = _TextField.text;
			
		}
		public function get FontSize():int
		{
			return int(_Format.size);
		}
		public function set FontColor(Value:uint):void
		{
			_Format.color = Value;
			_TextField.defaultTextFormat = _Format;
			
		}
		public function get FontColor():uint
		{
			return uint(_Format.color);
		}
		
		/**
		 * 是否允许输入
		 * 
		 **/
		LibraryInternal function set Input(Value:Boolean):void
		{
			_TextField.type = Value ? TextFieldType.INPUT:TextFieldType.DYNAMIC;
		}
		
		public function set Mutiline(Value:Boolean):void
		{
			_TextField.multiline = Value;
			_TextField.wordWrap = Value;
		}
		public function get Mutiline():Boolean
		{
			return _TextField.multiline;
		}
		
		private function DownProxy(event:MouseEvent):void
		{
			if(event.target != _TextField)
			{
				this._Frame.EnableDragStart(event.target);
			}
			else
			{
				event.stopPropagation();
				var Notify:MouseEvent = new MouseEvent(MouseEvent.MOUSE_DOWN);
				var Pos:Point = new Point();
				Pos.x = stage.mouseX;
				Pos.y = stage.mouseY;
				Pos = globalToLocal(Pos);
				Notify.localX = Pos.x;
				Notify.localY = Pos.y;
				dispatchEvent(Notify);
			}
		}
		
		override public function EnableEditMode():void
		{
			super.EnableEditMode();
			Input = false;
			addEventListener(MouseEvent.MOUSE_DOWN,DownProxy,true);
		}
		
		override protected function SpecialDecode(Data:ByteArray):void
		{
			var Len:int = Data.readShort();
			//Text = Data.readUTFBytes(Len);
			Text = Data.readMultiByte(Len,"cn-gb");
			FontSize = Data.readByte();
			FontColor = Data.readUnsignedInt();
			Len = Data.readByte();
			FontFamily = Data.readUTFBytes(Len);
			
			_TextField.width = width;
			_TextField.height = height;
		}
		override protected function SpecialEncode(Data:ByteArray):void
		{
			var Len:int = Tools.StringActualLength(_TextValue);
			Data.writeShort(Len);
			
			Data.writeMultiByte(_TextValue,"cn-gb");
			Data.writeByte(int(_Format.size));
			Data.writeUnsignedInt(uint(_Format.color));
			Data.writeByte(_Format.font.length);
			Data.writeUTFBytes(_Format.font);
		}
	}
}