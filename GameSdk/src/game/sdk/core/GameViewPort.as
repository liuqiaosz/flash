package game.sdk.core
{
	public class GameViewPort
	{
		public function GameViewPort()
		{
		}
	}
}
import game.sdk.core.IViewPort;

class GameViewPortImpl implements IViewPort
{
	public function get StageWidth():uint
	{
		return 0;
	}
	public function get StageHeight():uint
	{
		return 0;
	}
	public function get ViewPortWidth():uint
	{
		return 0;
	}
	public function get ViewPortHeight():uint
	{
		return 0;
	}
}