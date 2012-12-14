package pixel.ui.control.style
{
	import pixel.ui.control.vo.UIStyleGroup;
	import pixel.ui.control.vo.UIStyleMod;

	public interface IUIStyleManager
	{
		function download(url:String):void;
		function downloadQueue(queue:Vector.<String>):void;
		function findStyleById(id:String):UIStyleMod;
		function addStyle(style:UIStyleGroup):void;
		function clearCache():void;
		function get styles():Vector.<UIStyleGroup>;
	}
}