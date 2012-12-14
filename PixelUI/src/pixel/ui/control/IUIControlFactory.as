package pixel.ui.control
{
	import flash.utils.ByteArray;
	
	import pixel.ui.control.vo.UIControlMod;
	import pixel.ui.control.vo.UIMod;
	import pixel.ui.control.vo.UIStyleMod;

	public interface IUIControlFactory
	{
		//function Encode(Control:IUIControl):ByteArray;
		function encode(mod:UIMod):ByteArray;
		function decode(Data:ByteArray,cache:Boolean = true):UIMod;
		function findControlById(id:String):UIControlMod;
		function get controlIds():Vector.<String>;
	}
}