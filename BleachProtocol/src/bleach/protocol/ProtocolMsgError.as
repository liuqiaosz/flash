package bleach.protocol
{
	import flash.utils.ByteArray;

	public class ProtocolMsgError extends ProtocolResponse
	{
		public function ProtocolMsgError()
		{
			super(Protocol.SP_Error);
		}
		
	}
}