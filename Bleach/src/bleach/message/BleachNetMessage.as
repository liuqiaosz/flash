package bleach.message
{
	import pixel.message.PixelMessage;

	public class BleachNetMessage extends PixelMessage
	{
		public static const BLEACH_NET_CONNECTED:String = "ChannelConnected";
		public static const BLEACH_NET_CONNECT_ERROR:String = "ChannelError";
		public static const BLEACH_NET_SENDMESSAGE:String = "SyncSceneData";
		public static const BLEACH_NET_RECVMESSAGE:String = "";
		public function BleachNetMessage(type:String)
		{
			super(type);
		}
	}
}