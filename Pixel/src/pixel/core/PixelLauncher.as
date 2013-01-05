package pixel.core
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import pixel.error.ErrorContants;
	import pixel.error.PixelError;
	import pixel.graphic.IPixelGraphicModule;
	import pixel.graphic.PixelGraphicModule;
	import pixel.io.IPixelIOModule;
	import pixel.io.PixelIOModule;
	import pixel.message.PixelMessage;
	import pixel.message.PixelMessageBus;
	
	use namespace PixelNs;
	
	/**
	 * 引擎入口主类
	 * 
	 * 负责加载配置数据和初始化核心模块
	 * 
	 **/
	public class PixelLauncher extends Sprite
	{
		private var _stage:Stage = null;
		private var _screen:PixelScreen = null;
		private static var _launcher:PixelLauncher = null;
		private var _director:IPixelDirector = null;
		private var _loop:Timer = null;
		private var _frameRate:int = 30;
		private var _initialized:Boolean = false;
		
		/**
		 * 基础模块定义
		 * 
		 * 
		 **/
		private var _graphicModule:IPixelGraphicModule = null;
		
		private var _ioModule:IPixelIOModule = null;
		public function PixelLauncher(director:Class = null,frameRate:int = 30)
		{
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			_frameRate = frameRate;
			_launcher = this;
			if(!director)
			{
				_director = new PixelDirector();
			}
			else
			{
				//初始化主控
				_director = new director() as IPixelDirector;
			}
			
			if(!_director)
			{
				throw new PixelError(ErrorContants.ERR_DIRECTOR);
			}
			
		}
		
		private function onAdded(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			onAddInitializer();
			
		}
		
		protected function onAddInitializer():void
		{
			try
			{
				_stage = stage;
				trace("初始化消息中心");
				//初始化消息中心
				PixelMessageBus.initiazlier();
				trace("初始化IO模块");
				_ioModule = new PixelIOModule();
				trace("初始化渲染模块");
				_graphicModule = new PixelGraphicModule();
				
				//启动
				_director.action();
				_initialized = true;
				
				//初始化主循环,启动
				_loop = new Timer(_frameRate);
				_loop.addEventListener(TimerEvent.TIMER,onFrameUpdate);
				_loop.start();
				
			}
			catch(err:Error)
			{
				throw new PixelError(err.message);
			}
		}
		
		/**
		 * IO模块
		 * 
		 **/
		PixelNs function get ioModule():IPixelIOModule
		{
			return _ioModule;
		}
		
		/**
		 * 
		 * 渲染模块
		 * 
		 **/
		PixelNs function get graphicModule():IPixelGraphicModule
		{
			return _graphicModule;
		}
		
		/**
		 * 获取当前主控
		 * 
		 * 
		 **/
		public function get director():IPixelDirector
		{
			return _director;
		}
		public function get frameRate():int
		{
			return _frameRate;
		}
		
		private var startSeek:int = 0;
		private var message:pixel.message.PixelMessage = new pixel.message.PixelMessage(PixelMessage.FRAME_UPDATE,this);
		/**
		 * 主循环
		 * 
		 * 
		 **/
		protected function onFrameUpdate(event:TimerEvent):void
		{
			PixelMessageBus.instance.dispatchMessage(message);
			startSeek = flash.utils.getTimer();
			//_director.update();	
			
			//trace((flash.utils.getTimer() - startSeek) + " ms");
		}
		
		/**
		 * 获取当前主控
		 * 
		 * 
		 **/
		public static function get director():IPixelDirector
		{
			return launcher.director;
		}
		
		public static function get frameRate():int
		{
			return launcher.frameRate;
		}
		
		PixelNs static function get launcher():PixelLauncher
		{
			return _launcher;
		}
		
		/**
		 * 返回当前Swf主舞台
		 * 
		 * 
		 **/
		public function get gameStage():Stage
		{
			return _stage;
		}
		
		public function get screen():PixelScreen
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