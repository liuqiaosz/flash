package bleach.module.protocol
{
	import flash.utils.ByteArray;

	public class ProtocolCheckAccountResp extends ProtocolResponse
	{
		private var _isNew:Boolean = false;
		public function get isNew():Boolean
		{
			return _isNew;
		}
		public function ProtocolCheckAccountResp()
		{
			super(Protocol.SM_CheckAccount);
		}
		
		/**
		 * 
		 **/
		override protected function messageAnalysis(data:ByteArray):void
		{
			_isNew = Boolean(data.readByte());
		}
	}
}