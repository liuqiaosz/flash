package death.def.module
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class GenericModule extends Sprite
	{
		public function GenericModule()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		private function onAdded(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			initializer();
		}
		
		protected function initializer():void
		{}
	}
}