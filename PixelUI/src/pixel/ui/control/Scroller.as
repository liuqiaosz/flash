package pixel.ui.control
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import pixel.ui.control.style.IStyle;
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.control.style.ScrollerStyle;
	import pixel.ui.control.style.UIScrollerStyle;
	import pixel.ui.core.PixelUINS;

	use namespace PixelUINS;
	
	/**
	 * 滑动条
	 * 
	 **/
	internal class Scroller extends UIContainer
	{
		public static const HANDLER_MINMIZE:int = 40;
		//当前控制的容器
//		protected var _container:Container = null;
		protected var _Handler:ScrollHandler = null;
		public function Scroller(Skin:Class)
		{
			var StyleSkin:Class = Skin ? Skin:ScrollerStyle;
			super(StyleSkin);
			
			_Handler = new ScrollHandler();
			OrignalAddChild(_Handler);
		}
		
		override protected function OnAdded(event:Event):void
		{
			super.OnAdded(event);
			Initialize();
		}
		
		override public function set Style(value:IVisualStyle):void
		{
			super.Style = value;
			//_Handler.Style = UIScrollerStyle(value).handlerStyle;
		}
		
//		override public function addChild(Child:DisplayObject):DisplayObject
//		{
//			if(!Child is Container)
//			{
//				return null;
//			}
//			if(Child && contains(Child))
//			{
//				removeChild(Child);
//			}
//			addChild(Child);
//			width = Child.width;
//			height = Child.height;
//			
//			_container = Child as Container;
//			return Child;
//		}
//		override public function addChildAt(Child:DisplayObject, Index:int):DisplayObject
//		{
//			return addChild(Child);
//		}
		
		/**
		 * 初始化
		 * 
		 * 
		 **/
		protected function Initialize():void
		{
			
		}
		
		PixelUINS function refresh():void
		{
		}
	}
}
