package im.jpg
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class JpegExifDecoder
	{
		public static const SOI:int = 0xFFD8;
		public static const APP1:int = 0xFFE1;
		
		public function JpegExifDecoder()
		{
					
		}
		
		public function decode(data:ByteArray):JpegExif
		{
			var len:int = 0;
			
			data.endian = Endian.BIG_ENDIAN;
			var flag:int = data.readUnsignedShort();
			if(flag != SOI)
			{
				return null;
			}
			while(data.bytesAvailable > 0)
			{
				flag = data.readUnsignedShort();
				
				len = data.readShort() - 2;
				data.endian = Endian.LITTLE_ENDIAN;
				if(flag != APP1)
				{
					data.position += len;
					continue;
				}
				
				//跳过Exif字符和2个字节的0x00
				data.position += 6;
				
				new JpegTIFF(data);
			}
			return null;
		}
		
		
	}
}