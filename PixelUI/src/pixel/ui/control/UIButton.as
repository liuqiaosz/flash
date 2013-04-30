package pixel.ui.control
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.asset.PixelAssetManager;
	import pixel.ui.control.event.UIControlEvent;
	import pixel.ui.control.style.IStyle;
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.control.style.StyleShape;
	import pixel.ui.control.style.UIButtonStyle;
	import pixel.ui.control.utility.ButtonState;
	import pixel.utility.Tools;

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
			var StyleSkin:Class = Skin ? Skin:UIButtonStyle;
			super(StyleSkin);
			_MouseOverStyle = UIButtonStyle(Style).OverStyle;
			_MouseDownStyle = UIButtonStyle(Style).PressStyle;
			_NormalStyle = Style;
			
			this.buttonMode = true;
			_Text = new UILabel(_TextValue);
			_Text.mouseEnabled = false;
			addChild(_Text);
			addEventListener(MouseEvent.MOUSE_DOWN,EventMouseDown);
			addEventListener(MouseEvent.MOUSE_OVER,EventMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT,EventMouseOut);
			addEventListener(MouseEvent.MOUSE_UP,EventMouseUp);
			this.mouseChildren =false;
			width = 100;
			height = 40;
		}
		
		override public function EnableEditMode():void
		{
			this.buttonMode = false;
			super.EnableEditMode();
			this.mouseChildren = true;
			removeEventListener(MouseEvent.MOUSE_DOWN,EventMouseDown);
			removeEventListener(MouseEvent.MOUSE_OVER,EventMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT,EventMouseOut);
			removeEventListener(MouseEvent.MOUSE_UP,EventMouseUp);
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
//				if(null == _Text)
//				{
//					
//					_Text.FontColor = _Style.FontTextStyle.FontColor;
//					_Text.FontSize = _Style.FontTextStyle.FontSize;
//					_Text.buttonMode = true;
//					_Text.Align = TextAlign.CENTER;
//					//_Text.width = width;
//					//_Text.height = height;
//					addChild(_Text);
//				}
				_Text.text = Value;
				//addChild(_Text);
				Update();
			}
			else
			{
				if(null != _Text && this.contains(_Text))
				{
					_Text.text = "";
					//this.removeChild(_Text);
				}
			}
		}
		
		public function get textLabel():UILabel
		{
			return _Text;
		}
		
		public function get Text():String
		{
			return _TextValue;
		}

		/**
		 * 渲染
		 **/
		override public function Render():void
		{
			super.Render();
			
			if(null != _Text)
			{
				if(!contains(_Text) && _TextValue != "")
				{
					addChild(_Text);
				}
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			removeEventListener(MouseEvent.MOUSE_DOWN,EventMouseDown);
			removeEventListener(MouseEvent.MOUSE_OVER,EventMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT,EventMouseOut); 
			removeEventListener(MouseEvent.MOUSE_UP,EventMouseUp);
			
			
		}
		
		/**
		 * 普通状态的样式
		 **/
		public function get NormalStyle():IVisualStyle
		{
			return _Style;
		}
		
		/**
		 * 鼠标悬停时的状态
		 **/
		public function get MouseOverStyle():IVisualStyle
		{
			return _MouseOverStyle;
		}
		
		override public function encode():ByteArray
		{
			_Style = _NormalStyle;
			return super.encode();
		}
		
		override public function set Style(value:IVisualStyle):void
		{
			if(value is UIButtonStyle)
			{
				_Style = value;
				_NormalStyle = value;
				_MouseOverStyle = UIButtonStyle(value).OverStyle;
				_MouseDownStyle = UIButtonStyle(value).PressStyle;
				this.StyleUpdate();
			}
		}
		
		/**
		 * 鼠标按下时的样式s
		 **/
		public function get MouseDownStyle():IVisualStyle
		{
			return _MouseDownStyle;
		}
		
		override protected function SpecialDecode(Data:ByteArray):void
		{
			var Len:int = Data.readShort();
			var labelData:ByteArray = new ByteArray();
			Data.readBytes(labelData,0,Len);
			labelData.position = 1;//跳过UILabel类型数据域
			_Text.decode(labelData);
//			if(Len > 0)
//			{
//				
////				var Label:String = Data.readMultiByte(Len,"cn-gb");
////				Text = Label;
//				//_Text.applyFontStyle(_Style.FontTextStyle);
//			}
		}
		override protected function SpecialEncode(Data:ByteArray):void
		{
			var labelData:ByteArray = _Text.encode();
			Data.writeShort(labelData.length);
			Data.writeBytes(labelData,0,labelData.length);
//			var Len:int = Tools.StringActualLength(_TextValue);
//			Data.writeShort(Len);
//			if(Len > 0)
//			{
//				Data.writeMultiByte(_TextValue,"cn-gb");
//			}
		}
		
//		public function set LabelTextFamily(value:String):void
//		{
//			_Text.FontFamily = value;
//		}
//		
//		public function set LabelTextAlign(Value:int):void
//		{
//			_Text.Align = Value;
//		}
//		public function get LabelTextAlign():int
//		{
//			return _Text.Align;
//		}
		
		override public function set ImagePack(Value:Boolean):void
		{
			//_MouseOverStyle.ImagePack = _MouseDownStyle.ImagePack = _NormalStyle.ImagePack = Value;
			_NormalStyle.ImagePack = Value;
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
			
			PixelAssetManager.instance.AssetHookRemove(BackgroundImageId,this);
		}
		
		/**
		 * 为按钮所有状态指定同一样图片
		 * 
		 * 
		 **/
		public function set backgroundImageForAllState(value:Bitmap):void
		{
			UIButtonStyle(_NormalStyle).BackgroundImage = value;
			UIButtonStyle(_NormalStyle).OverStyle.BackgroundImage = value;
			UIButtonStyle(_NormalStyle).PressStyle.BackgroundImage = value;
		}
		
		public function set borderThinknessForAllState(value:int):void
		{
			UIButtonStyle(_NormalStyle).BorderThinkness = value;
			UIButtonStyle(_NormalStyle).OverStyle.BorderThinkness = value;
			UIButtonStyle(_NormalStyle).PressStyle.BorderThinkness = value;
		}
		
		public function scale9GridForAllState(left:int,top:int,right:int,bottom:int):void
		{
			UIButtonStyle(_NormalStyle).Scale9Grid = 
				UIButtonStyle(_NormalStyle).OverStyle.Scale9Grid = 
				UIButtonStyle(_NormalStyle).PressStyle.Scale9Grid = true;
			
			UIButtonStyle(_NormalStyle).Scale9GridLeft = 
				UIButtonStyle(_NormalStyle).OverStyle.Scale9GridLeft = 
				UIButtonStyle(_NormalStyle).PressStyle.Scale9GridLeft = left;
			
			UIButtonStyle(_NormalStyle).Scale9GridTop = 
				UIButtonStyle(_NormalStyle).OverStyle.Scale9GridTop = 
				UIButtonStyle(_NormalStyle).PressStyle.Scale9GridTop = top;
			
			UIButtonStyle(_NormalStyle).Scale9GridRight = 
				UIButtonStyle(_NormalStyle).OverStyle.Scale9GridRight = 
				UIButtonStyle(_NormalStyle).PressStyle.Scale9GridRight = right;
			
			UIButtonStyle(_NormalStyle).Scale9GridBottom = 
				UIButtonStyle(_NormalStyle).OverStyle.Scale9GridBottom = 
				UIButtonStyle(_NormalStyle).PressStyle.Scale9GridBottom = top;
		}
	}
}