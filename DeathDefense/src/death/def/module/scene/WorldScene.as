package death.def.module.scene
{
	import death.def.module.GenericModule;
	import death.def.module.scene.ui.WorldFlow;
	
	import flash.events.MouseEvent;
	
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIPanel;
	
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
		}
		
		override protected function sceneUpdate():void
		{
			
		}
	}
}
