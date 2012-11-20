package pixel.worker.message
{
	public class PixelWorkerMessage
	{
		public static const LOAD_SWF:int = 1;
		public static const LOAD_PNG:int = 2;
		public static const LOAD_JPG:int = 3;
		public static const LOAD_BIN:int = 4;
		public static const LOAD_PROGRESS:int = 5;
		public static const LOAD_COMPLETE:int = 6;
		public static const LOAD_ERROR:int = 7;
		public static const LOAD_COMPLETE_ALL:int = 8;
		
		public static const HTTP_REQ:int = 9;
		public static const HTTP_RES:int = 10;
		
		private var _type:int = 0;
		public function set type(value:int):void
		{
			_type = value;
		}
		public function get type():int
		{
			return _type;
		}
		private var _message:String = "";
		public function set message(value:String):void
		{
			_message = value;
		}
		public function get message():String
		{
			return _message;
		}
		
		public function PixelWorkerMessage(type:int = 0)
		{
			_type = type;
		}
	}
}