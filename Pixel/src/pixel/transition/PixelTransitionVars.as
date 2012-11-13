package pixel.transition
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;

	/**
	 * 过渡效果参数
	 * 
	 * 
	 **/
	public class PixelTransitionVars
	{
		//时间
		private var _duration:Number = 0;
		public function get duration():Number
		{
			return _duration;
		}
		
		//坐标，高，宽
		private var _dest:Rectangle = new Rectangle();
		public function set x(value:int):void
		{
			_dest.x = value;
		}
		public function get x():int
		{
			return _dest.x;
		}
		public function set y(value:int):void
		{
			_dest.y = value;
		}
		public function get y():int
		{
			return _dest.y;
		}
		public function set width(value:int):void
		{
			_dest.width = value;
		}
		public function get width():int
		{
			return _dest.width;
		}
		public function set height(value:int):void
		{
			_dest.height = value;
		}
		public function get height():int
		{
			return _dest.height;
		}
		
		//透明度
		private var _alpha:Number = 1;
		public function set alpha(value:Number):void
		{
			_alpha = value;
		}
		public function get alpha():Number
		{
			return _alpha;
		}
		
		private var _target:Object = null;
		public function get target():Object
		{
			return _target;
		}
		public function PixelTransitionVars(target:Object,duration:Number)
		{
			_target = target;
			_duration = duration;
		}
	}
}