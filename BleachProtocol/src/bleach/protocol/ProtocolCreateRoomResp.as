package bleach.protocol
{
	import flash.utils.ByteArray;

	public class ProtocolCreateRoomResp extends ProtocolResponse
	{
		private var _detail:String = "";
		public function get detail():String
		{
			return _detail;
		}
		
		public function ProtocolCreateRoomResp()
		{
			super(Protocol.SP_CreateRoom);
		}
		
		override protected function messageAnalysis(data:ByteArray):void
		{
			_detail = data.readUTF();
		}
	}
}