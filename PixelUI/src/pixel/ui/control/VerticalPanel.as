package pixel.ui.control
{
	import flash.display.DisplayObject;
	
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.core.NSPixelUI;

	use namespace NSPixelUI;
	
	public class VerticalPanel extends UIPanel
	{
		private var _scroller:VerticalScroller = null;
		public function VerticalPanel(Skin:Class = null)
		{
			super(Skin);
			super.Layout = LayoutConstant.VERTICAL;
			
			_scroller = new VerticalScroller();
			_scroller.width = 15;
			OrignalAddChild(_scroller);
		}
		
		/**
		 * 覆写
		 * 变更大小的同时刷新滚动条
		 * 
		 */
		override public function set width(value:Number):void
		{
			super.width = value;
			_scroller.refresh();
		}
		/**
		 * 覆写
		 * 变更大小的同时刷新滚动条
		 * 
		 */
		override public function set height(value:Number):void
		{
			super.height = value;
			_scroller.refresh();
		}
		
		override public function addChild(Child:DisplayObject):DisplayObject
		{
			super.addChild(Child);
			_scroller.refresh();
			return Child;
		}
		
		/**
		 * 覆写,防止更改布局
		 **/
		override public function set Layout(Value:uint):void
		{
			
		}
		
		/**
		 * 变更滚动条样式
		 * 
		 * 
		 */
		public function changeScrollStyle(style:IVisualStyle):void
		{
			_scroller.Style = style;
		}
	}
}