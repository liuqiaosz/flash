package death.def.net
{
	import flash.utils.ByteArray;
	
	import pixel.net.PixelNetSocket;

	public class SocketChannel extends PixelNetSocket
	{
		public function SocketChannel()
		{
			super();
		}
		
		/**
		 * 获取数据时的逻辑处理
		 * 
		 * 
		 * 大数据的情况下需要保证数据包的完整性
		 **/
		override protected function validateMessage(buffer:ByteArray):Boolean
		{
			//保存数据包原下标
			var originalPos:int = buffer.position;
			buffer.position = 0;
			var len:int = int(buffer.readUTFBytes(4));
			//恢复位置
			buffer.position = originalPos;
			if(len == buffer.bytesAvailable)
			{
				//数据包完整
				return true;
			}
			return false;
		}
		
		/**
		 * 数据校验通过后由基类数据接收函数调用
		 * 
		 **/
		override protected function dataRecived(data:ByteArray):void
		{
			//进行数据包解析
			var len:int = int(data.readUTFBytes(4));
			var msg:String = data.readUTFBytes(len);
			
		}
	}
}