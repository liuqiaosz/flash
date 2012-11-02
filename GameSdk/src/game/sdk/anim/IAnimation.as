package game.sdk.anim
{
	import flash.events.IEventDispatcher;

	/**
	 * UI库动画接口
	 **/
	public interface IAnimation extends IEventDispatcher
	{
		function start():void;
		function restore():void;
	}
}