package utility.swf
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class ByteStream
	{
		private var Data:ByteArray = new ByteArray();
		public function ByteStream(Source:ByteArray = null,Mode:uint = 0)
		{
			super();
			if(Source)
			{
				Data.writeBytes(Source,0,Source.length);
				Data.position = 0;
				_cacheByteUsedBits = 8;
			}
			
			if(Mode == 0)
			{
				Data.endian = Endian.LITTLE_ENDIAN;
			}
		}
		
		public function set Endian(Value:String):void
		{
			Data.endian = Value;
		}
		
		public function get Bytes():ByteArray
		{
			return Data;
		}
		
		public function Uncompress():void
		{
			var Pos:int = Data.position;
			
			var UnzipData:ByteArray = new ByteArray();
			Data.readBytes(UnzipData);
			UnzipData.uncompress();
			
			Data.position = Pos;
			Data.writeBytes(UnzipData);
			Data.position = Pos;
		}
		
		public function Inflate():void
		{
			var Pos:int = Data.position;
			Data.inflate();
			Data.position = Pos;
		}
		
		public function Compress():void
		{
			var Pos:int = Data.position;
			var zipData:ByteArray = new ByteArray();
			Data.readBytes(zipData);
			zipData.compress();
			Data.position = Pos;
			Data.writeBytes(zipData);
			Data.position = Pos;
		}
		
		public function set Position(Value:int):void
		{
			Data.position = Value;
		}
		public function get Position():int
		{
			return Data.position;
		}
		public function get Length():int
		{
			return Data.length;
		}
		
		public function get Available():int
		{
			return Data.bytesAvailable;
		}
		
		public function ReadI8():int
		{
			return Data.readByte();
		}
		public function ReadUI8():int
		{
			return Data.readUnsignedByte();
		}
		public function WriteUI8(Value:int):void
		{
			Data.writeByte(Value);
		}
		public function ReadUI16():int
		{
			return Data.readUnsignedShort();
		}
		public function ReadI16():int
		{
			return Data.readShort();
		}
		public function WriteUI16(Value:int):void
		{
			Data.writeShort(Value);
		}
		public function WriteBytes(Source:ByteStream):void
		{
			Data.writeBytes(Source.Bytes,0,Source.Length);
		}
		public function ReadUI32():uint
		{
			return Data.readUnsignedInt();
		}
		public function ReadI32():int
		{
			return Data.readInt();
		}
			
		public function WriteUI32(Value:int):void
		{
			return Data.writeInt(Value);
		}
		public function ReadString(Length:int = 0):String
		{
			if(Length == 0)
			{
				return Data.readUTFBytes(Data.bytesAvailable);
			}
			else
			{
				return Data.readUTFBytes(Length);
			}
		}
		
		public function WriteString(Value:String):void
		{
			Data.writeUTFBytes(Value);
		}
		public function FindString():String
		{
			var Pos:int = Data.position;
			
			var Len:int = 0;
			var Value:int = 0;
			while(Data.position <Data.length)
			{
				Value = Data.readByte();
				Len++;
				if(Value == 0)
				{
					break;
				}
			}
			
			if(Len > 0)
			{
				Data.position = Pos;
				var Result:String = Data.readUTFBytes(Len);
				//Data.readByte();//跳过空格
				return Result;
			}
			return "";
		}
		public function ReadBytes(Lenght:int = 0):ByteStream
		{
			var Bytes:ByteArray = new ByteArray();
			if(Lenght == 0)
			{
				Data.readBytes(Bytes);
			}
			else
			{
				Data.readBytes(Bytes,0,Lenght);
			}
			return new ByteStream(Bytes);
		}
		
		/*读取BIT位部分.原理不太清楚,暂时先借用代码*/
		private var _cacheByte:int;
		private var _cacheByteUsedBits:int;
		public function ReadBits(nbits:int):int
		{
			//private var _cacheByte:int;
			//private var _cacheByteUsedBits:int;
			
			//read from pre bits
			var readingBits:Array = new Array();
			//int real_use = 0;
			var nbits_left:int = nbits;
			
			var i:int;
			var j:int;
			var k:int;
			var mask:int;
			var bytes_tmp:Array ;
			
			if (_cacheByteUsedBits < 8) {
				var nbits_cache_left :int  = 8 - _cacheByteUsedBits;
				var should_read:int = nbits_left;
				if (should_read > nbits_cache_left) {
					should_read = nbits_cache_left;
				}
				var bit_start :int = _cacheByteUsedBits;
				for (i=0;i<should_read;i++){
					mask = GetMask(bit_start+i);
					
					readingBits.push( _cacheByte & mask ? 1: 0);
				}
				_cacheByteUsedBits += should_read;
				nbits_left -= should_read;
			}
			
			//read from bytes
			var bytes:int = int(nbits_left / 8);
			if (bytes) 
			{
				bytes_tmp = new Array();
				for ( j=0;j<bytes;j++) 
				{
					var b:int = Data.readByte();
					bytes_tmp.push(b);
				}
				
				for ( i=0;i<bytes;i++)
				{
					for ( j=0;j<8;j++) 
					{
						mask = GetMask(j);
						readingBits.push( bytes_tmp[i] & mask ? 1: 0);
					}
				}
				nbits_left -= bytes*8;
			}
			
			if (nbits_left) {
				bytes_tmp = new Array();			
				bytes_tmp.push(Data.readByte());
				
				_cacheByteUsedBits= 0;
				_cacheByte = bytes_tmp[0];
				
				for ( j=0;j<nbits_left;j++) {
					mask = GetMask(j);
					readingBits.push( _cacheByte & mask ? 1: 0);
					_cacheByteUsedBits++;
				}
				nbits_left = 0;
			}
			//finish
			var result:int = 0;
			for ( i=nbits-1;i>=0;i--)
			{
				if (readingBits[i])
				{
					//1
					result |= GetShortMask(15 - (nbits -1 -i));
				}
				else 
				{
					//0
				}
			}
			
			return result;	
		}
		
		private function GetMask(bit_start:int):int
		{
			var mask:int = 0;
			if (bit_start == 0) {
				mask = 0x80;
			} else if (bit_start == 1) {
				mask = 0x40;
			}else if (bit_start == 2) {
				mask = 0x20;
			}else if (bit_start == 3) {
				mask = 0x10;
			}else if (bit_start == 4) {
				mask = 0x08;
			}else if (bit_start == 5) {
				mask = 0x04;
			}else if (bit_start == 6) {
				mask = 0x02;
			}else if (bit_start == 7) {
				mask = 0x01;
			}
			return mask;
		} 
		
		private function GetShortMask(bit_start:int):int 
		{
			var mask:int = 0;	
			if (bit_start == 0) {
				mask = 0x8000;
			} else if (bit_start == 1) {
				mask = 0x4000;
			}else if (bit_start == 2) {
				mask = 0x2000;
			}else if (bit_start == 3) {
				mask = 0x1000;
			}else if (bit_start == 4) {
				mask = 0x0800;
			}else if (bit_start == 5) {
				mask = 0x0400;
			}else if (bit_start == 6) {
				mask = 0x0200;
			}else if (bit_start == 7) {
				mask = 0x0100;
			} else if (bit_start == 8) {
				mask = 0x0080;
			} else if (bit_start == 9) {
				mask = 0x0040;
			}else if (bit_start == 10) {
				mask = 0x0020;
			}else if (bit_start == 11) {
				mask = 0x0010;
			}else if (bit_start == 12) {
				mask = 0x0008;
			}else if (bit_start == 13) {
				mask = 0x0004;
			}else if (bit_start == 14) {
				mask = 0x0002;
			}else if (bit_start == 15) {
				mask = 0x0001;
			}
			return mask;
		}
	}
}