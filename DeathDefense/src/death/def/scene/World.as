package death.def.scene
{
	import death.def.event.BleachDefenseEvent;
	import death.def.view.IWorldViewController;
	import death.def.view.WorldViewController;
	import death.def.module.scene.GenericScene;

	public class World extends GenericScene
	{
		private var _viewController:IWorldViewController = null;
		public function World()
		{
			super(SceneConstants.SCENE_WORLD);
		}
		
		override public function initializer():void
		{
			_viewController = new WorldViewController();
			addNode(_viewController);
		}
		
		override public function dispose():void
		{
		}
		
		override protected function sceneUpdate():void
		{
			
		}
	}
}