package editor.model.asset
{
	import flash.utils.ByteArray;
	
	import utility.ISerializable;

	public class Asset implements ISerializable
	{
		private var _Id:String = "";
		public function get Id():String
		{
			return _Id;
		}
		public function set Id(Value:String):void
		{
			_Id = Value;
		}
		
		private var _Type:uint = 0;
		public function set Type(Value:uint):void
		{
			_Type = Value;
		}
		public function get Type():uint
		{
			return _Type;
		}
		
		private var _Data:ByteArray = new ByteArray();
		public function set Data(Source:ByteArray):void
		{
			Source.position = 0;
			_Data.writeBytes(Source,0,Source.length);
			_Data.position = 0;
		}
		public function get Data():ByteArray
		{
			return _Data;
		}
		public function Asset()
		{
		}
		
		public function Encode():ByteArray
		{
			var EncodeByte:ByteArray = new ByteArray();
			//编码公共数据
			EncodeByte.writeUTFBytes(_Id);
			EncodeByte.writeShort(_Type);
			EncodeSpecial(EncodeByte);
			EncodeByte.writeUnsignedInt(_Data.length);
			EncodeByte.writeBytes(_Data,0,_Data.length);
			EncodeByte.position = 0;
			return EncodeByte;
		}
		
		/**
		 * 子类如需要编码自定义数据则需要覆写该方法。
		 **/
		protected function EncodeSpecial(Data:ByteArray):void
		{
		}
		protected function DecodeSpecial(Data:ByteArray):void
		{
		}
		
		/**
		 * 解码数据
		 **/
		public function Decode(Data:ByteArray):void
		{
			DecodeSpecial(Data);
			var Len:int = Data.readUnsignedInt();
			Data.readBytes(_Data,0,Len);
		}
	}
}