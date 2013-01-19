package bleach.module.message
{
	import flash.utils.ByteArray;

	public class MsgRequest extends MsgGeneric implements IMsgRequest
	{
		public function MsgRequest(id:int = 0,charset:String = "utf-8")
		{
			super(id,charset);
		}
		
		public function getMessage():ByteArray
		{
			var data:ByteArray = new ByteArray();
			data.writeInt(_id);
			return data;
		}
	}
}