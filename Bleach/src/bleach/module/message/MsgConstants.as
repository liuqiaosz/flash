package bleach.module.message
{
	import flash.utils.Dictionary;

	public class MsgConstants extends MsgIdConstants
	{
		private static var _cache:Dictionary = new Dictionary();
		//心跳
		_cache[MSG_HEARTBEAT] = MsgHeartBeat;
		
		//心跳回应
		_cache[MSG_HEARTBEAT_RESP] = MsgHeartBeatResp;
		
		//登陆
		_cache[MSG_LOGIN] = MsgLogin;
		
		//登陆回应
		_cache[MSG_LOGIN_RESP] = MsgLoginResp;
		
		//进入大厅
		_cache[MSG_GAMECENTER] = MsgGameCenterResp;
		_cache[MSG_GAMECENTER_RESP] = MsgGameCenterResp;
		
		//查找房间
		_cache[MSG_ROOMLIST] = MsgRoomList;
		_cache[MSG_ROOMLIST_RESP] = MsgRoomListResp;
		
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