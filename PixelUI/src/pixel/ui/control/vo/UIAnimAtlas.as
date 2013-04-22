package pixel.ui.control.vo
{
	/**
	 * UI动画序列VO对象
	 * 
	 * 
	 **/
	public class UIAnimAtlas
	{
		private var _name:String = "";
		public function set name(value:String):void
		{
			_name = value;
		}
		public function get name():String
		{
			return _name;
		}
		private var _playGap:int = 500;
		private var _frames:Vector.<UIAnimFrame> = null;
		
		public function UIAnimAtlas()
		{
		}
	}
}