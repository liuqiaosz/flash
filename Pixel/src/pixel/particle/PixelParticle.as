package pixel.particle
{
	import flash.display.Graphics;
	import flash.display.Shape;
	
	import pixel.core.PixelNs;
	import pixel.particle.event.PixelParticleEvent;

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
		protected var _death:Boolean = false;
		
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
		public function set color(value:uint):void
		{
			_color = value;
		}
		public function get color():uint
		{
			return _color;
		}
		protected var _health:Number = 0;				//粒子生命
		public function set health(value:Number):void
		{
			_health = value;
		}
		public function get health():Number
		{
			return _health;
		}
		protected var _gravity:Number = 0;
		protected var _radian:Number = 0;
//		protected var _originalColor:uint = 0;
//		protected var _originalHealth:Number = 0;
//		protected var _originalSize:int = 0;
//		protected var _originalRadian:Number = 0;
//		protected var _originalVX:Number = 0;
//		protected var _originalVY:Number = 0;
//		protected var _originalAccX:Number = 0;
//		protected var _originalAccY:Number = 0;
		protected var _velocityX:Number = 0;			//X轴速度
		protected var _velocityY:Number = 0;			//Y轴速度
		protected var _accelerationX:Number = 0;		//X加速度
		protected var _accelerationY:Number = 0;		//Y加速度
		protected var _attenuation:Number = 0;
		protected var _alpha:Number = 0;
		protected var _propertie:PixelParticlePropertie = null;
		protected var _grandientColor:Array = null;
		protected var _colorAcceleration:uint = 0;
		public function PixelParticle(propertie:PixelParticlePropertie)
		{
			super();
			_draw = graphics;
			_propertie = propertie;
			_size = _propertie.size;
			_color = _propertie.color;
			_health = _propertie.health;
			_radian = _propertie.redian;
			_velocityX = _propertie.velocityX;
			_velocityY = _propertie.velocityY;
			_accelerationX = _propertie.accelerationX;
			_accelerationY = _propertie.accelerationY;
			_attenuation = _propertie.attenuation;
			_alpha = _propertie.alpha;
			_grandientColor = _propertie.allowGradientColor ? _propertie.gradientColor:null;
			if(_grandientColor)
			{
				_color = _grandientColor[0];
				_colorAcceleration = (_grandientColor[1] - _color) / (_health / _attenuation);
			}
			x = _propertie.x;
			this.invalidatePropertie();
		}
		
		protected function invalidatePropertie():void
		{
			_hasUpdate = true;
		}
		
		public function render():void
		{
			_draw.clear();
			if(_propertie.type == 2)
			{
				_draw.beginBitmapFill(_propertie.texture);
				_draw.drawRect(0,0,_propertie.texture.width,_propertie.texture.height);
			}
			else
			{
				_draw.beginFill(_color,_alpha);
				_draw.drawCircle(0,0,_size);
				
			}
			_draw.endFill();
		}
		
		public function update():void
		{
			
//			if(!_death)
//			{
//				if(_hasUpdate)
//				{
//					render();
//					_hasUpdate = false;
//				}
//			}
			updateHealth();
			if(_propertie.allowGradientColor)
			{
				_color += _colorAcceleration;
				this.invalidatePropertie();
			}
			
			if(_hasUpdate)
			{
				render();
				_hasUpdate = false;
			}
		}
		
		private function updateHealth():void
		{
			_health -= _attenuation;
		}
		
		/**
		 * 更新发射器生命周期
		 */
//		public function updateHealth(attenuation:Number = 0):Number
//		{
//			_health -= attenuation;
//			if(_health <= 0)
//			{
//				_death = true;
//				//dispatchEvent(new PixelParticleEvent(PixelParticleEvent.PARTICLE_DEATH));
//			}
//			return _health;
//		}
		
		public function get isDeath():Boolean
		{
			if(_health <= 0)
			{
				return true;
			}
			return false;
		}
		
		public function get redian():Number
		{
			return _radian;
		}
		
		/**
		 * 重置状态
		 */
		public function reset():void
		{
			_death = false;
			_size = _propertie.size;
			_color = _propertie.color;
			_health = _propertie.health;
			_radian = _propertie.redian;
			//x = y = 0;
			x = _propertie.x;
			y = 0;
			_velocityX = _propertie.velocityX;
			_velocityY = _propertie.velocityY;
			_accelerationX = _propertie.accelerationX;
			_accelerationY = _propertie.accelerationY;
			_attenuation = _propertie.attenuation;
			alpha = _propertie.alpha;
			this.invalidatePropertie();
		}
	}
}