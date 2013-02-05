package bleach.module.message
{
	import flash.utils.ByteArray;

	public class MsgResponse extends MsgGeneric implements IMsgResponse
	{
		protected var _respCode:int = 0;
		public function get respCode():int
		{
			return _respCode;
		}
		public function MsgResponse(id:int = 0,charset:String = "utf-8")
		{
			super(id,charset);
		}
		
		public function setMessage(data:ByteArray):void
		{
			_respCode = data.readShort();
		}
	}
}