package corecom.control
{

	import corecom.control.Tab;
	import corecom.control.UIControl;
	import corecom.control.event.UIControlEvent;
	import corecom.control.style.ContainerStyle;
	import corecom.control.style.UIStyle;
	
	import flash.display.DisplayObject;
	
	/**
	 * 标签栏
	 **/
	public class TabBar extends UIPanel
	{
//		private var _TabChildren:Array = [];
		
//		private var _Owner:SimpleTabPanel = null;
//		public function set Owner(Value:SimpleTabPanel):void
//		{
//			_Owner = Value;
//		}
//		public function get Owner():SimpleTabPanel
//		{
//			return _Owner;
//		}
		public function TabBar(Skin:Class = null)
		{
			super(Skin ? Skin:TabBarSkin);
			this.Layout = LayoutConstant.HORIZONTAL;
			height = 30;
			//生成默认标签
			//		var DefaultTab:Tab = new Tab();
			//		DefaultTab.width = 30;
			//		DefaultTab.height = height;
			//		_TabChildren.push(DefaultTab);
			//		addChild(DefaultTab);
			addEventListener(UIControlEvent.STYLE_UPDATE,OnChildStyleUpdate);
		}
		
		private function OnChildStyleUpdate(event:UIControlEvent):void
		{
			event.stopPropagation();
			UpdateLayout();
			//var Notify:UIControlEvent = new UIControlEvent(UIControlEvent.STYLE_UPDATE,false);
			//dispatchEvent(Notify);
		}
		
		public function get TabChildren():Array
		{
			//return _TabChildren;
			return Children;
		}
		
		public function CreateTab():Tab
		{
			var ChildTab:Tab = new Tab();
			ChildTab.height = height;
			addChild(ChildTab);
			return ChildTab;
		}
		public function DeleteTab(Child:Tab):void
		{
			if(Child)
			{
				this.contains(Child)
				{
					this.removeChild(Child);
				}
			}
		}
		
		/**
		 * Id查找TAB
		 **/
		public function FindTabById(Id:String):Tab
		{
			for(var Idx:int=0; Idx<Children.length; Idx++)
			{
				if(Tab(Children[Idx]).Id == Id)
				{
					return Children[Idx];
				}
			}
			return null;
		}
		
		/**
		 * 禁止通过拖拽添加控件
		 **/
		override public function OnDrop(Control:UIControl):void
		{
			
		}
	}
}
import corecom.control.style.ContainerStyle;

/**
 * 标签栏样式
 **/
class TabBarSkin extends ContainerStyle
{
	public function TabBarSkin()
	{
		super();
		//Height = 30;
		BorderThinkness = 0;
		this.Gap = 5;
	}
}