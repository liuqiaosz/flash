package bleach.module.message
{
	import flash.utils.ByteArray;

	public class MsgRoomList extends MsgRequest
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
		public function MsgRoomList()
		{
			super(MsgIdConstants.MSG_ROOMLIST);
		}
		
		override public function getMessage():ByteArray
		{
			var data:ByteArray = super.getMessage();
			data.writeShort(_page);
			return data;
		}
	}
}