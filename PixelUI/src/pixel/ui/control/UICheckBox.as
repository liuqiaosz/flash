package pixel.ui.control
{
	public class UICheckBox extends UIContainer
	{
		private var _btn:UICheckButton = null;
		private var _label:UITextBase = null;
		
		public function UICheckBox()
		{
			super();
			this.BorderThinkness = 0;
			super.Layout = LayoutConstant.HORIZONTAL;
			_btn = new UICheckButton();
			addChild(_btn);
			super.Gap = 3;
			_label = new UITextBase();
			addChild(_label);
			
			this.width = 60;
			this.height = 14;
			
			_btn.width = 14;
			_btn.height = 14;
		}
		
		public function set label(value:String):void
		{
			_label.text = value;
		}
		public function get label():String
		{
			return _label.text;
		}
		
		public function get selected():Boolean
		{
			return _btn.selected;
		}
		
		override public function set Layout(Value:uint):void
		{
		}
	}
}