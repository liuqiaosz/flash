package death.def.scene
{
	import flash.utils.Dictionary;
	
	import pixel.core.PixelLayer;
	
	/**
	 * 
	 * 关卡选择场景
	 * 
	 **/
	public class LevelShowcase extends PixelLayer
	{
		//关卡数据队列
		private var _levelQueue:Vector.<Object> = null;
		//关卡总数
		private var _levelCount:int = 0;
		
		private var _levelShowcase:Dictionary = null;
		public function LevelShowcase()
		{
			super(SceneConstants.SCENE_LEVEL);
		}
		
		/**
		 * 初始化
		 * 
		 **/
		override public function initializer():void
		{
			//加载关卡数据
			
			//加载当前玩家存档的关卡数据
			
			//关卡数据逻辑处理
			
			//渲染关卡界面
			
			
		}
		
		/**
		 * 重置状态
		 * 
		 **/
		override public function reset():void
		{
		}
	}
}