package bleach.protocol
{
	import flash.utils.ByteArray;

	public class ProtocolGetRoomList extends ProtocolRequest
	{
		private var _page:int = 0;
		public function set page(value:int):void
		{
			_page = value;
		}
		public function get page():int
		{
			return _page;
		}
		public function ProtocolGetRoomList()
		{
			super(Protocol.CP_GetRoomList);
		}
		
		override public function getMessage():ByteArray
		{
			var data:ByteArray = super.getMessage();
			data.writeShort(_page);
			return data;
		}
	}
}