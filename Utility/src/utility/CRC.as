package utility
{
	import flash.utils.ByteArray;
	public class CRC {
		private var crc32:uint;
		private static  var CRCTable:Array=initCRCTable();
		/** 
		 * @usage 更新指定的字节数组的CRC32
		 * @param buffer：指定的字节数组,arg：arg[0]为offset偏移量，arg[1]为length
		 指定长度
		 * 这里可以只指定一个参数buffer，也可以offset,length都指定
		 * @return void
		 */
		public function update(buffer:ByteArray):void 
		{
			var offset:int= 0;
			var length:int= buffer.length;
			var crc:uint = ~crc32;
			for (var i:int=offset; i < length; i++) {
				crc = CRCTable[(crc ^ buffer[i]) & 0xFF] ^ (crc >>> 8);
			}
			crc32 = ~crc;
		}
		/** 
		 * @usage 
		 * @param 
		 * @return CRC32值
		 */
		public function getValue():uint 
		{
			return crc32 & 0xFFFFFFFF;
		}
		/** 
		 * @usage 将CRC32重置为初始值
		 * @param 
		 * @return void
		 */
		public function reset():void
		{
			crc32 = 0;
		}
		/** 
		 * @usage 初始化 CRC table, 长度为256.
		 * @param crcTable：CRC table
		 * @return 初始化的crcTable,使用标准poly值：0xEDB88320
		 */
		private static function initCRCTable():Array
		{
			var crcTable:Array=new Array(256);
			for (var i:int=0; i < 256; i++) 
			{
				var crc:uint=i;
				for (var j:int=0; j < 8; j++) 
				{
					crc=(crc & 1)?(crc >>> 1) ^ 0xEDB88320:(crc >>> 1);
				}
				crcTable[i]=crc;
			}
			return crcTable;
		}
	}
}