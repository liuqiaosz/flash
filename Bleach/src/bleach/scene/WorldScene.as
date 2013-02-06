package bleach.scene
{
	import bleach.message.BleachLoadingMessage;
	import bleach.message.BleachMessage;
	import bleach.module.GenericModule;
	import bleach.scene.ui.WorldFlow;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	
	import pixel.core.PixelLauncher;
	import pixel.ui.control.IUIControl;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.UIPanel;
	import pixel.ui.control.vo.UIMod;
	
	/**
	 * 世界选择场景
	 * 
	 **/
	public class WorldScene extends GenericScene
	{
		private var _worldmap:IUIControl = null;
		public function WorldScene()
		{
			super();
		}
		
		override public function initializer():void
		{
			var cls:Object = getDefinitionByName("ui.world");
			var data:ByteArray = new cls() as ByteArray;
			var mod:UIMod = UIControlFactory.instance.decode(data,false);
			_worldmap = mod.controls.pop().control;
			_worldmap.x = _worldmap.y = 0;
			addChild(_worldmap as DisplayObject);
		}
		
		override public function dispose():void
		{
			super.dispose();
			_worldmap.dispose();
			_worldmap = null;
		}
		
		override protected function sceneUpdate():void
		{
			
		}
	}
}
