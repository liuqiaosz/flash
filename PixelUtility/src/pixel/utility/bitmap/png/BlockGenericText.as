package pixel.utility.bitmap.png
{
	import flash.utils.ByteArray;

	public class BlockGenericText
	{
		protected var _Keyword:String = "";
		public function set Keyword(Value:String):void
		{
			_Keyword = Value;
		}
		public function get Keyword():String
		{
			return _Keyword;
		}
		protected var _Separator:int = 0;
		public function set Separator(Value:int):void
		{
			_Separator = Value;
		}
		public function get Separator():int
		{
			return _Separator;
		}
		protected var _TextData:ByteArray = null;
		public function set TextData(Value:ByteArray):void
		{
			_TextData = Value;
		}
		public function get TextData():ByteArray
		{
			return _TextData;
		}
		
		public function get Text():String
		{
			return "";
		}
		
		public function BlockGenericText()
		{
		}
	}
}