package game.sdk.anim
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * 
	 * 帧动画切割类
	 * 
	 **/
	public class GraphicAnimation
	{
		//resource 
		private var _resource:Bitmap;
		
		//幀率
		private var _frameRate:Number;
		public function get frameRate():Number
		{
			return _frameRate;
		}
		
		private var _frameWidth:Number;
		public function get frameWidth():Number
		{
			return _frameWidth;
		}
		private var _frameHeight:Number;
		public function get frameHeight():Number
		{
			return _frameHeight;
		}
		
		private var _frameCount:Number = 0;
		public function get frameCount():Number
		{
			return _frameCount;
		}
		
		private var _mutiRowResource:Boolean = false;
		
		private var _row:Number = 1;
		private var _col:Number = 1;
		
		private var frames:Vector.<BitmapData>;
		
//		private var _currentFrame:Number = 0;
		
		private var _isFrames:Boolean = false;
		public function get isFrames():Boolean
		{
			return _isFrames;
		}
		
		private var _frameMillion:uint = 0;
		public function frameMillion():uint
		{
			return _frameMillion;
		}
		
		/**
		 * 
		 * animationName:	名称
		 * graphicSrouce:	资源
		 * frameRate:		帧数
		 * 
		 */
		public function GraphicAnimation(graphicSource:Class,frameW:Number,frameH:Number)
		{
			var obj:Object = new graphicSource();
			
			if(obj is BitmapData)
			{
				_resource = new Bitmap(obj as BitmapData);
			}
			else
			{
				_resource = obj as Bitmap;
			}
			//_frameRate = frameRate;
			_frameWidth = frameW;
			_frameHeight = frameH;
			frames = new Vector.<BitmapData>();
			initializer();
		}
		
		public function initializer():Boolean
		{
			if(null == _resource)
			{
				return false;
			}
			
			//判断是否多层
			_col = _resource.width / _frameWidth;
			_row = _resource.height / _frameHeight;
			//计算帧数
			_frameRate = _col * _row;
			var point:Point = new Point(0,0);
			for(var r:int=0; r<_row; r++)
			{
				for(var c:int=0; c<_col; c++)
				{
					var rect:Rectangle = new Rectangle(c * _frameWidth,r*_frameHeight,_frameWidth,_frameHeight);
					var frame:BitmapData = new BitmapData(_frameWidth,_frameHeight);
					frame.copyPixels(_resource.bitmapData,rect,point);
					frames.push(frame);
					_frameCount++;
				}
			}
			
			if(frames.length > 1)
			{
				_isFrames = true;
			}
			
			return true;
		}
		
		public function getFrameByIndex(idx:Number):BitmapData
		{
			if(idx + 1 > frames.length)
			{
				return frames[0];
			}
			
			return frames[idx];
		}
//		public function prevFrame():BitmapData
//		{
//			if(_currentFrame == 0)
//			{
//				_currentFrame = _frameRate - 1;
//			}
//			var result:BitmapData = frames[_currentFrame];
//			_currentFrame--;
//			return frames[_currentFrame];
//		}
	}
}