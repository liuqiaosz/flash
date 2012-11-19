package pixel.ui.control
{
	import pixel.ui.control.style.ScrollerStyle;
	
	import flash.events.Event;

	/**
	 * 滑动条
	 * 
	 **/
	internal class Scroller extends Container
	{
		public static const HANDLER_MINMIZE:int = 40;
		public function Scroller(Skin:Class)
		{
			var StyleSkin:Class = Skin ? Skin:ScrollerStyle;
			super(StyleSkin);
		}
		
		override protected function OnAdded(event:Event):void
		{
			super.OnAdded(event);
			Initialize();
		}
		
		/**
		 * 初始化
		 * 
		 * 
		 **/
		protected function Initialize():void
		{
			
		}
	}
}
