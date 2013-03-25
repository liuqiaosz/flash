package bleach.protocol
{
	import flash.utils.ByteArray;
	
	/**
	 * 登陆返回消息
	 **/
	public class ProtocolLoginResp extends ProtocolResponse
	{
//		private var _respCode:int = 0;
//		public function get respCode():int
//		{
//			return _respCode;
//		}
		private var _name:String = "";
		public function get name():String
		{
			return _name;
		}
		private var _level:int = 0;
		public function get level():int
		{
			return _level;
		}
		private var _gender:int = 0;
		public function get gender():int
		{
			return _gender;
		}
		public function ProtocolLoginResp()
		{
			super(Protocol.SP_Login);
		}
		
		override protected function messageAnalysis(source:ByteArray):void
		{
			if(source)
			{
				if(_respCode == 0)
				{
					_name = source.readUTF();
					_level = source.readInt();
					_gender = source.readByte();
				}
			}
			//trace(ByteArray(data).readUTFBytes(ByteArray(data).bytesAvailable);
		}
		
		override public function get toInfo():String
		{
			return "RespCode[" + super.respCode + "]\n" + 
				"Name[" + _name + "]\n" +
				"Level[" + _level + "]\n" +
				"Gender[" + _gender + "]\n";
		}
	}
}