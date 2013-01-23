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
			this.BackgroundAlpha = 0;
			super.Layout = LayoutConstant.HORIZONTAL;
			_btn = new UICheckButton();
			_btn.width = 15;
			_btn.height = 15;
			addChild(_btn);
			super.Gap = 3;
			_label = new UITextBase();
			addChild(_label);
			
			this.width = 50;
			this.height = 17;
			_label.text = "记住账号";
		}
		
		override public function EnableEditMode():void
		{
			_btn.mouseEnabled = _btn.mouseChildren = false;
			
			_label.mouseEnabled = _label.mouseChildren = false;
			super.EnableEditMode();
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