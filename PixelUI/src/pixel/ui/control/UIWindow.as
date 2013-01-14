package pixel.ui.control
{
	import pixel.ui.control.style.UIWindowStyle;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * 视窗UI
	 * 
	 * 
	 **/
	public class UIWindow extends UIContainer
	{
		
		//标题栏
		protected var _TitleBar:TitleBar = null;
		//内容
		protected var _WindowContent:UIPanel = null;
		
		public function UIWindow(Style:Class = null)
		{
			var StyleClass:Class = Style ? Style : UIWindowStyle;
			super(StyleClass);
			
			_TitleBar = new TitleBar();
			//_TitleBar.width = this.Style.Width;
			super.addChild(_TitleBar);
			
			_WindowContent = new UIPanel(WindowContentStyle);
			//_WindowContent.width =  this.Style.Width;
			//_WindowContent.height = this.Style.Height - _TitleBar.height;
			
			super.addChild(_WindowContent);
		}
		
		override public function EnableEditMode():void
		{
			super.EnableEditMode();
			this.addEventListener(MouseEvent.MOUSE_DOWN,DownProxy,true);
		}
		
		private function DownProxy(event:MouseEvent):void
		{
			if(event.target != _TitleBar && event.target != _WindowContent)
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
		
		override public function set width(value:Number):void
		{
			super.width = value;
			_TitleBar.width = value;
			_WindowContent.width = value;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			_WindowContent.height = value - _TitleBar.height;
		}
		
		override public function addChild(Child:DisplayObject):DisplayObject
		{
			return _WindowContent.addChild(Child);
		}
		
		override public function set Layout(Value:uint):void
		{
			_WindowContent.Layout = Value;
		}
		
		override public function get Layout():uint
		{
			return _WindowContent.Layout;
		}
		
		override public function set padding(Value:int):void
		{
			_WindowContent.padding = Value;
		}
		override public function set Gap(Value:int):void
		{
			_WindowContent.Gap = Value;
		}
		
		override public function set BackgroundImage(Image:Bitmap):void
		{
			_WindowContent.BackgroundImage = Image;
		}
		
		override public function set BackgroundImageId(Value:String):void
		{
			_WindowContent.BackgroundImageId = Value;
		}
		
		override public function set BackgroundImageFill(Value:int):void
		{
			_WindowContent.BackgroundImageFill = Value;
		}
		
		override public function set BackgroundColor(Value:uint):void
		{
			_WindowContent.BackgroundColor = Value;
		}
		
		override public function set BackgroundAlpha(Value:Number):void
		{
			_WindowContent.BackgroundAlpha = Value;
		}
		
		public function set Title(Value:String):void
		{
			_TitleBar.Title = Value;
		}
		public function get Title():String
		{
			return _TitleBar.Title;
		}
	}
}
import pixel.ui.control.UIImage;
import pixel.ui.control.UILabel;
import pixel.ui.control.UIPanel;
import pixel.ui.control.style.FontTextAlignEnmu;

import flash.display.Bitmap;

class TitleBar extends UIPanel
{
//	[Embed(source="Close.png")]
//	private var CloseBitmap:Class;
	private var _Icon:UIImage = null;
	private var _Title:UILabel = null;
	protected var _CloseImg:UIImage = null;
	public function TitleBar()
	{
		super(TitleBarStyle);
		_Title = new UILabel();
		//_Title.FontAlign = FontTextAlignEnmu.ALIGN_LEFTTOP;
		_Title.x = 5;
		_Title.y = 3;
		height = 30;
		addChild(_Title);
		
		_CloseImg = new UIImage();
		
//		var Img:Bitmap = new CloseBitmap() as Bitmap;
//		_CloseImg.BackgroundImage = Img;
//		_CloseImg.width = Img.width;
//		_CloseImg.height = Img.height;
		//_CloseImg.buttonMode = true;
		_CloseImg.x = width - _CloseImg.width;
		super.addChild(_CloseImg);
	}
	
	override public function set width(value:Number):void
	{
		super.width = value;
		if(_Icon)
		{
			_Icon.x = 5;
			_Icon.y = 3;
		}
		
		_Title.x = _Icon ? _Icon.x + 5:5;
		_Title.y = 3;
		_Title.width = _Icon ? width - _Icon.width - 50:width - 50;
		
		_CloseImg.x = width - _CloseImg.width;
	}
	
	public function set Title(Value:String):void
	{
		_Title.text = Value;
	}
	public function get Title():String
	{
		return _Title.text;
	}
}


import pixel.ui.control.LayoutConstant;
import pixel.ui.control.style.UIContainerStyle;

class TitleBarStyle extends UIContainerStyle
{
	public function TitleBarStyle()
	{
		BorderThinkness = 1;
		BorderColor = 0x666666;
		BackgroundColor = 0x999999;
		//Height = 30;
	}
}

class WindowContentStyle extends UIContainerStyle
{
	public function WindowContentStyle()
	{
		BackgroundColor = 0xEEEEEE;
		BorderColor = 0x666666;
		BorderThinkness = 1;
		LeftBottomCorner = 4;
		RightBottomCorner = 4;
	}
}