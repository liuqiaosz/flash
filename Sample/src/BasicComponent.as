package
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class BasicComponent extends Sprite
	{
		private var _rerender:Boolean = false;
		public function BasicComponent()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		private function onAdded(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			this.addEventListener(Event.RENDER,updateRender);
			if(_rerender)
			{
				stage.invalidate();
			}
		}
		
		private var _componentWidth:int = 0;
		private var _componentHeight:int = 0;
		override public function set width(value:Number):void
		{
			//super.width = value;
			_componentWidth = value;
			update();
		}
		override public function get width():Number
		{
			return _componentWidth;
		}
		override public function set height(value:Number):void
		{
			//super.height = value;
			_componentHeight = value;
			update();
		}
		override public function get height():Number
		{
			return _componentHeight;
		}
		
		private function update():void
		{
			_rerender = true;
			if(stage)
			{
				stage.invalidate();
			}
		}
		
		/**
		 * 渲染重绘
		 * 
		 **/
		protected function updateRender(event:Event):void
		{
			_rerender = false;
		}
		
	}
}