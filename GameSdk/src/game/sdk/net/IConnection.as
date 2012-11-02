package game.sdk.net
{
	import flash.events.IEventDispatcher;

	public interface IConnection extends IEventDispatcher
	{
		
		function Close():void;
		function Request(Attr:IAttribute = null):void;
	}
}