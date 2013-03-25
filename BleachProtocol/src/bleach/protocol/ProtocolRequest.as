package bleach.protocol
{
	import flash.utils.ByteArray;

	public class ProtocolRequest extends ProtocolGeneric implements IProtocolRequest
	{
		public function ProtocolRequest(id:int = 0,charset:String = "utf-8")
		{
			super(id,charset);
		}
		
		public function getMessage():ByteArray
		{
			var data:ByteArray = new ByteArray();
			data.writeInt(_id);
			messageAnalysis(data);
			return data;
		}
	}
}