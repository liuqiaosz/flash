package pixel.ui.control
{
	import flash.display.DisplayObject;
	
	import pixel.ui.control.event.UIControlEvent;
	import pixel.ui.control.style.UIRadioGroupStyle;

	/**
	 * Radio群组
	 * 
	 * 
	 **/
	public class UIRadioGroup extends UIContainer
	{
		private var _selected:UIRadio = null;
		public function UIRadioGroup(skin:Class = null)
		{
			super(skin ? skin : UIRadioGroupStyle);
			//默认横向布局
			this.Layout = UILayoutConstant.HORIZONTAL;
			width = 100;
			height = 30;
			addEventListener(UIControlEvent.SELECTED,onChildRadioChanged);
		}
		
		override public function initializer():void
		{
			super.initializer();	
		}
		
		public function set selectedIndex(idx:int):void
		{
			var select:UIRadio = this._Children[idx] as UIRadio;
			if(_selected)
			{
				_selected.selected = false;
			}
			_selected = select;
		}
		
		public function get selected():UIRadio
		{
			return _selected;
		}
		
		override public function dispose():void
		{
			super.dispose();
			removeEventListener(UIControlEvent.SELECTED,onChildRadioChanged);
		}
		
		override public function EnableEditMode():void
		{
			super.EnableEditMode();
		}
		
		protected function onChildRadioChanged(event:UIControlEvent):void
		{
			if(_selected)
			{
				_selected.selected = false;
			}
			_selected = event.target as UIRadio;
		}
		
		/**
		 * 只接受UIRadio
		 **/
		override public function OnDrop(Control:UIControl):void
		{
			if(Control is UIRadio)
			{
				super.OnDrop(Control);
			}
		}
		
		/**
		 * 重写添加子对象方法，确保添加的子对象只能是UIRadio
		 **/
		override public function addChild(Child:DisplayObject):DisplayObject
		{
			if(Child is UIRadio)
			{
				return super.addChild(Child);
			}
			return null;
		}
	}
}