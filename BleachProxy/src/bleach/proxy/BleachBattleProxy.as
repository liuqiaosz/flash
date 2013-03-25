package bleach.proxy
{
	public class BleachBattleProxy
	{
		private static var _instance:IBleachBattleProxy = null;
		public function BleachBattleProxy()
		{
		}
		
		public static function get instance():IBleachBattleProxy
		{
			if(!_instance)
			{
				_instance = new BleachBattleProxyImpl();
			}
			return _instance;
		}
	}
}
import bleach.protocol.ProtocolObserver;
import bleach.proxy.IBleachBattleProxy;
import bleach.proxy.message.BleachBattleMessage;

import flash.events.EventDispatcher;
import flash.utils.ByteArray;

import pixel.message.PixelMessageBus;

class BleachBattleProxyImpl extends EventDispatcher implements IBleachBattleProxy
{
	public function BleachBattleProxyImpl()
	{}
	
	public function sendProtocol(value:ByteArray):void
	{
		var notify:BleachBattleMessage = new BleachBattleMessage(BleachBattleMessage.BLEACH_BATTLE_SEND);
		notify.value = value;
		PixelMessageBus.instance.dispatchMessage(notify);
	}
	
	public function addProtocolResponseListener(command:int,callback:Function):void
	{
		ProtocolObserver.instance.addListener(command,callback);
	}
	
	public function removeProtocolResponseListener(command:int,callback:Function):void
	{
		ProtocolObserver.instance.removeListener(command,callback);
	}
}
