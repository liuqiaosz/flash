package bleach.module.protocol.vo
{
	import flash.utils.ByteArray;

	public class RoomInfo
	{
		
		
		//房间ID
		private var _roomId:int = 0;
		public function get roomId():int
		{
			return _roomId;
		}
		//房间类型
		private var _type:int = 0;
		public function get type():int
		{
			return _type;
		}
		//地图ID
		private var _mapId:int = 0;
		public function get mapId():int
		{
			return _mapId;
		}
		//人数限制
		private var _userLimit:int = 0;
		public function get userLimit():int
		{
			return _userLimit;
		}
		//已有人数
		private var _userNum:int = 0;
		public function get userNum():int
		{
			return _userNum;
		}
		//是否密码
		private var _password:int = 2;
		public function get password():int
		{
			return _password;
		}
		
		/**
		 * int32 id;
		 byte type;	//竞技还是挑战1,竞技 2,挑战
		 int16 mapId;	//==0随机地图
		 byte limit;	//人数上限
		 byte playerNum;		//已有的人数
		 byte needPassword; //是否需要密码,1需要 2,不需要
		 * 
		 **/
		
		
		public function RoomInfo(source:ByteArray)
		{
			_roomId = source.readInt();
			_type = source.readByte();
			_mapId = source.readShort();
			_userLimit = source.readByte();
			_userNum = source.readByte();
			_password = source.readByte();
		}
	}
}