package pixel.ui.control.style
{
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.vo.UIStyleGroup;
	import pixel.ui.control.vo.UIStyleMod;

	public interface IUIStyleFactory extends IEventDispatcher
	{
		function encode(styles:Vector.<UIStyleMod>):ByteArray;
		function decode(data:ByteArray):Vector.<UIStyleMod>;
		function groupEncode(group:UIStyleGroup):ByteArray;
		function groupDecode(data:ByteArray):UIStyleGroup;
	}
}