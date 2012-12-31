package death.def.view
{
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;

	public interface IViewController extends IEventDispatcher
	{
		function addView(view:Sprite):void;
		function removeView(view:Sprite):void;
		function clearViews():void;
		function initWithData(data:Object):void;
	}
}