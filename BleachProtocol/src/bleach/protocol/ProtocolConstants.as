package bleach.protocol
{
	import flash.utils.Dictionary;

	public class ProtocolConstants
	{
		private static var _cache:Dictionary = new Dictionary();
		//心跳
		_cache[Protocol.CP_HeartBeat] = ProtocolHeartBeat;
		_cache[Protocol.SP_HeartBeat] = ProtocolHeartBeatResp;
		
		//异常
		_cache[Protocol.SP_Error] = ProtocolMsgError;
		
		//登陆
		_cache[Protocol.CP_Login] = ProtocolLogin;
		_cache[Protocol.SP_Login] = ProtocolLoginResp;
		
		//进入大厅
		_cache[Protocol.CP_EnterGameCenter] = ProtocolEnterGameCenter;
		_cache[Protocol.SP_EnterGameCenter] = ProtocolEnterGameCenterResp;
		
		//查找房间
		_cache[Protocol.CP_GetRoomList] = ProtocolGetRoomList;
		_cache[Protocol.SP_GetRoomList] = ProtocolGetRoomListResp;
		
		//账户检查
		_cache[Protocol.CP_CheckAccount] =  ProtocolCheckAccount;
		_cache[Protocol.SP_CheckAccount] =  ProtocolCheckAccountResp;
		
		//创建角色
		_cache[Protocol.CP_CreatePlayer] = ProtocolCreatePlayer;
		_cache[Protocol.SP_CreatePlayer] = ProtocolCreatePlayerResp;
		
		//创建房间
		_cache[Protocol.CP_CreateRoom] = ProtocolCreateRoom;
		_cache[Protocol.SP_CreateRoom] = ProtocolCreateRoomResp;
		
		public static function findMsgByCommand(id:int):Object
		{
			if(id in _cache)
			{
				return _cache[id];
			}
			return null;
		}
		
		public static function appendProtocol(command:int,protocol:Class):void
		{
			_cache[command] = protocol;
		}
	}
}