package game.sdk.map.tile
{
	public class TileMode
	{
		public static const TILE_STATE_LOCK:uint = 0;
		public static const TILE_STATE_FREE:uint = 1;
		
		public static const TILE_EMPTY:uint = 0;			//没有指定类型
		public static const TILE_ROLECREATOR:uint = 1;		//角色创建点
		public static const TILE_NPC:uint = 2;				//NPC点
		public static const TILE_BUILD:int = 3;				//建筑点
		public function TileMode()
		{
		}
	}
}