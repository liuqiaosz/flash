package pixel.core
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import pixel.error.ErrorContants;
	import pixel.error.PixelError;
	import pixel.message.MessageBus;
	
	use namespace PixelNs;
	
	/**
	 * 引擎入口主类
	 * 
	 * 负责加载配置数据和初始化核心模块
	 * 
	 **/
	public class PixelLauncher extends Sprite
	{
		private static var _stage:Stage = null;
		private static var _screen:PixelScreen = null;
		private var _director:IPixelDirector = null;
		private var _loop:Timer = null;
		private var _frameRate:int = 30;
		private var _initialized:Boolean = false;
		public function PixelLauncher(director:Class,frameRate:int = 30)
		{
			_stage = stage;
			_frameRate = frameRate;
			try
			{
				//初始化主控
				_director = new director() as IPixelDirector;
				if(!_director)
				{
					throw new PixelError(ErrorContants.ERR_DIRECTOR);
				}
			}
			catch(err:Error)
			{
				throw new PixelError(err.message);
			}
			
			//初始化主循环,启动
			_loop = new Timer(_frameRate);
			_loop.addEventListener(TimerEvent.TIMER,onFrameUpdate);
			_loop.start();
		}
		
		
		
		/**
		 * 主循环
		 * 
		 * 
		 **/
		protected function onFrameUpdate(event:TimerEvent):void
		{
			if(_initialized)
			{
				_director.update();	
			}
			else
			{
				//进行初始化
				
				//初始化消息中心
				MessageBus.initiazlier();
			}
		}
		
		/**
		 * 返回当前Swf主舞台
		 * 
		 * 
		 **/
		PixelNs static function get stage():Stage
		{
			return _stage;
		}
		
		public static function get screen():PixelScreen
		{
			if(!_screen)
			{
				_screen = new PixelScreen();
				_screen.screenWidth = _stage.stageWidth;
				_screen.screenHeight = _stage.stageHeight;
			}
			return _screen;
		}
	}
}