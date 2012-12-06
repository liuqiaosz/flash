package pixel.ui.control
{
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.control.style.UIVerticalPanelStyle;
	import pixel.ui.core.NSPixelUI;

	use namespace NSPixelUI;
	
	public class UIVerticalPanel extends UIContainer
	{
		private var _scroller:UIVerticalScroller = null;
		public function UIVerticalPanel(Skin:Class = null)
		{
			super(Skin?Skin:UIVerticalPanelStyle);
			super.Layout = LayoutConstant.VERTICAL;
			
//			_scroller = new VerticalScroller();
//			_scroller.width = 15;
//			OrignalAddChild(_scroller);
			_scroller = new UIVerticalScroller();
			_scroller.initializer();
			OrignalAddChild(_scroller);
			
			width = 200;
			height = 100;
		}
		
		override public function initializer():void
		{
			
			//_scroller.width = 15;
			
		}
		
		override public function EnableEditMode():void
		{
			super.EnableEditMode();
			//this.mouseChildren = false;
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
		
		public function get scroller():UIVerticalScroller
		{
			return _scroller;
		}
		
		/**
		 * 覆写,防止更改布局
		 **/
		override public function set Layout(Value:uint):void
		{
			
		}
		
		override public function Encode():ByteArray
		{
			return super.Encode();
		}
		
		override protected function SpecialEncode(Data:ByteArray):void
		{
			super.SpecialEncode(Data);
			var data:ByteArray = _scroller.Encode();
			Data.writeBytes(data);
		}
		override protected function SpecialDecode(Data:ByteArray):void
		{
			super.SpecialDecode(Data);
			Data.readByte();
			_scroller.Decode(Data);
			_scroller.refresh();
		}
	}
}