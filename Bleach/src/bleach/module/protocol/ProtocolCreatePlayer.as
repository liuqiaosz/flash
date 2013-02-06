package bleach.module.protocol
{
	import flash.utils.ByteArray;

	public class ProtocolCreatePlayer extends ProtocolRequest
	{
		private var _playerName:String = "";
		public function set playerName(value:String):void
		{
			_playerName = value;
		}
		
		private var _templateId:int = 0;
		public function set templateId(value:int):void
		{
			_templateId = value;
		}
		public function ProtocolCreatePlayer()
		{
			super(Protocol.CM_CreatePlayer);
		}
		
		override protected function messageAnalysis(data:ByteArray):void
		{
			data.writeUTF(_playerName);
			data.writeShort(_templateId);
		}
	}
}