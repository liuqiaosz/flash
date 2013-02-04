package pixel.ui.control.vo
{
	public class ColorFormat
	{
		private var _color:uint = 0;
		public function set color(value:uint):void
		{
			_color = value;
		}
		public function get color():uint
		{
			return _color;
		}
		public var _size:int = 12;
		public function set size(value:int):void
		{
			_size = value;
		}
		public function get size():int
		{
			return _size;
		}
		private var _isLink:Boolean = true;
		public function set isLink(value:Boolean):void
		{
			_isLink = value;
		}
		public function get isLink():Boolean
		{
			return _isLink;
		}
		
		public var _startIndex:int = 0;
		public function set startIndex(value:int):void
		{
			_startIndex = value;
		}
		public function get startIndex():int
		{
			return _startIndex;
		}
		public var _endIndex:int = 0;
		public function set endIndex(value:int):void
		{
			_endIndex = value;
		}
		public function get endIndex():int
		{
			return _endIndex;
		}
		public function ColorFormat()
		{
		}
	}
}