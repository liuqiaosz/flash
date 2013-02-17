package bleach.module.protocol
{
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	
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
			super(Protocol.SM_Login);
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
	}
}