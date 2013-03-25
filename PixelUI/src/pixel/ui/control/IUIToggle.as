package pixel.ui.control
{
	import flash.events.IEventDispatcher;

	public interface IUIToggle extends IEventDispatcher
	{
		function set selected(value:Boolean):void;
		function get selected():Boolean;
		function get value():String;
	}
}