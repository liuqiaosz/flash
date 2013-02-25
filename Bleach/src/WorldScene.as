package 
{
	import bleach.message.BleachLoadingMessage;
	import bleach.message.BleachMessage;
	import bleach.module.GenericModule;
	import bleach.scene.ui.WorldFlow;
	import bleach.utils.Constants;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	
	import pixel.core.PixelLauncher;
	import pixel.ui.control.IUIContainer;
	import pixel.ui.control.IUIControl;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.UIPanel;
	import pixel.ui.control.vo.UIMod;
	import bleach.scene.GenericScene;
	
	/**
	 * 世界选择场景
	 * 
	 **/
	public class WorldScene extends GenericScene
	{
		private var _worldmap:IUIContainer = null;
		private var _roomBuild:UIButton = null;
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
			_roomBuild = _worldmap.GetChildById("map013",true) as UIButton;
			_roomBuild.addEventListener(MouseEvent.CLICK,gotoRoomSequare);
			addChild(_worldmap as DisplayObject);
		}
		
		/**
		 * 
		 * 进入战斗大厅
		 * 
		 **/
		private function gotoRoomSequare(event:MouseEvent):void
		{
			var direct:BleachMessage = new BleachMessage(BleachMessage.BLEACH_WORLD_REDIRECT);
			direct.value = Constants.SCENE_ROOMSQUARE;
			dispatchMessage(direct);
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
