package bleach.protocol
{
	import flash.utils.ByteArray;

	/**
	 * 
	 * byte type;
	int16 mapId;
	String password;
	String desc;//描述或者叫名字,无密码，传个长度0
	byte playerNum;//开放的槽位[1,4]
	 **/
	public class ProtocolCreateRoom extends ProtocolRequest
	{
		//竞技
		public static const TYPE_PK:int = 1;
		//挑战
		public static const TYPE_CHALLENGE:int = 2;
		
		private var _type:int = TYPE_PK;
		public function set type(value:int):void
		{
			_type = value;
		}
		
//		private var _map:int = 0;
//		public function set map(value:int):void
//		{
//			_map = value;
//		}
		
		private var _password:String = "";
		public function set password(value:String):void
		{
			_password = value;
		}
		
		private var _desc:String = "";
		public function set desc(value:String):void
		{
			_desc = value;
		}
		
		private var _playerNum:int = 0;
		public function set playerNum(value:int):void
		{
			_playerNum = value;
		}
		
		public function ProtocolCreateRoom()
		{
			super(Protocol.CP_CreateRoom);
		}
		
		override public function getMessage():ByteArray
		{
			var data:ByteArray = super.getMessage();
			data.writeByte(_type);
//			data.writeShort(_map);
			if(_password.length > 0)
			{
				data.writeUTF(_password);
			}
			else
			{
				data.writeShort(0);
			}
			data.writeUTF(_desc);
			data.writeByte(_playerNum);
			return data;
		}
	}
}