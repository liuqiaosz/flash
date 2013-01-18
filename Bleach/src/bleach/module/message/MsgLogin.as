package bleach.module.message
{
	import flash.utils.ByteArray;

	public class MsgLogin extends MsgGeneric implements IMsg
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
		
		public function MsgLogin()
		{
			
		}
		
		override public function parse(data:ByteArray):void
		{
			var len:int = data.readInt();
		}
		
		override public function getMessage():Object
		{
			var data:ByteArray = new ByteArray();
			data.writeInt(MsgIdConstants.MSG_LOGIN);
			data.writeUTF(_accName);
			data.writeUTF(_accPwsd);
			
			return data;
		}
	}
}