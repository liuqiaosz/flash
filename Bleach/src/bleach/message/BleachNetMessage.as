package bleach.message
{
	import pixel.message.PixelMessage;

	public class BleachNetMessage extends PixelMessage
	{
		public static const BLEACH_NET_CONNECTED:String = "ChannelConnected";
		public static const BLEACH_NET_CONNECT_ERROR:String = "ChannelError";
		public static const BLEACH_NET_SECURIRY_ERROR:String = "ChannelSecurityError";
		public static const BLEACH_NET_SENDMESSAGE:String = "SendMessage";
		public static const BLEACH_NET_RECVMESSAGE:String = "ReciveMessage";
		//重新链接
		public static const BLEACH_NET_RECONNECT:String = "ChannelReconnect";
		//链接断开
		public static const BLEACH_NET_DISCONNECT:String = "ChannelDisconnect";
		public function BleachNetMessage(type:String)
		{
			super(type);
		}
	}
}