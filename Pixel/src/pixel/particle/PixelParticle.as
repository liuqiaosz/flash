package pixel.particle
{
	import flash.display.Graphics;
	import flash.display.Shape;
	
	import pixel.core.PixelNs;

	use namespace PixelNs;

	/**
	 * 粒子类
	 * 
	 * 
	 */
	public class PixelParticle extends Shape implements IPixelParticle
	{
		/**类属性定义**/
		protected var _hasUpdate:Boolean = false;
		protected var _draw:Graphics = null;
		
		/**粒子属性定义**/
		protected var _size:int = 0;					//大小
		public function set size(value:int):void
		{
			_size = value;
			invalidatePropertie();
		}
		public function get size():int
		{
			return _size;
		}
		
		
		protected var _color:uint = 0xFFFFFF;			//颜色
		protected var _health:Number = 0;				//粒子生命
		protected var _attenuation:Number = 0;		//衰减率
		protected var _radian:Number = 0;

		
		public function PixelParticle(
			size:int = 0,						//粒子大小
			color:uint = 0xFFFFFF,				//颜色
			health:int = 0,						//粒子生命
			radian:Number = 0)
		{
			super();
			_size = size;
			_color = color;
			_health = health;
			
			_radian = radian;
			_draw = graphics;
			invalidatePropertie();
		}
		
		protected function invalidatePropertie():void
		{
			_hasUpdate = true;
		}
		
		public function render():void
		{
			_draw.clear();
			_draw.beginFill(_color);
			_draw.drawCircle(0,0,_size);
			_draw.endFill();
		}
		
		public function update():void
		{
			if(_hasUpdate)
			{
				render();
				_hasUpdate = false;
			}
		}
		
		/**
		 * 重置状态
		 */
		public function reset():void
		{
		}
	}
}