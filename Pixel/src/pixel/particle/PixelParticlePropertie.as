package pixel.particle
{
	import flash.display.BitmapData;
	
	import pixel.utility.Tools;

	public class PixelParticlePropertie
	{
		protected var _allowGradientColor:Boolean = false;
		public function set allowGradientColor(value:Boolean):void
		{
			_allowGradientColor = value;
		}
		public function get allowGradientColor():Boolean
		{
			return _allowGradientColor;
		}
		
		protected var _gradientColor:Array = [];								//渐变颜色
		public function set gradientColor(value:Array):void
		{
			_gradientColor = value;
		}
		public function get gradientColor():Array
		{
			return _gradientColor;
		}
		protected var _size:int = 0;											//粒子初始大小
		public function set size(value:int):void
		{
			_size = value;
		}
		public function get size():int
		{
			if(_randomSize)
			{
				if(_randomSizeScope.length == 2)
				{
					return Tools.random(_randomSizeScope[1],_randomSizeScope[0]);
				}
			}
			return _size;
		}
		protected var _randomSizeScope:Array = [];
		public function set randomSizeScope(value:Array):void
		{
			_randomSizeScope = value;
		}
		public function get randomSizeScope():Array
		{
			return _randomSizeScope;
		}
		protected var _color:uint = 0xFFFFFF;									//颜色
		public function set color(value:uint):void
		{
			_color = value;
		}
		public function get color():uint
		{
			if(_randomColor)
			{
				return Math.random() * 0xFFFFFF;
			}
			return _color;
		}
		protected var _health:Number = 0;										//粒子生命
		public function set health(value:Number):void
		{
			_health = value;
		}
		public function get health():Number
		{
			return _health;
		}
		protected var _randomAttenuation:Boolean = false;						//随机衰减率
		public function set randomAttenuation(value:Boolean):void
		{
			_randomAttenuation = value;
		}
		public function get randomAttenuation():Boolean
		{
			return _randomAttenuation;
		}
		protected var _randomAttenuationScope:Array = [];
		public function set randomAttenuationScope(value:Array):void
		{
			_randomAttenuationScope = value;
		}
		public function get randomAttenuationScope():Array
		{
			return _randomAttenuationScope;
		}
		protected var _attenuation:Number = 0;									//衰减率
		public function set attenuation(value:Number):void
		{
			_attenuation = value;
		}
		public function get attenuation():Number
		{
			if(_randomAttenuation)
			{
				if(_randomAttenuationScope.length >= 2)
				{
					
					return Tools.random(_randomAttenuationScope[1],_randomAttenuationScope[0]);
				}
			}
			return _attenuation;
		}
		protected var _randomAlpha:Boolean = false;
		public function set randomAlpha(value:Boolean):void
		{
			_randomAlpha = value;
		}
		public function get randomAlpha():Boolean
		{
			return _randomAlpha;
		}
		protected var _alpha:Number = 1;
		public function set alpha(value:Number):void
		{
			_alpha = value;
		}
		public function get alpha():Number
		{
			if(_randomAlpha)
			{
				return Math.random();
			}
			return _alpha;
		}
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
		protected var _friction:Number = 0;
		public function set friction(value:Number):void
		{
			_friction = value;
		}
		public function get friction():Number
		{
			return _friction;
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
		public function set texture(value:BitmapData):void
		{
			_texture = value;
		}
		public function get texture():BitmapData
		{
			return _texture;
		}
		protected var _randomSize:Boolean = false;							//是否随机大小
		public function set randomSize(value:Boolean):void
		{
			_randomSize = value;
		}
		public function get randomSize():Boolean
		{
			return _randomSize;
		}
		protected var _randomColor:Boolean = false;							//是否随机颜色
		public function set randomColor(value:Boolean):void
		{
			_randomColor = value;
		}
		public function get randomColor():Boolean
		{
			return _randomColor;
		}
		protected var _randomShock:Boolean = false;							//是否在方向加入随机振幅
		public function set randomShock(value:Boolean):void
		{
			_randomShock = value;
		}
		public function get randomShock():Boolean
		{
			
			return _randomShock;
		}
		
		protected var _randomRedian:Boolean = false;						//随机方向
		public function set randomRedian(value:Boolean):void
		{
			_randomRedian = value;
		}
		public function get randomRedian():Boolean
		{
			return _randomRedian;
		}
		
		protected var _randomRedianScope:Array = [];							//随机角度范围，参数1：最小值，参数2：最大值
		public function set randomRedianSceop(value:Array):void
		{
			_randomRedianScope = value;
		}
		public function get randomRedianSceop():Array
		{
			return _randomRedianScope;
		}
	
		protected var _blur:Boolean = false;									//是否开启模糊滤镜
		public function set blur(value:Boolean):void
		{
			_blur = value;
		}
		public function get blur():Boolean
		{
			return _blur;
		}
		protected var _glow:Boolean = false;									//是否开启发光滤镜
		public function set glow(value:Boolean):void
		{
			_glow = value;
		}
		public function get glow():Boolean
		{
			return _glow;
		}
		
		protected var _redian:Number = 0;										//弧度，同时也代表方向
		public function set redian(value:Number):void
		{
			_redian = value;
		}
		public function get redian():Number
		{
			if(randomRedian)
			{
				if(_randomRedianScope.length >= 2)
				{
					
					return Tools.degreesToRadius(Tools.random(_randomRedianScope[1],_randomRedianScope[0]));
				}
				return Math.random() * 360;
			}
			return _redian;
		}
		protected var _radianAttenuation:Number = 0;
		public function set radianAttenuation(value:Number):void
		{
			_radianAttenuation = value;
		}
		public function get radianAttenuation():Number
		{
			return _radianAttenuation;
		}
		
		protected var _randomX:Boolean = false;								//是否开启随机X初始位置
		public function set randomX(value:Boolean):void
		{
			_randomX = value;
		}
		public function get randomX():Boolean
		{
			return _randomX;
		}
		protected var _randomXScope:Array = [];
		public function set randomXScope(value:Array):void
		{
			_randomXScope = value;
		}
		
		protected var _x:int = 0;
		public function set x(value:int):void
		{
			_x = value;
		}
		public function get x():int
		{
			if(_randomX)
			{
				return Tools.random(_randomXScope[1],_randomXScope[0]);
			}
			return _x;
		}
		
		public function PixelParticlePropertie()
		{
		}
	}
}