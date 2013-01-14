package death.def.module.scene.ui
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import pixel.ui.control.UIPanel;

	public class ShowcaseFlow extends Sprite
	{
		private var _padding:int = 0;
		public function set padding(value:int):void
		{
			_padding = value;
			_content.x = _content.y = value;
		}
		public function get padding():int
		{
			return _padding;
		}
			
		private var _content:UIPanel = null;
		public function ShowcaseFlow(sizeW:int,sizeH:int)
		{
			super();
			_content = new UIPanel();
			addChild(_content);
			_scrollWidth = sizeW;
			_scrollHeight = sizeH;
			updateScrollRect();
		}
		
		private var _scrollWidth:Number = 0;
		private var _scrollHeight:Number = 0;
		override public function set width(value:Number):void
		{
			super.width = value;
			_scrollWidth = value;
			updateScrollRect();
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			_scrollHeight = value;
			updateScrollRect();
		}
		private var _duration:Number = 1;
		private function updateScrollRect():void
		{
			this.scrollRect = new Rectangle(0,0,_scrollWidth,_scrollHeight);
		}
		
		/**
		 * 向左滑动
		 **/
		public function scrollLeft(offset:Number):void
		{
			var target:Number = _content.x - offset;
			TweenMax.to(_content,_duration,{x : target});
		}
		
		/**
		 * 向右滑动
		 **/
		public function scrollRight(offset:Number):void
		{
			var target:Number = _content.x + offset;
			TweenMax.to(_content,_duration,{x : target});
		}
		
		public function scrollTop(offset:Number):void
		{
			var target:Number = _content.y - offset;
			TweenMax.to(_content,_duration,{y : target});
		}
		
		public function scrollBottom(offset:Number):void
		{
			var target:Number = _content.y + offset;
			TweenMax.to(_content,_duration,{y : target});
		}
	}
}