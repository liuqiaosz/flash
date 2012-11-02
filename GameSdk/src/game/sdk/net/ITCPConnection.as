package game.sdk.net
{
	public interface ITCPConnection extends IConnection
	{
		function Connect(Addr:String,Port:int):void;
		
	}
}