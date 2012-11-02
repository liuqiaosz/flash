package game.sdk.account
{
	public interface IAccount
	{
		//ID
		function get Id():String;
		//名称
		function get Name():String;
		//昵称
		function get NickName():String;
		//账户类型
		function get Mode():uint;
	}
}