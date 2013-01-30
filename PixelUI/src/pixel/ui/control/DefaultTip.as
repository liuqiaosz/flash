package pixel.ui.control
{
	public class DefaultTip extends UIContainer implements IPixelTip
	{
		private var _Label:UILabel = null;
		public function DefaultTip()
		{
			super();
			_Label = new UILabel();
			_Label.Align = TextAlign.LEFT;
			_Label.Mutiline = true;
			addChild(_Label);
			this.Style.BackgroundColor = 0xFFCC33;
		}
		
		public function set tipText(value:String):void
		{
			_Label.text = value;
			//width = _Label.TextWidth + 5;
			//height = _Label.TextHeight + 5;
			width = 200;
			height = 200;
		}
	}
}