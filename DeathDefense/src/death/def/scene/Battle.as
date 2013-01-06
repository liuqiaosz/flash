package death.def.scene
{
	import death.def.scene.vo.BattleVO;
	import death.def.view.IViewController;
	
	import flash.utils.Dictionary;
	import death.def.module.scene.GenericScene;

	public class Battle extends GenericScene implements IBattle
	{
		private var _cache:Dictionary = null;
		private var _currentBattle:BattleVO = null;
		private var _viewController:IViewController = null;
		public function Battle()
		{
			super(SceneConstants.SCENE_BATTLE);
		}
		
		override public function initializer():void
		{
			_cache = new Dictionary();
		}
		
		public function startFight(id:int):void
		{
			if(id in _cache)
			{
				var vo:BattleVO = _cache[id];
				if(vo)
				{
					_currentBattle = vo;
				}
			}
		}
		
		override protected function sceneUpdate():void
		{
			if(_currentBattle)
			{
				
			}
		}
	}
}