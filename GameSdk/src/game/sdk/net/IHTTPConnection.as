package game.sdk.net
{
	import flash.utils.Dictionary;

	/**
	 * HTTP接口
	 **/
	public interface IHTTPConnection extends IConnection
	{
		//function set Method(Value:String):void;
		//function get Method():String;
		function Connect(Url:String):void;
		function set Format(Value:String):void;
		function set URL(Value:String):void;
		function get URL():String;
	}
}