package death.def.module.message
{
	import flash.utils.Dictionary;

	public class MsgConstants extends MsgIdConstants
	{
		private static var _cache:Dictionary = new Dictionary();
		//获取当前用户信息
		_cache[MSG_GETUSER] = MsgGetUser;
		
		//获取关卡综合数据
		_cache[MSG_GETLEVEL] = MsgGetLevel;
		
		//获取当前世界场景数据
		_cache[MSG_GETWORLD] = MsgGetWorld;
		
		//获取全局配置
		_cache[MSG_GLOBALCFG] = MsgGlobalConfig;
		
		public static function findMsgById(id:int):Object
		{
			if(id in _cache)
			{
				return _cache[id];
			}
			return null;
		}
	}
}