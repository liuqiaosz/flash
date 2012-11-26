package pixel.particle
{
	import flash.display.Graphics;
	import flash.display.Shape;
	
	import pixel.core.PixelNs;

	use namespace PixelNs;

	/**
	 * 粒子类
	 * 
	 * 像素粒子
	 */
	public class PixelParticle extends Shape implements IPixelParticle
	{
		/**类属性定义**/
		protected var _hasUpdate:Boolean = false;
		
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
		protected var _shape:int = PixelParticleShapeEmu.PARTICLE_CIRCLE;		//默认圆形粒子
		public function set shape(value:int):void
		{
			_shape = value;
			invalidatePropertie()
		}
		public function get shape():int
		{
			return _shape;
		}
		protected var _color:uint = 0xFFFFFF;			//颜色
		protected var _health:int = 0;				//粒子生命
		protected var _attenuation:Number = 0;		//衰减率
		protected var _alpha:Number = 1;
		protected var _radius:Number = 0;
		protected var _draw:Graphics = null;
		
		public function PixelParticle(size:int = 0,color:uint = 0xFFFFFF,
									  shape:int = 1,health:int = 0,
									  attenuation:int = 0,alpha:Number = 1.0,
									  radius:Number = 0)
		{
			super();
			_size = size;
			_color = color;
			_shape = shape;
			_health = health;
			_attenuation = attenuation;
			_alpha = alpha;
			_radius = radius;
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
			_draw.beginFill(_color,_alpha);
			switch(_shape)
			{
				case PixelParticleShapeEmu.PARTICLE_CIRCLE:
					_draw.drawCircle(0,0,_size);
					break;
				case PixelParticleShapeEmu.PARTICLE_RECT:
					_draw.drawRect(0,0,_size,_size);
					break;
			}
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
	}
}