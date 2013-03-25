package bleach.protocol
{
	import flash.utils.ByteArray;

	public class ProtocolResponse extends ProtocolGeneric implements IProtocolResponse
	{
		protected var _respCode:int = 0;
		public function get respCode():int
		{
			return _respCode;
		}
		
		protected var _respMsg:String = "";
		public function get respMsg():String
		{
			return _respMsg;
		}
		//协议原数据
		protected var _protocol:ByteArray = null;
		public function get protocol():ByteArray
		{
			return _protocol;
		}
		public function ProtocolResponse(id:int = 0,charset:String = "utf-8")
		{
			super(id,charset);
		}
		
		public function setMessage(data:ByteArray):void
		{
			_protocol = new ByteArray();
			_protocol.writeBytes(data);
			_protocol.position = 0;
			_respCode = data.readShort();
			if(_respCode == 0)
			{
				messageAnalysis(data);
			}
//			else
//			{
//				_respMsg = data.readUTFBytes(data.bytesAvailable);
//			}
		}
		
	}
}