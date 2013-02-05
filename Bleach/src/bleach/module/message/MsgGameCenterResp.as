package bleach.module.message
{
	import bleach.module.message.vo.RoomInfo;
	
	import flash.utils.ByteArray;

	public class MsgGameCenterResp extends MsgResponse
	{
		private var _rooms:Vector.<RoomInfo> = null;
		public function get rooms():Vector.<RoomInfo>
		{
			return _rooms;
		}
		private var _section:int = 0;
		public function get section():int
		{
			return _section;
		}
		
		private var _totalPage:int = 0;
		public function get totalPage():int
		{
			return _totalPage;
		}
		override public function setMessage(source:ByteArray):void
		{
			if(source)
			{
				super.setMessage(source);
				_rooms = new Vector.<RoomInfo>();
				if(_respCode == 0)
				{
					//频道
					_section = source.readByte();
					//总页数
					_totalPage = source.readShort();
					//读取房间数
					var roomCount:int = source.readShort();
					for(var idx:int = 0; idx < roomCount; idx++)
					{
						_rooms.push(new RoomInfo(source));
					}
				}
			}
			//trace(ByteArray(data).readUTFBytes(ByteArray(data).bytesAvailable);
		}
	}
}