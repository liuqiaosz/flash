package editor.utils
{
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.control.vo.UIStyleMod;

	public class StyleGlobals
	{
		private static var _cache:Vector.<UIStyleMod> = new Vector.<UIStyleMod>();
		public function StyleGlobals()
		{
			
		}
		
		public static function clear():void
		{
			_cache.length = 0;
		}
		
		public static function get styles():Vector.<UIStyleMod>
		{
			return _cache;
		}
		
		public static function set styles(value:Vector.<UIStyleMod>):void
		{
			_cache = value;
		}
		public static function addStyle(value:UIStyleMod):void
		{
			_cache.push(value);
		}
	}
}