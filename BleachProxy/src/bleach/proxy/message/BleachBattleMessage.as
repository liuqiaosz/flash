package bleach.proxy.message
{
	import bleach.protocol.event.ProtocolMessage;
	
	import pixel.message.PixelMessage;

	public class BleachBattleMessage extends PixelMessage
	{
		public static const BLEACH_BATTLE_SEND:String = ProtocolMessage.BLEACH_NET_SENDMESSAGE;
		
		public function BleachBattleMessage(type:String)
		{
			super(type);
		}
	}
}