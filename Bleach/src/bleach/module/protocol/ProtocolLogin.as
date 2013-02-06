package bleach.module.protocol
{
	import flash.utils.ByteArray;

	public class ProtocolLogin extends ProtocolRequest
	{
		private var _accName:String = "";
		public function set accName(value:String):void
		{
			_accName = value;
		}
		public function get accName():String
		{
			return _accName;
		}
		private var _accPwsd:String = "";
		public function set accPwsd(value:String):void
		{
			_accPwsd = value;
		}
		public function get accPwsd():String
		{
			return _accPwsd;
		}
		
		public function ProtocolLogin()
		{
			super(Protocol.CM_Login);
		}
		
		override public function getMessage():ByteArray
		{
			var data:ByteArray = super.getMessage();
			data.writeUTF(_accName);
			data.writeUTF(_accPwsd);
			
			return data;
		}
	}
}