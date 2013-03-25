package bleach.proxy
{
	import flash.utils.ByteArray;

	public interface IBleachBattleProxy
	{
		function sendProtocol(value:ByteArray):void;
		function addProtocolResponseListener(command:int,callback:Function):void;
		function removeProtocolResponseListener(command:int,callback:Function):void;
	}
}