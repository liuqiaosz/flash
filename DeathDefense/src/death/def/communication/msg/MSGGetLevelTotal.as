package death.def.communication.msg
{
	import flash.utils.ByteArray;
	
	import pixel.net.msg.tcp.IPixelTCPMessage;
	import pixel.net.msg.tcp.PixelTCPMessage;

	public class MSGGetLevelTotal extends PixelTCPMessage implements IPixelTCPMessage
	{
		private var _levelCount:int = 0;
		public function MSGGetLevelTotal(id:int)
		{
		}
		
		override public function decode(data:ByteArray):void
		{
			_levelCount = data.readByte();
		}
		
		override public function encode():ByteArray
		{
			var data:ByteArray = new ByteArray();
			data.writeByte(_levelCount);
		}
	}
}