package pixel.io
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	import pixel.core.PixelConfig;
	import pixel.core.PixelLauncher;
	import pixel.core.PixelModule;
	import pixel.core.PixelNs;
	import pixel.error.ErrorContants;
	import pixel.error.PixelError;
	import pixel.graphic.IPixelGraphicModule;
	import pixel.graphic.PixelRenderMode;
	import pixel.message.IOMessage;
	import pixel.message.PixelMessage;
	import pixel.core.IPixelLayer;

	use namespace PixelNs;
	
	/** 
	 * IO模块
	 * 
	 * 负责设备输入（键盘输入,屏幕输出）
	 * 负责网络数据的输入输出
	 * 
	 **/
	public class PixelIOModule extends PixelModule implements IPixelIOModule
	{
		public function PixelIOModule()
		{
			super();
		}
		
		/**
		 * 初始化
		 * 
		 * 
		 **/
		override protected function initializer():void
		{
			PixelLauncher.launcher.gameStage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyboardInput);
			//_sceneQueue = new Vector.<IPixelScene>();
		}
		
		/**
		 * 键盘IO事件
		 * 
		 * 
		 **/
		private function onKeyboardInput(event:KeyboardEvent):void
		{
			var message:IOMessage = new IOMessage(IOMessage.KEYBOARD_INPUT);
			message.value = event.keyCode;
			dispatchMessage(message);
		}
		
		private var _graphic:IPixelGraphicModule = null;
		
		/**
		 * 
		 * 帧同步
		 * 
		 * 
		 **/
//		private function frameUpdate(message:PixelMessage):void
//		{
//			if(PixelConfig.renderMode == PixelRenderMode.RENDER_BITMAP)
//			{
//				//全位图渲染模式
//				if(!_graphic)
//				{
//					_graphic = PixelLauncher.launcher.graphicModule;
//				}
//				_graphic.render(_sceneQueue);
//			}
//		}
		
		public function screenRefresh(scenes:Vector.<IPixelLayer>):void
		{
			if(PixelConfig.renderMode == PixelRenderMode.RENDER_BITMAP)
			{
				//全位图渲染模式
				if(!_graphic)
				{
					_graphic = PixelLauncher.launcher.graphicModule;
				}
				_graphic.render(scenes);
			}
		}
		
		//private var _sceneQueue:Vector.<IPixelScene> = null;
		
		/**
		 * 将场景加入屏幕
		 * 
		 * 
		 **/
		public function addSceneToScreen(scene:IPixelLayer):void
		{
//			if(_sceneQueue.indexOf(scene) < 0)
//			{
//				_sceneQueue.push(scene);
//			}

			if(PixelConfig.renderMode == PixelRenderMode.RENDER_NORMAL)
			{
				//传统显示列表,直接将场景加入主舞台
				PixelLauncher.launcher.gameStage.addChild(scene as DisplayObject);
			}
		}
		
		/**
		 * 将场景从当前屏幕移除
		 * 
		 * 
		 **/
		public function removeSceneFromScreen(scene:IPixelLayer):void
		{
			if(PixelConfig.renderMode == PixelRenderMode.RENDER_NORMAL)
			{
				//传统显示列表,删除场景
				if(PixelLauncher.launcher.gameStage.contains(scene as DisplayObject))
				{
					PixelLauncher.launcher.gameStage.removeChild(scene as DisplayObject);
				}
			}
		}
	}
}