package
{
	import flash.events.Event;

	public class AccordionItemTitle extends BasicComponent
	{
		public function AccordionItemTitle()
		{
			super();
		}
		
		override protected function updateRender(event:Event):void
		{
			this.graphics.clear();
			this.graphics.beginFill(0xff0000);
			this.graphics.drawRect(0,0,width,height);
			this.graphics.endFill();
		}
	}
}