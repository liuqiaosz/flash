package pixel.ui.control
{
	import flash.display.DisplayObject;
	
	import pixel.ui.control.event.UIControlEvent;
	
	public class UIToggleGroup extends UIContainer
	{
		private var _selected:IUIToggle = null;
		public function UIToggleGroup()
		{
			super();
			//默认横向布局
			this.Layout = UILayoutConstant.HORIZONTAL;
			width = 100;
			height = 30;
			addEventListener(UIControlEvent.SELECTED,onChildToggleChanged);
		}
		
		public function set selectedIndex(idx:int):void
		{
			var select:IUIToggle = this._Children[idx] as IUIToggle;
			select.selected = true;
		}
		
		public function get selected():IUIToggle
		{
			return _selected;
		}
		
		override public function dispose():void
		{
			super.dispose();
			removeEventListener(UIControlEvent.SELECTED,onChildToggleChanged);
		}
		
		override public function EnableEditMode():void
		{
			super.EnableEditMode();
		}
		
		protected function onChildToggleChanged(event:UIControlEvent):void
		{
			if(_selected)
			{
				_selected.selected = false;
			}
			_selected = event.target as IUIToggle;
		}
		
		/**
		 **/
		override public function OnDrop(Control:UIControl):void
		{
			if(Control is IUIToggle)
			{
				super.OnDrop(Control);
			}
		}
		
		/**
		 * 重写添加子对象方法，确保添加的子对象只能是UIRadio
		 **/
		override public function addChild(Child:DisplayObject):DisplayObject
		{
			if(Child is IUIToggle)
			{
				return super.addChild(Child);
			}
			return null;
		}
	}
}