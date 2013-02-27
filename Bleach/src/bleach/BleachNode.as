package bleach
{
	import bleach.protocol.ProtocolObserver;
	
	import pixel.core.PixelNode;

	public class BleachNode extends PixelNode
	{
		
		public function BleachNode()
		{
		}
		
		protected function addNetListener(command:int,callback:Function):void
		{
			ProtocolObserver.instance.addListener(command,callback);
		}
		protected function removeNetListener(command:int,callback:Function):void
		{
			ProtocolObserver.instance.removeListener(command,callback);
		}
	}
}