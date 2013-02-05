package editor.ui
{
	import pixel.ui.control.vo.ColorFormat;
	import pixel.utility.Tools;

	public class ColorfulFormatDataGridItem extends ColorFormat
	{
		private var _selectText:String = "";
		public function set selectText(value:String):void
		{
			_selectText = value;
		}
		public function get selectText():String
		{
			return _selectText;
		}
		
		public function get colorBase():String
		{
			return Tools.Color2Hex(color);
		}
		public function ColorfulFormatDataGridItem()
		{
		}
	}
}