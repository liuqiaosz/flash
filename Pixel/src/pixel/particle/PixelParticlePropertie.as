package pixel.particle
{
	import flash.display.BitmapData;

	/**
	 * 粒子属性
	 */
	public class PixelParticlePropertie
	{
		protected var _size:int = 0;											//粒子初始大小
		public function set size(value:int):void
		{
			_size = value;
		}
		public function get size():int
		{
			return _size;
		}
		protected var _color:uint = 0xFFFFFF;									//颜色
		public function set color(value:uint):void
		{
			_color = value;
		}
		public function get color():uint
		{
			return _color;
		}
		protected var _health:Number = 0;										//粒子生命
		protected var _attenuation:Number = 0;									//衰减率
		protected var _alpha:Number = 1;
		protected var _accelerationX:Number = 0;								//X轴加速度
		public function set accelerationX(value:Number):void
		{
			_accelerationX = value;
		}
		public function get accelerationX():Number
		{
			return _accelerationX;
		}
		protected var _accelerationY:Number = 0;								//Y轴加速度
		public function set accelerationY(value:Number):void
		{
			_accelerationY = value;
		}
		public function get accelerationY():Number
		{
			return _accelerationY;
		}
		protected var _velocityX:Number = 0;									//X轴速度
		public function set velocityX(value:Number):void
		{
			_velocityX = value;
		}
		public function get velocityX():Number
		{
			return _velocityX;
		}
		protected var _velocityY:Number = 0;									//Y轴速度
		public function set velocityY(value:Number):void
		{
			_velocityY = value;
		}
		public function get velocityY():Number
		{
			return _velocityY;
		}
		protected var _gravity:Number = 0;										//重力
		public function set gravity(value:Number):void
		{
			_gravity = value;
		}
		public function get gravity():Number
		{
			return _gravity;
		}
		protected var _type:int = PixelParticleTypeEmu.PARTICLE_PIXEL;			//粒子类型，默认像素粒子
		public function set type(value:int):void
		{
			_type = value;
		}
		public function get type():int
		{
			return _type;
		}
		
		protected var _texture:BitmapData = null;								//粒子类型为图形粒子时该值为粒子纹理的图形
		protected var _randomSize:Boolean = false;							//是否随机大小
		protected var _randomColor:Boolean = false;							//是否随机颜色
		protected var _randomShock:Boolean = false;							//是否在方向加入随机振幅
		protected var _repeat:Boolean = true;									//是否重复粒子喷射
		protected var _blur:Boolean = false;									//是否开启模糊滤镜
		protected var _glow:Boolean = false;									//是否开启发光滤镜
		protected var _emitterLazy:int = 0;									//每次喷射间隔时间（毫秒）
		
		public function set emitterLazy(value:int):void
		{
			_emitterLazy = value;
		}
		public function get emitterLazy():int
		{
			return _emitterLazy;
		}
		public function set glow(value:Boolean):void
		{
			_glow = value;
		}
		public function get glow():Boolean
		{
			return _glow;
		}
		protected var _maxmizeParticle:int = 0;								//最大粒子数量,0为不限制
		public function set maxmizeParticle(value:int):void
		{
			_maxmizeParticle = value;
		}
		public function get maxmizeParticle():int
		{
			return _maxmizeParticle;
		}
		protected var _particleCount:int = 0;									//粒子数量，每帧喷射数量
		public function set particleCount(value:int):void
		{
			_particleCount = value;
		}
		public function get particleCount():int
		{
			return _particleCount;
		}
		protected var _poolable:Boolean = true;								//是否开启粒子池,默认开启
		public function set poolable(value:Boolean):void
		{
			_poolable = value;
		}
		public function get poolable():Boolean
		{
			return _poolable;
		}
		public function PixelParticlePropertie()
		{
		}
	}
}