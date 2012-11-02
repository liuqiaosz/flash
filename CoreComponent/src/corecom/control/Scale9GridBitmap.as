package corecom.control
{
	import corecom.control.utility.ScaleRect;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 九宫格缩放图形
	 **/
	public class Scale9GridBitmap extends Sprite
	{
		private var Source:Bitmap = null;
		private var Left:int = 0;
		private var Top:int = 0;
		private var Right:int = 0;
		private var Bottom:int = 0;
		
		private var _Width:int = 0;
		private var _Height:int = 0;
		
		public function get MinWidth():int
		{
			return Left + Right;
		}
		public function get MinHeight():int
		{
			return Top + Bottom;
		}
		
		public function Scale9GridBitmap(Source:Bitmap)
		{
			//保存原图
			this.Source = Source;
			_Width = Source.width;
			_Height = Source.height;
			
			LeftTop = new ScaleRect();
			//addChild(LeftTop);
			LeftCenter = new ScaleRect();
			//addChild(LeftCenter);
			LeftBottom = new ScaleRect();
			//addChild(LeftBottom);
			
			CenterTop = new ScaleRect();
			//addChild(CenterTop);
			Center = new ScaleRect();
			//addChild(Center);
			CenterBottom = new ScaleRect();
			//addChild(CenterBottom);
			
			RightTop = new ScaleRect();
			//addChild(RightTop);
			RightCenter = new ScaleRect();
			//addChild(RightCenter);
			RightBottom = new ScaleRect();
		}
		
		private var Vec:Vector.<ScaleRect> = null;
		
		public function get Rect():Vector.<ScaleRect>
		{
			if(null == Vec)
			{
				Vec = new Vector.<ScaleRect>();
				Vec.push(LeftTop);
				Vec.push(LeftCenter);
				Vec.push(LeftBottom);
				Vec.push(CenterTop);
				Vec.push(Center);
				Vec.push(CenterBottom);
				Vec.push(RightTop);
				Vec.push(RightCenter);
				Vec.push(RightBottom);
			}
			return Vec;
		}
		
		override public function set width(value:Number):void
		{
//			if(value == _Width)
//			{
//				return;
//			}
			if(value < MinWidth)
			{
				value = MinWidth;
			}
			_Width = value;
			UpdateResize();
		}
		override public function set height(value:Number):void
		{
//			if(value == _Height)
//			{
//				return;
//			}
			if(value < MinHeight)
			{
				value = MinHeight;
			}
			_Height = value;
			UpdateResize();
		}
		
//		private var LeftTop:Bitmap = null;
//		private var LeftCenter:Bitmap = null;
//		private var LeftBottom:Bitmap = null;
//		
//		private var CenterTop:Bitmap = null;
//		private var Center:Bitmap = null;
//		private var CenterBottom:Bitmap = null;
//		
//		private var RightTop:Bitmap = null;
//		private var RightCenter:Bitmap = null;
//		private var RightBottom:Bitmap = null;
		public var LeftTop:ScaleRect = null;
		public var LeftCenter:ScaleRect = null;
		public var LeftBottom:ScaleRect = null;
		
		public var CenterTop:ScaleRect = null;
		public var Center:ScaleRect = null;
		public var CenterBottom:ScaleRect = null;
		
		public var RightTop:ScaleRect = null;
		public var RightCenter:ScaleRect = null;
		public var RightBottom:ScaleRect = null;
		
		public function Scale9Grid(Left:int,Top:int,Right:int,Bottom:int):void
		{
			//左边预留
			this.Left = Left;
			//上面预留
			this.Top = Top;
			//右边预留
			this.Right = Top;
			//底部预留
			this.Bottom = Bottom;
			
//			LeftTop = GetBitmap(0,0,Left,Top);
//			//addChild(LeftTop);
//			LeftCenter = GetBitmap(0,Top,Left,(Source.height - Top - Bottom));
//			//addChild(LeftCenter);
//			LeftBottom = GetBitmap(0,Top + LeftCenter.height,Left,Bottom);
//			//addChild(LeftBottom);
//			
//			CenterTop = GetBitmap(Left,0,(Source.width - Left - Right),Top);
//			//addChild(CenterTop);
//			Center = GetBitmap(Left,Top,CenterTop.width,LeftCenter.height);
//			//addChild(Center);
//			CenterBottom = GetBitmap(Left,Center.y + Center.height,CenterTop.width,Bottom);
//			//addChild(CenterBottom);
//			
//			RightTop = GetBitmap(CenterTop.x + CenterTop.width,0,Right,Top);
//			//addChild(RightTop);
//			RightCenter = GetBitmap(RightTop.x,Top,Right,Center.height);
//			//addChild(RightCenter);
//			RightBottom = GetBitmap(RightTop.x,RightCenter.y + RightCenter.height,Right,Bottom);
			//addChild(RightBottom);
			LeftTop.RectUpdate(0,0,Left,Top);
			//addChild(LeftTop);
			LeftCenter.RectUpdate(0,Top,Left,(Source.height - Top - Bottom));
			//addChild(LeftCenter);
			LeftBottom.RectUpdate(0,Top + LeftCenter.height,Left,Bottom);
			//addChild(LeftBottom);
			
			CenterTop.RectUpdate(Left,0,(Source.width - Left - Right),Top);
			//addChild(CenterTop);
			Center.RectUpdate(Left,Top,CenterTop.width,LeftCenter.height);
			//addChild(Center);
			CenterBottom.RectUpdate(Left,Center.y + Center.height,CenterTop.width,Bottom);
			//addChild(CenterBottom);
			
			RightTop.RectUpdate(CenterTop.x + CenterTop.width,0,Right,Top);
			//addChild(RightTop);
			RightCenter.RectUpdate(RightTop.x,Top,Right,Center.height);
			//addChild(RightCenter);
			RightBottom.RectUpdate(RightTop.x,RightCenter.y + RightCenter.height,Right,Bottom);
		}
		
		public function UpdateScale(Left:int,Top:int,Right:int,Bottom:int):void
		{
			var Update:Boolean = false;
			Update = (this.Left != Left) || (this.Right != Right) || (this.Top != Top) || (this.Bottom != Bottom);
			if(Update)
			{
				//RemoveAll();
				Scale9Grid(Left,Top,Right,Bottom);
				UpdateResize();
			}
		}
		
		private function RemoveAll():void
		{
			var Img:Bitmap = null;
			
			while((Img = ImageArray.pop()) != null)
			{
				removeChild(Img);
			}
		}
		
		private var ImageArray:Array = [];
		
		public function set ScaleLeft(Value:int):void
		{
			Left = Value;
			UpdateResize();
		}
		public function set ScaleTop(Value:int):void
		{
			Top = Value;
			UpdateResize();
		}
		public function set ScaleRight(Value:int):void
		{
			Right = Value;
			UpdateResize();
		}
		public function set ScaleBottom(Value:int):void
		{
			Bottom = Value;
			UpdateResize();
		}
		
		protected function UpdateResize():void
		{
//			LeftCenter.height = _Height - Top - Bottom;
//			LeftBottom.y = LeftCenter.y + LeftCenter.height;
//			
//			CenterTop.width = _Width - Left - Right;
//			Center.width = _Width - Left - Right;
//			Center.height = _Height - Top - Bottom;
//			CenterBottom.width = CenterTop.width;
//			CenterBottom.x = Center.x;
//			CenterBottom.y = LeftBottom.y;
//			
//			RightTop.x = CenterTop.x + CenterTop.width;
//			RightCenter.x = RightTop.x;
//			RightCenter.height = Center.height;
//			
//			RightBottom.x = RightCenter.x;
//			RightBottom.y = CenterBottom.y;
			LeftCenter.FillHeight = _Height - Top - Bottom;
			LeftBottom.y = LeftCenter.y + LeftCenter.FillHeight;
			
			CenterTop.FillWidth = _Width - Left - Right;
			Center.FillWidth = _Width - Left - Right;
			Center.FillHeight = _Height - Top - Bottom;
			CenterBottom.FillWidth = CenterTop.FillWidth;
			CenterBottom.x = Center.x;
			CenterBottom.y = LeftBottom.y;
			
			RightTop.x = CenterTop.x + CenterTop.FillWidth;
			RightCenter.x = RightTop.x;
			RightCenter.FillHeight = Center.FillHeight;
			
			RightBottom.x = RightCenter.x;
			RightBottom.y = CenterBottom.y;
		}
		
//		protected function GetBitmap(X:int,Y:int,Width:int,Height:int):Bitmap
//		{
//			var Data:BitmapData = new BitmapData(Width,Height);
//			Data.copyPixels(Source.bitmapData,new Rectangle(X,Y,Width,Height),new Point());
//			var Image:Bitmap = new Bitmap(Data);
//			Image.x = X;
//			Image.y = Y;
//			if(!this.contains(Image))
//			{
//				addChild(Image);
//			}
//			ImageArray.push(Image);
//			return Image;
//		}
		
	}
}