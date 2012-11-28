package pixel.particle
{

	/**
	 * 粒子属性
	 */
	public class PixelParticleEmitterPropertie extends PixelParticlePropertie
	{
		/**
		 * 喷射模式
		 * 
		 * 1：	横向喷射
		 * 1：	纵向喷射
		 */
		protected var _emitterMode:int = 0;
		
		//粒子发射器生命
		protected var _emitterHealth:Number = 0;
		public function set emitterHealth(value:Number):void
		{
			_emitterHealth = value;
		}
		public function get emitterHealth():Number
		{
			return _emitterHealth;
		}
		
		//发射器衰减率
		protected var _emitterAttenuation:Number = 0;
		public function set emitterAttenuation(value:Number):void
		{
			_emitterAttenuation = value;
		}
		public function get emitterAttenuation():Number
		{
			return _emitterAttenuation;
		}
		
		
		protected var _emitterLazy:int = 0;									//每次喷射间隔时间（毫秒）
		
		public function set emitterLazy(value:int):void
		{
			_emitterLazy = value;
		}
		public function get emitterLazy():int
		{
			return _emitterLazy;
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
		protected var _repeat:Boolean = true;									//是否重复粒子喷射
		public function set repeat(value:Boolean):void
		{
			_repeat = value;
		}
		public function get repeat():Boolean
		{
			return _repeat;
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
		public function PixelParticleEmitterPropertie()
		{
		}
	}
}