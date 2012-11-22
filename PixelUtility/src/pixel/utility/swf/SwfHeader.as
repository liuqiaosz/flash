package pixel.utility.swf
{
	/**
	 * SWF文件头数据
	 **/
	public class SwfHeader
	{
		private var _Sign:String = "";
		public function set Sign(Value:String):void
		{
			_Sign = Value;
		}
		public function get Sign():String
		{
			return _Sign;
		}
		private var _Version:int = 0;
		public function set Version(Value:int):void
		{
			_Version = Value;
		}
		public function get Version():int
		{
			return _Version;
		}
		private var _FileLength:int = 0;
		public function set FileLength(Value:int):void
		{
			_FileLength = Value;
		}
		public function get FileLength():int
		{
			return _FileLength;
		}
		//RECT
		private var _Rect:SwfRect = null;
		public function set Rect(Value:SwfRect):void
		{
			_Rect = Value;
		}
		public function get Rect():SwfRect
		{
			return _Rect;
		}
		
		private var _FrameRate:int = 0;
		public function set FrameRate(Value:int):void
		{
			_FrameRate = Value;
		}
		public function get FrameRate():int
		{
			return _FrameRate;
		}
		private var _FrameCount:int = 0;
		public function set FrameCount(Value:int):void
		{
			_FrameCount = Value;
		}
		public function get FrameCount():int
		{
			return _FrameCount;
		}
		
		public function SwfHeader(Stream:ByteStream = null)
		{
			if(Stream)
			{
				//读取签名
				var Sign:String = Stream.ReadString(3);
				//版本
				var Version:int = Stream.ReadUI8();
				//文件长度
				var TotalLen:int = Stream.ReadUI32();
				switch(Sign)
				{
					case "CWS":
						Stream.Uncompress();
						break;
					case "FWS":
						//数据未压缩
						break;
					default:
						//错误格式
						throw new Error("非法SWF格式数据");
				}
				
				_Sign = Sign;
				_Version = Version;
				_FileLength = TotalLen;
				//var Rect:SwfRect = new SwfRect(Source);
				_Rect = ReadRect(Stream);
				FrameRate = Stream.ReadUI16() / 256;
				FrameCount = Stream.ReadUI16();
			}
		}
		
		public function Encode():ByteStream
		{
			var Stream:ByteStream = new ByteStream();
			Stream.WriteString(_Sign);
			Stream.WriteUI8(_Version);
			Stream.WriteUI32(_FileLength);
			return Stream;
		}
		
		private function ReadRect(Stream:ByteStream):SwfRect
		{
			var nbits:int = Stream.ReadBits(5);
			//Debug.log("nbits=" + nbits);
			var xmin:int = Stream.ReadBits(nbits);
			var xmax:int = Stream.ReadBits(nbits);
			var ymin:int = Stream.ReadBits(nbits);
			var ymax:int = Stream.ReadBits(nbits);
			
			var Rect:SwfRect = new SwfRect();
			Rect.XMin = xmin;
			Rect.XMax = xmax;
			Rect.YMin = ymin;
			Rect.YMax = ymax;
			return Rect;
		}
	}
}