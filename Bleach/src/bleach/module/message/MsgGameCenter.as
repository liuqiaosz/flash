package bleach.module.message
{
	import flash.utils.ByteArray;
	
	/**
	 * 进入大厅协议
	 **/
	public class MsgGameCenter extends MsgRequest
	{
		public function MsgGameCenter()
		{
			super(MsgIdConstants.MSG_GAMECENTER);
		}
	}
}