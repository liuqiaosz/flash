package bleach.protocol
{
	import bleach.protocol.vo.RoomInfo;
	
	import flash.utils.ByteArray;

	public class ProtocolGetRoomListResp extends ProtocolResponse
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
		
		private var _page:int = 0;
		public function get page():int
		{
			return _page;
		}
		
		public function ProtocolGetRoomListResp()
		{
			super(Protocol.SP_GetRoomList);
		}
		
		override protected function messageAnalysis(data:ByteArray):void
		{
			super.setMessage(data);
			if(_respCode == 0)
			{
				_rooms = new Vector.<RoomInfo>();
				_page = data.readShort();
				_section = data.readByte();
				_totalPage = data.readShort();
				//读取房间数
				var roomCount:int = data.readShort();
				for(var idx:int = 0; idx < roomCount; idx++)
				{
					_rooms.push(new RoomInfo(data));
				}
			}
		}
	}
}