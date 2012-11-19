package pixel.ui.control
{
	import pixel.ui.control.asset.ControlAssetManager;
	import pixel.ui.control.event.UIControlEvent;
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.control.style.StyleShape;
	import pixel.ui.control.style.UIStyle;
	import pixel.ui.control.utility.FocusFrame;
	import pixel.ui.control.utility.ScaleRect;
	import pixel.ui.control.utility.Utils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	import utility.BitmapTools;
	import utility.ISerializable;
	import utility.Tools;
	
	/**
	 * UI顶层类
	 **/
	public class UIControl extends Sprite implements IUIControl,ISerializable
	{
		protected var _Style:IVisualStyle = null;
		private var _StyleChanged:Boolean = false;
		private var _StyleClass:Class = null;
		private var _Scale9Grid:Scale9GridBitmap = null;
		protected var _EditMode:Boolean = false;	//编辑模式.编辑模式开启的情况下可以对控件进行样式的更改.如果控件处于容器内部可以进行拖拽操作
		//public function UIControl(Skin:IStyle = null)
		public function UIControl(Skin:Class = null)
		{
			_StyleClass = Skin;
			if(Skin == null)
			{
				_Style = new UIStyle();
				_StyleClass = UIStyle;
			}
			else
			{
				_Style = new Skin() as IVisualStyle;
			}
			RegisterEvent();
			Update();
			//this.mouseEnabled = false;
		}
		
		protected var _Owner:UIControl = null;
		public function set Owner(Value:UIControl):void
		{
			_Owner = Value;
		}
		public function get Owner():UIControl
		{
			return _Owner;
		}
		
		protected var _Frame:FocusFrame = null;
		/**
		 * 开启控件的编辑模式
		 **/
		public function EnableEditMode():void
		{
			_Frame = new FocusFrame(this);
			super.addChildAt(_Frame,this.numChildren);
			this.RemoveEvent();
			_EditMode = true;
		}
		public function DisableEditMode():void
		{
			_EditMode = false;
			removeChild(_Frame);
			this.RegisterEvent();
		}
		
		private var _ToolTip:String = "";
		public function set ToolTip(Value:String):void
		{
			_ToolTip = Value;
			if(null != _ToolTip && "" != _ToolTip)
			{
				ToolTipManager.Instance.Bind(this);
			}
			else
			{
				ToolTipManager.Instance.UnBind(this);	
			}
		}
		public function get ToolTip():String
		{
			return _ToolTip
		}
		
		public function FrameFocus():void
		{
			if(_Frame)
			{
				_Frame.Enable();
			}
		}
		public function FrameUnfocus():void
		{
			if(_Frame)
			{
				_Frame.Disable();
			}
		}
		
		/**
		 **/
		public function get StyleClass():Class
		{
			return _StyleClass;
		}
		
		/**
		 * 当控件进入显示队列时的初始化处理
		 **/
		protected function OnAdded(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,OnAdded);
			if(stage)
			{
				stage.addEventListener(Event.RENDER,StageRender);
				if(_StyleChanged)
				{
					stage.invalidate();
				}
			}
		}
		
		/**
		 * 场景渲染处理
		 **/
		private function StageRender(event:Event):void
		{
			
			if(_StyleChanged)
			{
				_StyleChanged = false;
				//样式变更后调用Render进行处理
				Render();
			}
		}
		
		public function Dispose():void
		{
			RemoveEvent();
		}
		
		protected function StyleUpdate():void
		{
			dispatchEvent(new UIControlEvent(UIControlEvent.STYLE_UPDATE,true));
			Update();
		}
		
		/**
		 * 变更更新标识,同时发送更新事件.
		 **/
		public function Update():void
		{
			_StyleChanged = true;
			if(stage)
			{
				stage.invalidate();
			}
		}
		
		protected var _ActualWidth:int = 0;
		protected var _ActualHeight:int = 0;
		
		/**
		 * 
		 * 以中心为注册点进行缩放
		 **/
		public function CenterScale(Value:Number):void
		{
			scaleX = Value;
			scaleY = Value;
			var Mtx:Matrix = this.transform.matrix;
			//Mtx.translate(-(_Style.Width >> 1),-(_Style.Height >> 1));
			Mtx.translate(-(_ActualWidth >> 1),-(_ActualHeight >> 1));
		}
		
		/**
		 * 自定义渲染
		 **/
		public function Render():void
		{
			StyleRender(_Style);
			dispatchEvent(new UIControlEvent(UIControlEvent.RENDER_UPDATE));
		}
		
		/**
		 * 按照给定的样式进行渲染
		 **/
		protected function StyleRender(Style:IVisualStyle):void
		{
			if(Style)
			{
				var Pen:Graphics = graphics;
				//trace(this.Id + "[" + this + "]" + "Render begin");
				Pen.clear();
				if(Style.BorderThinkness > 0)
				{
					//设置边框线条样式
					Pen.lineStyle(Style.BorderThinkness,Style.BorderColor,Style.BorderAlpha);
				}
				//设置了背景图片则进行图片填充,否则用背景颜色填充
				//if(Style.BackgroundImage)
				if(Style.HaveImage)
				{
					if(Style.BackgroundImage != null)
					{
						BitmapRender();
					}
					else
					{
						if(!Style.ImagePack)
						{
							var Img:Bitmap = ControlAssetManager.Instance.FindAssetById(Style.BackgroundImageId) as Bitmap;
							if(Img)
							{
								//资源已经欲载
								BackgroundImage = Img;
								BitmapRender();
							}
							else
							{
								//注册资源加载通知
								ControlAssetManager.Instance.AssetHookRegister(Style.BackgroundImageId,this);
							}
						}
					}
					
				}
				else
				{
					graphics.beginFill(Style.BackgroundColor,Style.BackgroundAlpha);
				}
				
				switch(Style.Shape)
				{
					case StyleShape.RECT:
						if(Style.LeftBottomCorner > 0 || Style.LeftTopCorner > 0 || Style.RightTopCorner > 0 || Style.RightBottomCorner > 0)
						{
							//graphics.drawRoundRectComplex(0,0,Style.Width,Style.Height,Style.LeftTopCorner,Style.RightTopCorner,Style.LeftBottomCorner,Style.RightBottomCorner);
							graphics.drawRoundRectComplex(0,0,_ActualWidth,_ActualHeight,Style.LeftTopCorner,Style.RightTopCorner,Style.LeftBottomCorner,Style.RightBottomCorner);
						}
						else
						{
							graphics.drawRect(0,0,_ActualWidth,_ActualHeight);
							//graphics.drawRect(0,0,Style.Width,Style.Height);
						}
						//矩形
						break;
					case StyleShape.CIRCLE:
						graphics.drawCircle(0,0,Style.Radius);
						//圆形
						break;
					case StyleShape.ELLIPSE:
						//椭圆
						break;
					default:
				}
				graphics.endFill();
				//trace("Render end");
			}
		}
		
		protected function BitmapRender():void
		{
			var Pen:Graphics = graphics;
			if(!Style.Scale9Grid)
			{
				Pen.beginBitmapFill(Style.BackgroundImage.bitmapData,null,Boolean(Style.ImageFillType));
			}
			else
			{
				if(Style.Scale9GridLeft == 0 || Style.Scale9GridTop == 0 || Style.Scale9GridRight == 0 || Style.Scale9GridBottom == 0)
				{
					//任意参数为0时按默认方式渲染
					Pen.beginBitmapFill(Style.BackgroundImage.bitmapData,null,Boolean(Style.ImageFillType));
				}
				else
				{
					if(null == _Scale9Grid)
					{
						_Scale9Grid = new Scale9GridBitmap(Style.BackgroundImage);
						_Scale9Grid.Scale9Grid(Style.Scale9GridLeft,Style.Scale9GridTop,Style.Scale9GridRight,Style.Scale9GridBottom);
						_Scale9Grid.width = _ActualWidth;
						_Scale9Grid.height = _ActualHeight;
						
					}
					else
					{
						_Scale9Grid.UpdateScale(Style.Scale9GridLeft,Style.Scale9GridTop,Style.Scale9GridRight,Style.Scale9GridBottom);
					}
					
					var Vec:Vector.<ScaleRect> = _Scale9Grid.Rect;
					var Source:BitmapData = Style.BackgroundImage.bitmapData;
					var Rect:ScaleRect = null;
					//var Data:BitmapData = null;
					var Bit:Bitmap = null;
					var Pos:Point = new Point();
					var idx:int = 0;
					//Data = new BitmapData(width,height);
					var Mtx:Matrix = new Matrix();
					for each(Rect in Vec)
					{
						Mtx.a = Rect.FillWidth / Rect.width;
						Mtx.d = Rect.FillHeight / Rect.height;
						Mtx.tx = Rect.x - Rect.BitX * Mtx.a;
						Mtx.ty = Rect.y - Rect.BitY * Mtx.d;
						Pen.beginBitmapFill(Source,Mtx);
						Pen.drawRect(Rect.x,Rect.y,Rect.FillWidth,Rect.FillHeight);
						Pen.endFill();
						idx++;
						Rect.DrawMatrix.identity();
					}
				}
			}
		}
		
		protected function RegisterEvent():void
		{
			addEventListener(Event.ADDED_TO_STAGE,OnAdded);
		}
		protected function RemoveEvent():void
		{
		}
		
		private var _Enable:Boolean = true;
		
		public function set Enable(Value:Boolean):void
		{
			if(Value)
			{
				if(!_Enable)
				{
					this.RegisterEvent();
				}
			}
			else
			{
				if(_Enable)
				{
					this.RemoveEvent();
				}
			}
		}
		
		/**
		 * 控件版本
		 **/
		protected var _Version:uint = 0;
		public function get Version():uint
		{
			return _Version;
		}
		public function set Version(Value:uint):void
		{
			_Version = Value;
		}
		
		/**
		 * 克隆对象
		 **/
//		public function Clone(Prototype:Class = null):Object
//		{
//			if(Prototype == null)
//			{
//				Prototype = UIStyle;
//			}
//			
//			registerClassAlias(Tools.GetPackage(Prototype),Prototype);
//			return Cloneable.Instance.Clone(this);
//		}
		
		public function Encode():ByteArray
		{
			
			var Data:ByteArray = new ByteArray();
			var Prototype:uint = Utils.GetControlPrototype(this);
			//1	Short	控件类型
			Data.writeByte(Prototype);
			var Id:String = this.Id;
			
			if(Id == null || Id == "")
			{
				Id = "C" + int(Math.random() * 1000);
			}
			
			Id = Tools.ReplaceAll(Id," ","");
//			if(Id.length < 20)
//			{
//				Id = Tools.FillChar(Id," ",20);
//			}
//
//			Data.writeUTFBytes(Id);
			Data.writeByte(Id.length);
			Data.writeUTFBytes(Id);
			
			//1	Short	控件版本
			Data.writeShort(Version);
			Data.writeShort(_ActualWidth);
			Data.writeShort(_ActualHeight);
			//1	Short	X
			Data.writeShort(x);	//外壳的X
			//1	Short	Y
			Data.writeShort(y);	//外壳的Y
			
			//2012-11-09新增 ToolTip数据支持
			if(null != _ToolTip && _ToolTip.length > 0)
			{
				Data.writeByte(1);
				var Len:int = Tools.StringActualLength(_ToolTip);
				Data.writeShort(Len);
				Data.writeUTFBytes(_ToolTip);
			}
			else
			{
				Data.writeByte(0);
			}
			
			var StyleData:ByteArray = Style.Encode();
			Data.writeBytes(StyleData,0,StyleData.length);
			
			SpecialEncode(Data);
			return Data;
		}
		public function Decode(Data:ByteArray):void
		{
			var Len:int = Data.readByte();
			Id = Data.readUTFBytes(Len);
			//Id = Tools.ReplaceAll( Data.readUTFBytes(20)," ","");
			Version = Data.readShort();
			_ActualWidth = Data.readShort();
			_ActualHeight = Data.readShort();
			x = Data.readShort();
			y = Data.readShort();
			
			
			//2012-11-09ToolTip数据处理
			if(Data.readByte() == 1)
			{
				Len = Data.readShort();
				ToolTip = Data.readUTFBytes(Len);
			}
			
			_Style.Decode(Data);
			SpecialDecode(Data);
			RegisterEvent();
			
			if(!Style.ImagePack)
			{
				var Img:Bitmap = ControlAssetManager.Instance.FindAssetById(Style.BackgroundImageId) as Bitmap;
				if(Img)
				{
					this.BackgroundImage = Img;
				}
			}
		}
		protected function SpecialDecode(Data:ByteArray):void
		{
			
		}
		protected function SpecialEncode(Data:ByteArray):void
		{
			
		}
		
		/**
		 * 注册资源完成通知的回调函数
		 * 
		 * 
		 **/
		public function AssetComleteNotify(Id:String,Asset:Object):void
		{
			this.BackgroundImage = Asset as Bitmap;
			ControlAssetManager.Instance.AssetHookRemove(BackgroundImageId,this);
		}
		
		private var _Id:String = "";
		public function get Id():String
		{
			return _Id;
		}
		public function set Id(Value:String):void
		{
			_Id = Value;
		}
		
		override public function set width(value:Number):void
		{
			//super.width = value;
			//_Style.Width = value;
			
			_ActualWidth = value;
			if(_Style.Scale9Grid)
			{
				_Scale9Grid.width = _ActualWidth;
			}
			StyleUpdate();
		}
		
		protected function get ContentWidth():Number
		{
			return (width - _Style.BorderThinkness);
		}
		protected function get ContentHeight():Number
		{
			return (height - _Style.BorderThinkness);
		}
		
		public function get RealWidth():Number
		{
			return super.width;
		}
		public function get RealHeight():Number
		{
			return super.height;
		}
		
		override public function get width():Number
		{
			//return _Style.Width;
			return _ActualWidth;
		}
		override public function set height(value:Number):void
		{
			//super.height = value;
			//_Style.Height = value;
			_ActualHeight = value;
			if(_Style.Scale9Grid)
			{
				_Scale9Grid.height = _ActualHeight;
			}
			StyleUpdate();
		}
		override public function get height():Number
		{
			//return _Style.Height;
			return _ActualHeight;
		}
		
		/************************样式变更函数定义区************************/
		public function get Style():IVisualStyle
		{
			return _Style;
		}
		
		public function set BorderColor(Value:uint):void
		{
			_Style.BorderColor = Value;
			StyleUpdate();
		}
		public function get BorderColor():uint
		{
			return _Style.BorderColor;
		}
		public function set BorderThinkness(Value:int):void
		{
			_Style.BorderThinkness = Value;
			StyleUpdate();
		}
		public function get BorderThinkness():int
		{
			return _Style.BorderThinkness;
		}
		public function set BorderAlpha(Value:Number):void
		{
			_Style.BorderAlpha = Value;
			StyleUpdate();
		}
		public function get BorderAlpha():Number
		{
			return _Style.BorderAlpha;
		}
//		public function set BorderCorner(Value:int):void
//		{
//			_Style.BorderCorner = Value;
//			StyleUpdate();
//		}
		public function set Radius(Value:int):void
		{
			_Style.Radius = Value;
			StyleUpdate();
		}
		public function set BackgroundColor(Value:uint):void
		{
			_Style.BackgroundColor = Value;
			StyleUpdate();
		}
		public function get BackgroundColor():uint
		{
			return _Style.BackgroundColor;
		}
		public function set BackgroundAlpha(Value:Number):void
		{
			_Style.BackgroundAlpha = Value;
			StyleUpdate();
		}
		public function get BackgroundAlpha():Number
		{
			return _Style.BackgroundAlpha;
		}
		public function set BackgroundImage(Image:Bitmap):void
		{
			_Style.BackgroundImage = Image;
			StyleUpdate();
		}
		public function set BackgroundImageId(Value:String):void
		{
			_Style.BackgroundImageId = Value;
		}
		public function get BackgroundImageId():String
		{
			return _Style.BackgroundImageId;
		}
		public function set BackgroundImageFill(Value:int):void
		{
			_Style.ImageFillType = Value;
			StyleUpdate();
		}
		public function get BackgroundImageFill():int
		{
			return _Style.ImageFillType;
		}
		public function set Scale9Grid(Value:Boolean):void
		{
			_Style.Scale9Grid = Value;
			StyleUpdate();
		}
		public function set Scale9GridLeft(Value:int):void
		{
			_Style.Scale9GridLeft = Value;
			StyleUpdate();
		}
		public function get Scale9GridLeft():int
		{
			return _Style.Scale9GridLeft;
		}
		public function set Scale9GridTop(Value:int):void
		{
			_Style.Scale9GridTop = Value;
			StyleUpdate();
		}
		public function get Scale9GridTop():int
		{
			return _Style.Scale9GridLeft;
		}
		public function set Scale9GridRight(Value:int):void
		{
			_Style.Scale9GridRight = Value;
			StyleUpdate();
		}
		public function get Scale9GridRight():int
		{
			return _Style.Scale9GridLeft;
		}
		public function set Scale9GridBottom(Value:int):void
		{
			_Style.Scale9GridBottom = Value;
			StyleUpdate();
		}
		public function get Scale9GridBottom():int
		{
			return _Style.Scale9GridLeft;
		}
		public function set LeftTopCorner(Value:int):void
		{
			_Style.LeftTopCorner = Value;
			StyleUpdate();
		}
		public function set LeftBottomCorner(Value:int):void
		{
			_Style.LeftBottomCorner = Value;
			StyleUpdate();
		}
		public function set RightTopCorner(Value:int):void
		{
			_Style.RightTopCorner = Value;
			StyleUpdate();
		}
		public function set RightBottomCorner(Value:int):void
		{
			_Style.RightBottomCorner = Value;
			StyleUpdate();
		}
		
		public function set ImagePack(Value:Boolean):void
		{
			_Style.ImagePack = Value;
		}
		public function get ImagePack():Boolean
		{
			return _Style.ImagePack;
		}
	}
}