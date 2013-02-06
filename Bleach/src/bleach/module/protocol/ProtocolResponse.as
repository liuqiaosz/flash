package bleach.module.protocol
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
		public function ProtocolResponse(id:int = 0,charset:String = "utf-8")
		{
			super(id,charset);
		}
		
		public final function setMessage(data:ByteArray):void
		{
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