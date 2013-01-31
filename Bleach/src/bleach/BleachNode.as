package bleach
{
	import bleach.communicator.NetObserver;
	
	import pixel.core.PixelNode;

	public class BleachNode extends PixelNode
	{
		
		public function BleachNode()
		{
		}
		
		protected function addNetListener(command:int,callback:Function):void
		{
			NetObserver.instance.addListener(command,callback);
		}
		protected function removeNetListener(command:int,callback:Function):void
		{
			NetObserver.instance.removeListener(command,callback);
		}
	}
}