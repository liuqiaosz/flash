package
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;

	public class AccordionItem extends BasicComponent
	{
		private var _minHeight:int = 0;
		private var _title:BasicComponent = null;
		private var _contentPanel:AccordionItemPanel = null;
		public function AccordionItem(titleClass:Class = null)
		{
			_title = new titleClass() as BasicComponent;
			_title.x = 0;
			_title.y = 0;
			_minHeight = _title.height;
			addChild(_title);
			_contentPanel = new AccordionItemPanel();
			_contentPanel.y = _minHeight;
			addChild(_contentPanel);
		}
		
		public function set titleHeight(value:int):void
		{
			_minHeight = _title.height = value;
			_contentPanel.height = height - _minHeight;
			_contentPanel.y = _minHeight;
		}
		public function get titleHeight():int
		{
			return _minHeight;
		}
		override public function set width(value:Number):void
		{
			super.width = value;
			
			_contentPanel.width = width;
			_title.width = width;
		}
		override public function set height(value:Number):void
		{
			super.height = value;
			_contentPanel.height = value - _title.height;
		}
		
		override protected function updateRender(event:Event):void
		{
			this.graphics.clear();
			this.graphics.drawRect(0,0,width,height);
		}
		
		public function colspanByTween():void
		{
			TweenLite.to(_contentPanel,.5,{height:0});
		}
		
		public function colspan():void
		{
			_contentPanel.height = 0;
		}
	}
}
import flash.display.Sprite;
import flash.events.Event;

class AccordionItemPanel extends BasicComponent
{
	private var _rerender:Boolean = false;
	public function AccordionItemPanel()
	{
		super();
	}
	
	override protected function updateRender(event:Event):void
	{
		this.graphics.clear();
		this.graphics.beginFill(0x00ff00);
		this.graphics.drawRect(0,0,width,height);
		this.graphics.endFill();
	}
}