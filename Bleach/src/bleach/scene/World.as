package bleach.scene
{
	import bleach.event.BleachEvent;
	import bleach.view.IWorldViewController;
	import bleach.view.WorldViewController;

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