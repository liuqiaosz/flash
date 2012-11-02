package corecom.control.style
{
	import corecom.control.utility.Utils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	
	import utility.Tools;
	
	/**
	 * 基本样式
	 **/
	public class UIStyle implements IVisualStyle
	{
		public function UIStyle()
		{
		}
		
		private var _BorderThinkness:int = 1;
		//边框
		public function set BorderThinkness(Value:int):void
		{
			_BorderThinkness = Value;
		}
		public function get BorderThinkness():int
		{
			return _BorderThinkness;
		}
		
		private var _BorderColor:uint = 0x000000;
		//边框颜色
		public function set BorderColor(Value:uint):void
		{
			_BorderColor = Value;
		}
		public function get BorderColor():uint
		{
			return _BorderColor;
		}
		
		private var _BorderAlpha:Number = 1;
		//边框透明度
		public function set BorderAlpha(Value:Number):void
		{
			_BorderAlpha = Value;
		}
		public function get BorderAlpha():Number
		{
			return _BorderAlpha;
		}
		
//		private var _BorderCorner:int = 0;
//		//边框圆角
//		public function set BorderCorner(Value:int):void
//		{
//			_BorderCorner = Value;
//		}
//		public function get BorderCorner():int
//		{
//			return _BorderCorner;
//		}
		
		private var _BackgroundColor:uint = 0xFFFFFF;
		//背景颜色
		public function set BackgroundColor(Value:uint):void
		{
			_BackgroundColor = Value;
		}
		public function get BackgroundColor():uint
		{
			return _BackgroundColor;
		}
		
		private var _BackgroundAlpha:Number = 1;
		//背景透明度
		public function set BackgroundAlpha(Value:Number):void
		{
			_BackgroundAlpha = Value;
		}
		public function get BackgroundAlpha():Number
		{
			return _BackgroundAlpha;
		}
		
		private var _BackgroundImage:Bitmap = null;
		//背景图片
		public function set BackgroundImage(Value:Bitmap):void
		{
			_BackgroundImage = Value;
		}
		public function get BackgroundImage():Bitmap
		{
			return _BackgroundImage;
		}
		
		//图片填充类型
		private var _ImageFillType:int = 1;
		public function set ImageFillType(Value:int):void
		{
			_ImageFillType = Value;
		}
		public function get ImageFillType():int
		{
			return _ImageFillType;
		}
		
//		private var _Height:Number = 0;
//		public function set Height(Value:Number):void
//		{
//			_Height = Value;
//		}
//		public function get Height():Number
//		{
//			return _Height;
//		}
//		
//		private var _Width:Number = 0;
//		public function set Width(Value:Number):void
//		{
//			_Width = Value;
//		}
//		public function get Width():Number
//		{
//			return _Width;
//		}
		
		private var _Shape:uint = StyleShape.RECT;
		public function get Shape():uint
		{
			return _Shape;
		}
		public function set Shape(Value:uint):void
		{
			_Shape = Value;
		}
		
		private var _Radius:int = 0;
		/**
		 * 绘制圆形控件时的半径
		 * 当Shape为StyleShape.CIRCLE时该参数有效
		 **/
		public function set Radius(Value:int):void
		{
			_Radius = Value;	
		}
		
		public function get Radius():int
		{
			return _Radius;
		}
		
		private var _Scale9Grid:Boolean = false;
		public function set Scale9Grid(Value:Boolean):void
		{
			_Scale9Grid = Value;
		}
		public function get Scale9Grid():Boolean
		{
			return _Scale9Grid;
		}
		
		private var _Scale9GridLeft:int = 10;
		public function set Scale9GridLeft(Value:int):void
		{
			_Scale9GridLeft = Value;
		}
		public function get Scale9GridLeft():int
		{
			return _Scale9GridLeft;
		}
		private var _Scale9GridRight:int = 10;
		public function set Scale9GridRight(Value:int):void
		{
			_Scale9GridRight = Value;
		}
		public function get Scale9GridRight():int
		{
			return _Scale9GridRight;
		}
		private var _Scale9GridTop:int = 10;
		public function set Scale9GridTop(Value:int):void
		{
			_Scale9GridTop = Value;
		}
		public function get Scale9GridTop():int
		{
			return _Scale9GridTop;
		}
		
		private var _Scale9GridBottom:int = 10;
		public function set Scale9GridBottom(Value:int):void
		{
			_Scale9GridBottom = Value;
		}
		public function get Scale9GridBottom():int
		{
			return _Scale9GridBottom;
		}
		
		private var _BackgroundImageId:String = "";
		public function set BackgroundImageId(Value:String):void
		{
			_BackgroundImageId = Value;
		}
		public function get BackgroundImageId():String
		{
			return _BackgroundImageId;
		}
		
		public function set Corner(Value:int):void
		{
			_LeftTopCorner = _LeftBottomCorner = _RightTopCorner = _RightBottomCorner = Value;
		}
		
		private var _LeftTopCorner:int = 0;
		private var _LeftBottomCorner:int = 0;
		private var _RightTopCorner:int = 0;
		private var _RightBottomCorner:int = 0;
		
		public function set LeftTopCorner(Value:int):void
		{
			_LeftTopCorner = Value;
		}
		public function set LeftBottomCorner(Value:int):void
		{
			_LeftBottomCorner = Value;
		}
		
		public function set RightTopCorner(Value:int):void
		{
			_RightTopCorner = Value;
		}
		public function set RightBottomCorner(Value:int):void
		{
			_RightBottomCorner = Value;
		}
		
		public function get LeftTopCorner():int
		{
			return _LeftTopCorner;
		}
		public function get LeftBottomCorner():int
		{
			return _LeftBottomCorner;
		}
		public function get RightTopCorner():int
		{
			return _RightTopCorner;
		}
		public function get RightBottomCorner():int
		{
			return _RightBottomCorner;
		}
		
		protected var _Font:FontStyle = new FontStyle();
		
		public function get FontTextStyle():FontStyle
		{
			return _Font;
		}
		
		/**
		 * 序列化接口
		 **/
		public function Encode():ByteArray
		{
			var Data:ByteArray = new ByteArray();
			//1	Short	控件宽度
//			Data.writeShort(_Width);
//			//1	Short	控件高度
//			Data.writeShort(_Height);
			//1	Uint	背景颜色
			Data.writeUnsignedInt(_BackgroundColor);
			//1	Float	背景透明读
			Data.writeFloat(_BackgroundAlpha);
			//1	Uint	边框颜色
			Data.writeUnsignedInt(_BorderColor);
			//1	Float	边框透明度
			Data.writeFloat(_BorderAlpha);
			//1	Short	边框圆角
			//Data.writeShort(_BorderCorner);
			Data.writeByte(_LeftTopCorner);
			Data.writeByte(_LeftBottomCorner);
			Data.writeByte(_RightTopCorner);
			Data.writeByte(_RightBottomCorner);
			//1	Short	边框宽度
			Data.writeShort(_BorderThinkness);
			//1	Short	形状
			Data.writeShort(_Shape);
			//1	Short	半径
			Data.writeShort(_Radius);
			
			if(_BackgroundImage != null)
			{
				//有图形数据
				Data.writeByte(1);
				//Data.writeUTFBytes(Tools.FillChar(this.BackgroundImageId," ",50));
				Data.writeByte(BackgroundImageId.length);
				Data.writeUTFBytes(BackgroundImageId);
				Data.writeShort(_BackgroundImage.bitmapData.width);
				Data.writeShort(_BackgroundImage.bitmapData.height);
				Data.writeByte(_ImageFillType);
				if(this.Scale9Grid)
				{
					Data.writeByte(1);
					Data.writeByte(this.Scale9GridLeft);
					Data.writeByte(this.Scale9GridTop);
					Data.writeByte(this.Scale9GridRight);
					Data.writeByte(this.Scale9GridBottom);
				}
				else
				{
					Data.writeByte(0);
				}
				var ImgData:ByteArray = _BackgroundImage.bitmapData.getPixels(_BackgroundImage.bitmapData.rect);
				ImgData.compress();
				ImgData.position = 0;
				//1	int		图片数据域长度
				Data.writeUnsignedInt(ImgData.length);
				//图片数据
				Data.writeBytes(ImgData,0,ImgData.bytesAvailable);
			}
			else
			{
				Data.writeByte(0);
			}
			
			var FontData:ByteArray = _Font.Encode();
			Data.writeBytes(FontData,0,FontData.length);
			return Data;
		}
		
		public function Decode(Data:ByteArray):void
		{
			try
			{
//				_Width = Data.readShort();
//				//1	Short	控件高度
//				_Height = Data.readShort();
				//1	Uint	背景颜色
				_BackgroundColor = Data.readUnsignedInt();
				//1	Float	背景透明读
				_BackgroundAlpha = Data.readFloat();
				//1	Uint	边框颜色
				_BorderColor = Data.readUnsignedInt();
				//1	Float	边框透明度
				_BorderAlpha = Data.readFloat();
				//1	Short	边框圆角
				//_BorderCorner = Data.readShort();
				_LeftTopCorner = Data.readByte();
				_LeftBottomCorner = Data.readByte();
				_RightTopCorner = Data.readByte();
				_RightBottomCorner = Data.readByte();
				//1	Short	边框宽度
				_BorderThinkness = Data.readShort();
				//1	Short	形状
				_Shape = Data.readShort();
				//1	Short	半径
				_Radius = Data.readShort();
				
				var ImgFlag:int = Data.readByte();
				if(ImgFlag == 1)
				{
					var Len:int = Data.readByte();
					_BackgroundImageId = Data.readUTFBytes(Len);
					//_BackgroundImageId = Tools.ReplaceAll(Data.readUTFBytes(50)," ","");
					//获取图片长度
					var ImgWidth:int = Data.readShort();
					var ImgHeight:int = Data.readShort();
					_ImageFillType = Data.readByte();
					var Scale9GridFlag:int = Data.readByte();
					if(Scale9GridFlag)
					{
						Scale9Grid = true;
						Scale9GridLeft = Data.readByte();
						Scale9GridTop = Data.readByte();
						Scale9GridRight = Data.readByte();
						Scale9GridBottom = Data.readByte();
					}
					
					var ImgLen:int = Data.readUnsignedInt();
					var ImgData:ByteArray = new ByteArray();
					Data.readBytes(ImgData,0,ImgLen);
					ImgData.uncompress();
					ImgData.position = 0;
					
					var ImageData:BitmapData = new BitmapData(ImgWidth,ImgHeight);
					ImageData.setPixels(ImageData.rect,ImgData);
					_BackgroundImage = new Bitmap(ImageData);
				}
				_Font.Decode(Data);
			}
			catch(Err:Error)
			{
				trace(Err.message);
			}
		}
		
//		public function Clone(Prototype:Class = null):Object
//		{
//			if(Prototype == null)
//			{
//				Prototype = UIStyle;
//			}
//			flash.net.registerClassAlias(Tools.GetPackage(Prototype),Prototype);
//			return Cloneable.Instance.Clone(this);
//		}
		
		public function get ToString():String
		{
			trace("BorderThinkness[" + _BorderThinkness + "]");
			trace("BorderColor[" + _BorderColor + "]");
			//trace("BorderCorner[" + _BorderCorner + "]");
			trace("BackgroundColor[" + _BackgroundColor + "]");
			trace("BackgroundAlpha[" + _BackgroundAlpha + "]");
//			trace("Height[" + _Height + "]");
//			trace("Width[" + _Width + "]");
			trace("Shape[" + _Shape + "]");
			trace("Radius[" + _Radius + "]");
			return "";
		}
	}
}