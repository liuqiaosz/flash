package corecom.control
{
	import corecom.control.style.FontTextAlignEnmu;
	import corecom.control.style.LabelStyle;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.engine.TextLine;
	import flash.utils.ByteArray;

	public class UILabel extends UITextBase //extends UIControl
	{
		public function UILabel(TextValue:String = "",Skin:Class = null)
		{
			var SkinClass:Class = Skin ? Skin:LabelStyle;
			super(SkinClass,TextValue);
		}
		
//		private var _Text:String = "";
//		public function get Text():String
//		{
//			return _Text;
//		}
//		public function set Text(Value:String):void
//		{
//			if(Value && "" != Value)
//			{
//				_Text = Value;
//				if(_FontText && contains(_FontText))
//				{
//					removeChild(_FontText);
//				}
//				if(_AutoResize)
//				{
//					_FontText = FontTextFactory.Instance.TextByStyle(Value,Style.FontTextStyle);	
//				}
//				else
//				{
//					_FontText = FontTextFactory.Instance.TextByStyle(Value,Style.FontTextStyle,width);
//				}
//				addChild(_FontText);
//				
//				if(_AutoResize)
//				{
//					if(_FontText.textWidth > width)
//					{
//						width += ((_FontText.textWidth - width) + 10);
//					}
//					
//				}
//				if(_FontText.textHeight > height)
//				{
//					height = ((_FontText.textHeight - height) + 10);
//				}
//				UpdateTextPosition();
//			}
//			
//		}
//		
//		private var _AutoResize:Boolean = false;
//		public function set AutoResize(Value:Boolean):void
//		{
//			_AutoResize = Value;
//		}
//		
//		override public function set width(value:Number):void
//		{
//			super.width = value;
//			UpdateTextPosition();
//		}
//		override public function set height(value:Number):void
//		{
//			super.height = value;
//			UpdateTextPosition();
//		}
//		
//		protected var _FontText:TextLine = null;
//		
//		public function UILabel(Skin:Class = null,TextValue:String = "")
//		{
//			var SkinClass:Class = Skin ? Skin:LabelStyle;
//			super(SkinClass);
//			if(TextValue == "" || TextValue == null)
//			{
//				Text = "Label";
//			}
//			else
//			{
//				Text = TextValue;
//			}
//		}
//		
//		override public function EnableEditMode():void
//		{
//			super.EnableEditMode();
//			this.addEventListener(MouseEvent.MOUSE_DOWN,DownProxy,true);
//		}
//		
//		private function DownProxy(event:MouseEvent):void
//		{
//			var Notify:MouseEvent = new MouseEvent(MouseEvent.MOUSE_DOWN);
//			var Pos:Point = new Point();
//			Pos.x = stage.mouseX;
//			Pos.y = stage.mouseY;
//			
//			Pos = this.globalToLocal(Pos);
//			Notify.localX = Pos.x;
//			Notify.localY = Pos.y;
//			dispatchEvent(Notify);
//		}
//		
//		/** 字体样式修改  **/
//		public function set FontSize(Value:int):void
//		{
//			Style.FontTextStyle.FontSize = Value;
//			Text = _Text;
//		}
//		public function get FontSize():int
//		{
//			return Style.FontTextStyle.FontSize;
//		}
//		public function set FontColor(Value:uint):void
//		{
//			Style.FontTextStyle.FontColor = Value;
//			Text = _Text;
//		}
//		public function get FontColor():uint
//		{
//			return Style.FontTextStyle.FontColor;
//		}
//		protected var _CurrentAlign:int = FontTextAlignEnmu.ALIGN_CENTER;
//		public function set FontAlign(Value:int):void
//		{
//			if(_CurrentAlign != Value)
//			{
//				Style.FontTextStyle.FontAlign = _CurrentAlign = Value;
//				if(_FontText)
//				{
//					UpdateTextPosition();
//				}
//			}
//		}
//		
//		internal function UpdateTextPosition():void
//		{
//			switch(_CurrentAlign)
//			{
//
//				case FontTextAlignEnmu.ALIGN_BOTTOMCENTER:
//					break;
//				case FontTextAlignEnmu.ALIGN_CENTER:
//					_FontText.y = ((this.height - _FontText.textHeight) / 2) +  _FontText.textHeight;
//					_FontText.x = ((this.width - _FontText.textWidth) / 2);
//					break;
//				case FontTextAlignEnmu.ALIGN_LEFTBOTTOM:
//					_FontText.y = (this.height - _FontText.textHeight) +  _FontText.textHeight;
//					_FontText.x = 0;
//					break;
//				case FontTextAlignEnmu.ALIGN_LEFTCENTER:
//					_FontText.y = ((this.height - _FontText.textHeight) / 2) +  _FontText.textHeight;
//					_FontText.x = 0;
//					break;
//				case FontTextAlignEnmu.ALIGN_LEFTTOP:
//					_FontText.y = _FontText.textHeight;
//					_FontText.x = 0;
//					break;
//				case FontTextAlignEnmu.ALIGN_RIGHBOTTOM:
//					_FontText.y = (this.height - _FontText.textHeight) +  _FontText.textHeight;
//					_FontText.x = this.width - _FontText.textWidth ;
//					break;
//				case FontTextAlignEnmu.ALIGN_RIGHCENTER:
//					_FontText.y = ((this.height - _FontText.textHeight) / 2) +  _FontText.textHeight;
//					_FontText.x = this.width - _FontText.textWidth;
//					break;
//
//				case FontTextAlignEnmu.ALIGN_RIGHTTOP:
//					_FontText.y = _FontText.textHeight;
//					_FontText.x = this.width - _FontText.textWidth ;
//					break;
//
//				case FontTextAlignEnmu.ALIGN_TOPCENTER:
//					_FontText.y = _FontText.textHeight;
//					_FontText.x = ((this.width - _FontText.textWidth) / 2);
//					break;
//			}
//		}
//		
//		override protected function SpecialDecode(Data:ByteArray):void
//		{
//			var Len:int = Data.readByte();
//			Text = Data.readUTFBytes(Len);
//		}
//		override protected function SpecialEncode(Data:ByteArray):void
//		{
//			Data.writeByte(_Text.length);
//			if(_Text.length > 0)
//			{
//				Data.writeUTFBytes(_Text);
//			}
//		}
//		
//		override public function Render():void
//		{
//			//super.Render();
//		}
	}
}