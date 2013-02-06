package bleach.module.protocol
{
	import flash.utils.ByteArray;

	public class ProtocolMsgError extends ProtocolResponse
	{
		public function ProtocolMsgError()
		{
			super(Protocol.SM_Error);
		}
		
	}
}