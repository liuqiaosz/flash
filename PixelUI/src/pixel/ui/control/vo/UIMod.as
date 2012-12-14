package pixel.ui.control.vo
{
	import pixel.ui.control.IUIControl;
	import pixel.ui.control.style.IVisualStyle;

	public class UIMod
	{
		//private var _controls:Vector.<IUIControl> = null;
		//private var _controlIds:Vector.<String> = null;
		private var _styles:Vector.<UIStyleMod> = null;
		private var _controls:Vector.<UIControlMod> = null;
		public function UIMod(controls:Vector.<UIControlMod> = null,styles:Vector.<UIStyleMod> = null)
		{
			_controls = controls;
			if(!_controls)
			{
				_controls = new Vector.<UIControlMod>();
			}
			
			_styles = styles;
			if(!_styles)
			{
				_styles = new Vector.<UIStyleMod>();
			}
		}
		
		public function get controls():Vector.<UIControlMod>
		{
			return _controls;
		}
		public function get styles():Vector.<UIStyleMod>
		{
			return _styles;
		}
	}
}