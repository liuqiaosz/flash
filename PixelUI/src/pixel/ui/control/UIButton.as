package pixel.ui.control
{
	import pixel.ui.control.asset.ControlAssetManager;
	import pixel.ui.control.event.UIControlEvent;
	import pixel.ui.control.style.ButtonStyle;
	import pixel.ui.control.style.IStyle;
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.control.style.StyleShape;
	import pixel.ui.control.utility.ButtonState;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import utility.Tools;

	/**
	 * 简单按钮控件
	 * 
	 * 边框颜色
	 * 边框圆角
	 * 边框宽度
	 * 背景图片平铺
	 * 聚焦时的背景图片
	 * 非聚焦的背景图片
	 * 点击时呃背景图片
	 * 
	 **/
	public class UIButton extends UIControl
	{
		protected var _NormalStyle:IVisualStyle = null;
		//聚焦样式
		protected var _MouseOverStyle:IVisualStyle = null;
		//按下样式
		protected var _MouseDownStyle:IVisualStyle = null;
		//按钮状态
		protected var _State:uint = ButtonState.NORMAL;
		
		//protected var _Text:TextLine = null;
		protected var _Text:UILabel = null;
		public function UIButton(Skin:Class = null)
		{
			var StyleSkin:Class = Skin ? Skin:ButtonStyle;
			super(StyleSkin);
			_MouseOverStyle = ButtonStyle(Style).OverStyle;
			_MouseDownStyle = ButtonStyle(Style).PressStyle;
			_NormalStyle = Style;
			
			width = 50;
			height = 30;
			this.buttonMode = true;
			
			addEventListener(MouseEvent.MOUSE_DOWN,EventMouseDown);
			addEventListener(MouseEvent.MOUSE_OVER,EventMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT,EventMouseOut);
			addEventListener(MouseEvent.MOUSE_UP,EventMouseUp);
			this.mouseChildren =false;
		}

		override protected function RemoveEvent():void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN,EventMouseDown);
			removeEventListener(MouseEvent.MOUSE_OVER,EventMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT,EventMouseOut); 
			removeEventListener(MouseEvent.MOUSE_UP,EventMouseUp);
		}
		
		override public function EnableEditMode():void
		{
			this.buttonMode = false;
			super.EnableEditMode();
			RemoveEvent();
		}
		override public function set width(value:Number):void
		{
			super.width = value;
			if(_Text)
			{
				_Text.width = value;
			}
			//_MouseOverStyle.Width = value;
			//_MouseDownStyle.Width = value;
		}
		override public function set height(value:Number):void
		{
			super.height = value;
			if(_Text)
			{
				_Text.height = value;
			}
			//_MouseOverStyle.Height = value;
			//_MouseDownStyle.Height = value;
		}
		
		protected function EventMouseUp(event:MouseEvent):void
		{
			State = ButtonState.OVER;
		}
		protected function EventMouseDown(event:MouseEvent):void
		{
			State = ButtonState.DOWN;
			var Notify:UIControlEvent = new UIControlEvent(UIControlEvent.BUTTON_DOWN,true);
			dispatchEvent(Notify);
		}
		protected function EventMouseOver(event:MouseEvent):void
		{
			State = ButtonState.OVER;
			
		}
		protected function EventMouseOut(event:MouseEvent):void
		{
			State = ButtonState.NORMAL;
		}
		
		public function set State(Value:uint):void
		{
			_State = Value;
			switch(_State)
			{
				case ButtonState.DOWN:
					_Style = _MouseDownStyle;
					break;
				case ButtonState.OVER:
					_Style = _MouseOverStyle;
					break;
				default:
					_Style = _NormalStyle;
			}
			
			StyleUpdate();
		}
		
		protected var _TextValue:String = "";
		public function set Text(Value:String):void
		{
			var V:String = Tools.ReplaceAll(Value," ","");
			_TextValue = V;
			if(V != "")
			{
//				if(null != _Text && this.contains(_Text))
//				{
//					removeChild(_Text);
//				}
//				_Text = FontTextFactory.Instance.TextByStyle(V,_Style.FontTextStyle);
				if(null == _Text)
				{
					_Text = new UILabel(_TextValue);
					_Text.FontColor = _Style.FontTextStyle.FontColor;
					_Text.FontSize = _Style.FontTextStyle.FontSize;
					_Text.buttonMode = true;
					_Text.Align = TextAlign.CENTER;
					//_Text.width = width;
					//_Text.height = height;
					addChild(_Text);
				}
				Update();
			}
			else
			{
				if(null != _Text && this.contains(_Text))
				{
					_Text.Text = "";
					this.removeChild(_Text);
				}
			}
		}
		
		public function get Text():String
		{
			return _TextValue;
		}
		
		public function set FontSize(Value:int):void
		{
			_Style.FontTextStyle.FontSize = Value;
			_Text.FontSize = Value;
			
			//Text = _TextValue;
		}
		public function get FontSize():int
		{
			return _Style.FontTextStyle.FontSize;
		}
		
		public function set FontColor(Value:uint):void
		{
			
			_Style.FontTextStyle.FontColor = Value;
			_Text.FontColor = Value;
			//Text = _TextValue;
		}
		public function get FontColor():uint
		{
			return _Style.FontTextStyle.FontColor;
		}
		
		/**
		 * 渲染
		 **/
		override public function Render():void
		{
			super.Render();
			
			if(null != _Text)
			{
				if(!contains(_Text))
				{
					addChild(_Text);
				}
				//_Text.y = ((this.height - _Text.textHeight) / 2) +  _Text.textHeight;
				//_Text.x = ((this.width - _Text.textWidth) / 2);
				//_Text.x = ((this.width - _Text.TextWidth) / 2);
				_Text.y = ((this.height - _Text.TextHeight) / 2);
			}
		}
		
		override public function Dispose():void
		{
			super.Dispose();
			removeEventListener(MouseEvent.MOUSE_DOWN,EventMouseDown);
			removeEventListener(MouseEvent.MOUSE_OVER,EventMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT,EventMouseOut);
		}
		
		/**
		 * 普通状态的样式
		 **/
		public function get NormalStyle():IStyle
		{
			return _Style;
		}
		
		/**
		 * 鼠标悬停时的状态
		 **/
		public function get MouseOverStyle():IStyle
		{
			return _MouseOverStyle;
		}
		
		override public function Encode():ByteArray
		{
			_Style = _NormalStyle;
			return super.Encode();
		}
		
		/**
		 * 鼠标按下时的样式s
		 **/
		public function get MouseDownStyle():IStyle
		{
			return _MouseDownStyle;
		}
		
		override protected function SpecialDecode(Data:ByteArray):void
		{
			var Len:int = Data.readShort();
			if(Len > 0)
			{
				var Label:String = Data.readMultiByte(Len,"cn-gb");
				Text = Label;
			}
		}
		override protected function SpecialEncode(Data:ByteArray):void
		{
			var Len:int = Tools.StringActualLength(_TextValue);
			Data.writeShort(Len);
			if(Len > 0)
			{
				Data.writeMultiByte(_TextValue,"cn-gb");
			}
		}
		
		public function set LabelTextAlign(Value:int):void
		{
			_Text.Align = Value;
		}
		public function get LabelTextAlign():int
		{
			return _Text.Align;
		}
		
		override public function set ImagePack(Value:Boolean):void
		{
			_MouseOverStyle.ImagePack = _MouseDownStyle.ImagePack = _NormalStyle.ImagePack = Value;
		}
		
		override public function AssetComleteNotify(Id:String,Asset:Object):void
		{
			//this.BackgroundImage = Asset as Bitmap;
			
			if(_NormalStyle.BackgroundImageId == Id)
			{
				_NormalStyle.BackgroundImage = Asset as Bitmap;
			}
			else if(_MouseOverStyle.BackgroundImageId == Id)
			{
				_MouseOverStyle.BackgroundImage = Asset as Bitmap;
			}
			else if(_MouseDownStyle.BackgroundImageId == Id)
			{
				_MouseDownStyle.BackgroundImage = Asset as Bitmap;
			}
			
			ControlAssetManager.Instance.AssetHookRemove(BackgroundImageId,this);
		}
	}
}