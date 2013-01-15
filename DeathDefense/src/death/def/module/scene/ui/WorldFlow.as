package death.def.module.scene.ui
{
	import com.greensock.TweenMax;
	
	import death.def.event.BleachDefenseEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import pixel.core.PixelNode;
	import pixel.core.PixelSprite;
	import pixel.ui.control.LayoutConstant;
	import pixel.ui.control.UIContainer;
	import pixel.ui.control.UIPanel;

	public class WorldFlow extends PixelSprite
	{
		private var _content:UIContainer = new UIContainer();
		
		public function set padding(value:int):void
		{
			_content.x = _content.y = value;
		}
		
		private var _nodeW:int = 0;
		private var _nodeH:int = 0;
		private var _nodeGap:int = 0;
		
		public function WorldFlow(sizeW:int,sizeH:int,nodeW:int,nodeH:int)
		{
			super();
			_content.Layout = LayoutConstant.HORIZONTAL;
			super.addChild(_content);
			_scrollWidth = sizeW;
			_scrollHeight = sizeH;
			_nodeW = nodeW;
			_nodeH = nodeH;
			_content.Gap = _nodeGap = (sizeW - (nodeW + (nodeW / 3 * 2))) * 0.5;
			_currentX = _content.x = int(_nodeGap + nodeW / 3);
			updateScrollRect();
		}
		private var _scrollSeek:int = 0;
		private var _nodeCount:int = 0;
		override public function addChild(child:DisplayObject):DisplayObject
		{
			_content.addChild(child);
			_nodeCount++;
			return child;
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
		public function scrollLeft():void
		{
			if(_scrollSeek + 1 < _nodeCount)
			{
				_currentX = _currentX - (_nodeW + _nodeGap);
				TweenMax.to(_content,_duration,{x : _currentX});
				_scrollSeek++;
				selectedNotify();
			}
		}
		
		private var _currentX:Number = 0;
		/**
		 * 向右滑动
		 **/
		public function scrollRight():void
		{
			if(_scrollSeek > 0)
			{
				_currentX = _currentX + (_nodeW + _nodeGap);
				TweenMax.to(_content,_duration,{x : _currentX});
				_scrollSeek--;
				selectedNotify();
			}
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
		
		private function selectedNotify():void
		{
			var notify:BleachDefenseEvent = new BleachDefenseEvent(BleachDefenseEvent.BLEACH_FLOW_SELECTED);
			notify.value = _content.Children[_scrollSeek];
			dispatchEvent(notify);
		}
		
		public function get currentItem():WorldFlowItem
		{
			return _content.Children[_scrollSeek] as WorldFlowItem;
			
		}
	}
}