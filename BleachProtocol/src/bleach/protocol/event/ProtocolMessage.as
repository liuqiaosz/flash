package bleach.protocol.event
{
	import pixel.message.PixelMessage;

	public class ProtocolMessage extends PixelMessage
	{
		public static const BLEACH_NET_SENDMESSAGE:String = "SendMessage";
		public static const BLEACH_NET_SENDSTREAM:String = "SendStream";
		public static const BLEACH_NET_RECVSTREAM:String = "RecvStream";
		public static const BLEACH_NET_RECVMESSAGE:String = "ReciveMessage";
		
		public function ProtocolMessage(type:String)
		{
			super(type);
		}
	}
}