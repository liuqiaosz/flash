package pixel.ui.control
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.style.FontStyle;
	import pixel.ui.core.NSPixelUI;
	import pixel.utility.Tools;
	
	use namespace NSPixelUI;
	public class UITextBase extends UIControl
	{
		private var _TextValue:String = "";
		private var _TextField:TextField = null;
		private var _Format:TextFormat = null;
		public function UITextBase(Skin:Class,Text:String = "")
		{
			super(Skin);
			_TextField = new TextField();
			_TextValue = Text;
			_TextField.text = _TextValue;
			_TextField.selectable = false;
			_Format = new TextFormat();
			_Format.size = _Style.FontTextStyle.FontSize;
			_Format.color = _Style.FontTextStyle.FontColor;
			_Format.font = _Style.FontTextStyle.FontFamily;
			_Format.bold = _Style.FontTextStyle.FontBold;
			_TextField.defaultTextFormat = _Format;
			Align = TextAlign.LEFT;
			addChild(_TextField);
			
			//_TextField.width = width - _Style.BorderThinkness * 2;
			//_TextField.height = height - _Style.BorderThinkness * 2;
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
			_Style.FontTextStyle.FontFamily = _Format.font = Value;
			updateFormat();
		}
		public function get FontFamily():String
		{
			return _Style.FontTextStyle.FontFamily;
		}
		
		public function get TextWidth():int
		{
			return _TextField.textWidth;
		}
		public function get TextHeight():int
		{
			return _TextField.textHeight;
		}
		
		public function set FontBold(value:Boolean):void
		{
			_Format.bold = _Style.FontTextStyle.FontBold = value;
			updateFormat();
		}
		
		public function set FontSize(Value:int):void
		{
			_Format.size = _Style.FontTextStyle.FontSize = Value;
			updateFormat();
			
		}
		public function get FontSize():int
		{
			return int(_Format.size);
		}
		public function set FontColor(Value:uint):void
		{
			_Format.color = _Style.FontTextStyle.FontColor = Value;
			updateFormat();
		}
		
		private function updateFormat():void
		{
			_TextField.defaultTextFormat = _Format;
			_TextField.text = _TextField.text;
		}
		public function get FontColor():uint
		{
			return uint(_Format.color);
		}
		
		/**
		 * 是否允许输入
		 * 
		 **/
		public function set Input(Value:Boolean):void
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
			var text:String = "";
			if(Len > 0)
			{
			//Text = Data.readUTFBytes(Len);
				text = Data.readMultiByte(Len,"cn-gb");
			}
			//Text = Data.readMultiByte(Len,"cn-gb");
//			FontSize = Data.readByte();
//			FontColor = Data.readUnsignedInt();
//			Len = Data.readByte();
//			var font:String = Data.readUTFBytes(Len);
			//FontFamily = font;
			_Format.size = _Style.FontTextStyle.FontSize;
			_Format.color = _Style.FontTextStyle.FontColor;
			_Format.font = _Style.FontTextStyle.FontFamily;
			_Format.bold = _Style.FontTextStyle.FontBold;
			
			//_TextField.defaultTextFormat = _Format;
			
			_TextField.width = width;
			_TextField.height = height;
			
			Text = text;
			this.updateFormat();
//			
//			Text = text;
		}
		
		public function applyFontStyle(style:FontStyle):void
		{
			_Format.bold = _Style.FontTextStyle.FontBold = style.FontBold;
			_Format.color = _Style.FontTextStyle.FontColor = style.FontColor;
			_Format.font = _Style.FontTextStyle.FontFamily = style.FontFamily;
			_Format.size = _Style.FontTextStyle.FontSize = style.FontSize;
			updateFormat();
			//_Style.FontTextStyle.FontAlign = style.FontAlign;
		}
		
		override protected function SpecialEncode(Data:ByteArray):void
		{
			var Len:int = Tools.StringActualLength(_TextValue);
			Data.writeShort(Len);
			Data.writeMultiByte(_TextValue,"cn-gb");
		}
	}
}