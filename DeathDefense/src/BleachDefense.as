package 
{
	import death.def.BleachDirector;
	import death.def.event.BleachMessage;
	import death.def.module.scene.WorldScene;
	import death.def.module.scene.ui.WorldFlow;
	import death.def.scene.Battle;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import pixel.core.PixelLauncher;
	import pixel.message.PixelMessage;
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
	public class BleachDefense extends PixelLauncher
	{
		private var _scroller:WorldFlow = null;
		public function BleachDefense()
		{
			super(BleachDirector);
		}
		
		override protected function initializer():void
		{
			super.initializer();
			this.director.switchScene(WorldScene);
		}
	}
}