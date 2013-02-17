package bleach.module.protocol
{
	import flash.utils.Dictionary;

	public class ProtocolConstants
	{
		private static var _cache:Dictionary = new Dictionary();
		//心跳
		_cache[Protocol.CM_HeartBeat] = ProtocolHeartBeat;
		_cache[Protocol.SM_HeartBeat] = ProtocolHeartBeatResp;
		
		//异常
		_cache[Protocol.SM_Error] = ProtocolMsgError;
		
		//登陆
		_cache[Protocol.CM_Login] = ProtocolLogin;
		_cache[Protocol.SM_Login] = ProtocolLoginResp;
		
		//进入大厅
		_cache[Protocol.CM_EnterGameCenter] = ProtocolEnterGameCenter;
		_cache[Protocol.SM_EnterGameCenter] = ProtocolEnterGameCenterResp;
		
		//查找房间
		_cache[Protocol.CM_GetRoomList] = ProtocolGetRoomList;
		_cache[Protocol.SM_GetRoomList] = ProtocolGetRoomListResp;
		
		//账户检查
		_cache[Protocol.CM_CheckAccount] =  ProtocolCheckAccount;
		_cache[Protocol.SM_CheckAccount] =  ProtocolCheckAccountResp;
		
		//创建角色
		_cache[Protocol.CM_CreatePlayer] = ProtocolCreatePlayer;
		_cache[Protocol.SM_CreatePlayer] = ProtocolCreatePlayerResp;
		
		//创建房间
		_cache[Protocol.CM_CreateRoom] = ProtocolCreateRoom;
		_cache[Protocol.SM_CreateRoom] = ProtocolCreateRoomResp;
		
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