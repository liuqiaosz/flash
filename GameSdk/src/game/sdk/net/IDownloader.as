package game.sdk.net
{
	public interface IDownloader extends IConnection
	{
		function Download(Url:String):void;
	}
}