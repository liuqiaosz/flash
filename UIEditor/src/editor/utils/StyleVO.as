package editor.utils
{
	import pixel.ui.control.vo.UIStyleMod;

	public class StyleVO
	{
		private var _nav:String = "";
		private var _mod:UIStyleMod = null;
		
		public function StyleVO(nav:String,mod:UIStyleMod)
		{
			_nav = nav;
			_mod = mod;
		}
		
		public function set nav(value:String):void
		{
			_nav = value;
		}
		public function get nav():String
		{
			return _nav;
		}
		
		public function set mod(value:UIStyleMod):void
		{
			_mod = value;
		}
		public function get mod():UIStyleMod
		{
			return _mod;
		}
	}
}