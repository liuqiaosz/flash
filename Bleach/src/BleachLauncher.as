package 
{
	import bleach.BleachDirector;
	import bleach.message.BleachLoadingMessage;
	import bleach.message.BleachMessage;
	import bleach.scene.Battle;
	import bleach.scene.ui.WorldFlow;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import pixel.core.PixelLauncher;
	import pixel.message.PixelMessage;
	import pixel.message.PixelMessageBus;
	import pixel.texture.PixelTextureFactory;
	import pixel.ui.control.UIButton;
	import pixel.utility.ColorCode;
	import pixel.utility.System;
	import pixel.utility.SystemMode;
	import pixel.utility.Tools;
	
	/**
	 * 主程序
	 * 
	 **/
	public class BleachLauncher extends PixelLauncher
	{
		private var _scroller:WorldFlow = null;
		public function BleachLauncher()
		{
			super(BleachDirector);
			
			
		}
		
//		override protected function initializer():void
//		{
//			super.initializer();
////			var msg:BleachMessage = new BleachMessage(BleachMessage.BLEACH_WORLD_REDIRECT);
////			msg.value = "loginScene";
////			msg.deallocOld = true;
////			this.dispatchMessage(msg);
//			//this.director.switchScene(LoginScene);
//		}
		
	}
}