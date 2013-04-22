package
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class VerticalAccordion extends BasicComponent
	{
		private var _activeItemHeight:int = 0;
		private var _titleTotalHeight:int = 0;
		private var _activeItem:AccordionItem = null;
		private var _items:Vector.<AccordionItem> = null;
		public function VerticalAccordion()
		{
			super();
			_items = new Vector.<AccordionItem>();
		}
		
		public function addItem(value:AccordionItem):void
		{
			_items.push(value);
			if(_items.length == 0)
			{
				_activeItem = value;
			}
			_items.push(_activeItem);
		}
		
		/**
		 * 更新布局
		 **/
		private function updateLayout():void
		{
			var posY:int = 0;
			var item:AccordionItem = null;
			_titleTotalHeight = 0;
			//计算Title所有高度
			for each(item in _items)
			{
				_titleTotalHeight += item.titleHeight;
				item.y = posY;
				posY += (item == _activeItem ? item.height:item.titleHeight);
			}
			
			//计算激活item的最大高度
			_activeItemHeight = height - _titleTotalHeight;
			for each(item in _items)
			{
				
			}
		}
	}
}