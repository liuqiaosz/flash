package pixel.ui.control.vo
{
	import pixel.ui.control.IUIControl;
	import pixel.ui.control.style.IVisualStyle;

	public class UIMod
	{
		private var _controls:Vector.<IUIControl> = null;
		private var _styles:Vector.<UIStyleMod> = null;
		public function UIMod(controls:Vector.<IUIControl> = null,styles:Vector.<UIStyleMod> = null)
		{
			_controls = controls;
			if(!_controls)
			{
				_controls = new Vector.<IUIControl>();
			}
			
			_styles = styles;
			if(!_styles)
			{
				_styles = new Vector.<UIStyleMod>();
			}
		}
		
		public function get controls():Vector.<IUIControl>
		{
			return _controls;
		}
		
		public function get styles():Vector.<UIStyleMod>
		{
			return _styles;
		}
	}
}