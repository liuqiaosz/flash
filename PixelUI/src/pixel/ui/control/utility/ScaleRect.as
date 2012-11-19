package pixel.ui.control.utility
{
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class ScaleRect extends Rectangle
	{
		private var _FillWidth:int = 0;
		public function set FillWidth(Value:int):void
		{
			_FillWidth = Value;
			if(_FillHeight != width)
			{
				_Mtx.scale(FillWidth / width,_FillHeight / height);
			}
		}
		public function get FillWidth():int
		{
			return _FillWidth;
		}
		private var _FillHeight:int = 0;
		public function set FillHeight(Value:int):void
		{
			_FillHeight = Value;
			
			if(_FillHeight != width)
			{
				_Mtx.scale(FillWidth / width,_FillHeight / height);
			}
		}
		public function get FillHeight():int
		{
			return _FillHeight;
		}
		public function ScaleRect(x:int = 0,y:int = 0,width:int = 0,height:int = 0)
		{
			super(x,y,width,height);
			_FillWidth = width;
			_FillHeight = height;
		}
		
		public function RectUpdate(x:int = 0,y:int = 0,width:int = 0,height:int = 0):void
		{
			BitX = x;
			BitY = y;
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			_FillWidth = width;
			_FillHeight = height;
		}
		
		private var _Mtx:Matrix = new Matrix();
		public function get DrawMatrix():Matrix
		{
			_Mtx.translate(x,y);
			return _Mtx;
		}
		
		public var BitX:int = 0;
		public var BitY:int = 0;
	}
}