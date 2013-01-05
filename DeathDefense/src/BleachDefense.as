package 
{
	import death.def.scene.Battle;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import pixel.core.PixelLauncher;
	import pixel.texture.PixelTextureFactory;
	import pixel.ui.control.UIButton;
	import pixel.utility.ColorCode;
	import pixel.utility.System;
	import pixel.utility.SystemMode;
	import pixel.utility.Tools;
	
	public class BleachDefense extends PixelLauncher
	{
		public function BleachDefense()
		{
			super();
		}
		override protected function onAddInitializer():void
		{
			addChild(new UIButton());
		}
	}
}