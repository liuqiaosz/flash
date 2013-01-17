package bleach.scene
{
	import bleach.message.BleachLoadingMessage;
	import bleach.module.GenericModule;
	import bleach.scene.ui.WorldFlow;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import pixel.core.PixelLauncher;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIPanel;
	import bleach.module.scene.GenericScene;
	
	/**
	 * 世界选择场景
	 * 
	 **/
	public class WorldScene extends GenericScene
	{
		private var _scroller:WorldFlow = null;
		public function WorldScene()
		{
			super();
		}
		
		override public function initializer():void
		{
			addMessageListener(BleachLoadingMessage.BLEACH_LOADING_END,loadingEnd);
			//加载世界数据
			_scroller = new WorldFlow(1280,400,600,300);
			_scroller.y = 100;
			this.addChild(_scroller);
			var p1:UIPanel = new UIPanel();
			p1.width = 600;
			p1.height = 300;
			
			var p2:UIPanel = new UIPanel();
			p2.width = 600;
			p2.height = 300;
			
			var p3:UIPanel = new UIPanel();
			p3.width = 600;
			p3.height = 300;
			
			p1.BackgroundColor = 0xFF0000;
			_scroller.addChild(p1);
			_scroller.addChild(p2);
			_scroller.addChild(p3);
			
			var left:UIButton = new UIButton();
			left.Text = "Left";
			
			addChild(left);
			
			left.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
				_scroller.scrollLeft();
			});
			
			var right:UIButton = new UIButton();
			right.Text = "Right";
			right.x = 200;
			addChild(right);
			right.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
				_scroller.scrollRight();
			});
			
			var max:Number = 0;
			var a:BleachLoadingMessage = new BleachLoadingMessage(BleachLoadingMessage.BLEACH_LOADING_SHOW);
			
			var loop:Timer = new Timer(1000,1);
			loop.addEventListener(TimerEvent.TIMER,function(event:TimerEvent):void{
				var up:BleachLoadingMessage = new BleachLoadingMessage(BleachLoadingMessage.BLEACH_LOADING_UPDATE);
				up.loaded = 100;
				up.total = 100;
				
				dispatchMessage(up);
			});
			loop.start();
			this.dispatchMessage(a);
		}
		
		private function loadingEnd(msg:BleachLoadingMessage):void
		{
			dispatchMessage(new BleachLoadingMessage(BleachLoadingMessage.BLEACH_LOADING_HIDE));
		}
		
		override protected function sceneUpdate():void
		{
			
		}
	}
}
