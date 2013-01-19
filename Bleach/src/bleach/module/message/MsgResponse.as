package bleach.module.message
{
	import flash.utils.ByteArray;

	public class MsgResponse extends MsgGeneric implements IMsgResponse
	{
		public function MsgResponse(id:int = 0,charset:String = "utf-8")
		{
			super(id,charset);
		}
		
		public function setMessage(data:ByteArray):void
		{
		}
	}
}