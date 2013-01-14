package death.def.module.scene
{
	import death.def.module.GenericModule;
	import death.def.module.scene.ui.WorldFlow;
	
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
			_scroller = new WorldFlow(1280,300,400,200);
			_scroller.y = 100;
			this.addNode(_scroller);
		}
		
		override protected function sceneUpdate():void
		{
			
		}
	}
}
