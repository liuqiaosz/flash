package bleach.module.protocol
{
	import flash.utils.ByteArray;
	
	/**
	 * 进入大厅协议
	 **/
	public class ProtocolEnterGameCenter extends ProtocolRequest
	{
		public function ProtocolEnterGameCenter()
		{
			super(Protocol.CM_EnterGameCenter);
		}
	}
}