package bleach.scene
{
	import bleach.message.BleachLoadingMessage;
	import bleach.message.BleachMessage;
	import bleach.module.GenericModule;
	import bleach.scene.ui.WorldFlow;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import pixel.core.PixelLauncher;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIPanel;
	
	/**
	 * 世界选择场景
	 * 
	 **/
	public class WorldScene extends GenericScene
	{
		private var _left:UIButton = null;
		public function WorldScene()
		{
			super();
		}
		
		override public function initializer():void
		{
			//addMessageListener(BleachLoadingMessage.BLEACH_LOADING_END,loadingEnd);
			//加载世界数据
//			_scroller = new WorldFlow(1280,400,600,300);
//			_scroller.y = 100;
//			this.addChild(_scroller);
//			var p1:UIPanel = new UIPanel();
//			p1.width = 600;
//			p1.height = 300;
//			
//			var p2:UIPanel = new UIPanel();
//			p2.width = 600;
//			p2.height = 300;
//			
//			var p3:UIPanel = new UIPanel();
//			p3.width = 600;
//			p3.height = 300;
//			
//			p1.BackgroundColor = 0xFF0000;
//			_scroller.addChild(p1);
//			_scroller.addChild(p2);
//			_scroller.addChild(p3);
			
			_left = new UIButton();
			_left.Text = "Left";
			
			addChild(_left);
			
			_left.addEventListener(MouseEvent.CLICK,direct);
//			
//			var right:UIButton = new UIButton();
//			right.Text = "Right";
//			right.x = 200;
//			addChild(right);
//			right.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
//				_scroller.scrollRight();
//			});
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
		
		private function direct(event:MouseEvent):void
		{
			var msg:BleachMessage = new BleachMessage(BleachMessage.BLEACH_WORLD_REDIRECT);
			msg.value = "loginScene";
			this.dispatchMessage(msg);
		}
		
		override public function dealloc():void
		{
			super.dealloc();
			_left.removeEventListener(MouseEvent.CLICK,direct);
			removeChild(_left);
			_left = null;
		}
		
		override protected function sceneUpdate():void
		{
			
		}
	}
}
