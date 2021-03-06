package death.def.communicator
{
	import death.def.module.message.MsgGetLevel;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import pixel.net.msg.tcp.IPixelTCPMessage;
	import pixel.net.msg.tcp.IPixelTCPMessageBody;
	import pixel.net.msg.tcp.IPixelTCPMessageHeader;
	import pixel.net.msg.tcp.PixelTCPMessageGenericParser;
	import death.def.module.message.MsgConstants;

	public class MessageParser extends PixelTCPMessageGenericParser
	{
		private var _map:Dictionary = null;
		public function MessageParser()
		{
			_map = new Dictionary();
			_map[MsgConstants.MSG_GETLEVELTOTAL] = MsgGetLevel;
		}
		
		public function decode(data:ByteArray):IPixelTCPMessage
		{
			data.position = 0;
			var id:int = data.readUnsignedShort();
			var msgData:ByteArray = new ByteArray();
			data.readBytes(msgData,0,data.bytesAvailable);
			if(id in _map)
			{
				var msg:IPixelTCPMessage = new _map[id] as IPixelTCPMessage;
				msg.decode(msgData);
				return msg;
			}
			return null;
		}
		
		protected function headerDecode(data:ByteArray):IPixelTCPMessageHeader
		{
			return null;
		}
		
		protected function bodyDecode(data:ByteArray):IPixelTCPMessageBody
		{
			return null;
		}
		
		public function encode(value:IPixelTCPMessage):ByteArray
		{
			return null;
		}
	}
}