package game.sdk.account
{
	public class GameAccount
	{
		public function GameAccount()
		{
		}
	}
}
import game.sdk.account.IAccount;

class GameAccountImpl implements IAccount
{
	//ID
	public function get Id():String
	{
		return "";
	}
	//名称
	public function get Name():String
	{
		return "";
	}
	//昵称
	public function get NickName():String
	{
		return "";
	}
	//账户类型
	public function get Mode():uint
	{
		return 0;
	}
}