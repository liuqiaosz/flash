package utility.swf.tag
{
	import flash.events.EventDispatcher;
	
	import utility.swf.ByteStream;

	public class GenericTag extends EventDispatcher implements ITag
	{
		protected var _TagId:int = -1;	
		protected var Stream:ByteStream = null;
		protected var _Type:int = -1;
		protected var _Id:String = "";
		public function get Type():int
		{
			return _Type;
		}
		public function set TagId(Value:int):void
		{
			_TagId = Value;
		}
		public function get TagId():int
		{
			return _TagId;
		}
		
		public function set Id(Value:String):void
		{
			_Id = Value;
		}
		public function get Id():String
		{
			return _Id;
		}
		
//		private var _SymbolName:String = "";
//		public function set SymbolName(Value:String):void
//		{
//			_SymbolName = Value;
//		}
//		public function get SymbolName():String
//		{
//			return _SymbolName;
//		}
		
		public function GenericTag(Type:int,Stream:ByteStream = null)
		{
			_Type = Type;
			if(Stream)
			{
				this.Stream = Stream;
				Decode(Stream);
			}
			else
			{
				this.Stream = new ByteStream();
			}
		}
		
		public function get Source():Object
		{
			return null;
		}
		
		public function Encode():ByteStream
		{
			//Stream.WriteUI8(
			return null;
		}
		public function Decode(Stream:ByteStream):void
		{
		}
	}
}