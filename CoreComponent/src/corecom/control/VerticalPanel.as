package corecom.control
{
	public class VerticalPanel extends UIPanel
	{
		public function VerticalPanel(Skin:Class = null)
		{
			super(Skin);
			super.Layout = LayoutConstant.VERTICAL;
		}
		
		/**
		 * 覆写,防止更改布局
		 **/
		override public function set Layout(Value:uint):void
		{
			
		}
	}
}