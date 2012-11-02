package corecom.control
{
	import corecom.control.event.TabPanelEvent;
	import corecom.control.event.UIControlEvent;
	import corecom.control.style.IStyle;
	import corecom.control.style.TabPanelStyle;
	import corecom.control.utility.Utils;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	/**
	 * 标签面板
	 **/
	public class SimpleTabPanel extends UIPanel
	{
		//标签栏面板
		private var _TabBar:TabBar = null;
		public function get TabPanel():TabBar
		{
			return _TabBar;
		}
		//内容面板
		private var _TabContent:TabContent = null;
		
		private var _ContentDictionary:Dictionary = new Dictionary();
		
		private var _ActivedTab:Tab = null;
		public function SimpleTabPanel(Skin:Class = null)
		{
			super(Skin ? Skin:TabPanelStyle);
			this.Layout = LayoutConstant.VERTICAL;
			_TabBar = new TabBar();
			_TabBar.addEventListener(MouseEvent.CLICK,OnTabClick,true);
			_TabBar.addEventListener(UIControlEvent.RENDER_UPDATE,TabBarUpdate);
			//_TabBar.Style.BackgroundColor = 0X0000FF;
			addChild(_TabBar);
			_TabBar.Owner = this;
			TabPanelStyle(Style).TabHeight = _TabBar.height;
			//CreateTab();
			//_Content = new TabContent();
			//addChild(_Content);
			//this.addEventListener(MouseEvent.MOUSE_DOWN,DownProxy,true);
		}
		
		override public function EnableEditMode():void
		{
			super.EnableEditMode();
			this.addEventListener(MouseEvent.MOUSE_DOWN,DownProxy,true);
		}
		
		
		private function DownProxy(event:MouseEvent):void
		{
			if(event.target is TabContent || event.target is TabBar)
			{
				var Notify:MouseEvent = new MouseEvent(MouseEvent.MOUSE_DOWN);
				var Pos:Point = new Point();
				Pos.x = stage.mouseX;
				Pos.y = stage.mouseY;
				
				Pos = this.globalToLocal(Pos);
				Notify.localX = Pos.x;
				Notify.localY = Pos.y;
				dispatchEvent(Notify);
			}
		}
		
		private function TabBarUpdate(event:UIControlEvent):void
		{
			this.UpdateLayout();
		}
		
		private var _TabHeight:int = 0;
		
		public function set TabHeight(Value:int):void
		{
			TabPanelStyle(Style).TabHeight = Value;
			for(var Idx:int=0; Idx<_TabBar.TabChildren.length; Idx++)
			{
				_TabBar.TabChildren[Idx].height = Value;
				//StyleUpdate();
			}
			_TabBar.height = Value;
			UpdateLayout();
		}
		public function get TabHeight():int
		{
			return TabPanelStyle(Style).TabHeight;
		}
		
		public function SwitchTab(Item:Tab):TabContent
		{
			if(_TabContent)
			{
				removeChild(_TabContent);
			}
			_TabContent = _ContentDictionary[Item];
			addChild(_TabContent);
			
			if(null != _ActivedTab)
			{
				_ActivedTab.UnActived();
				_ActivedTab = Item;
			}
			return _TabContent;
		}
		
		/**
		 * 获取标签对应的内容面板
		 **/
		public function FindContentByTab(TabItem:Tab):TabContent
		{
//			if(_ContentDictionary.hasOwnProperty(TabItem))
//			{
//				return _ContentDictionary[TabItem];
//			}
			return _ContentDictionary[TabItem];
		}
		
		/**
		 * 创建标签
		 **/
		public function CreateTab():Tab
		{
			var _Tab:Tab = _TabBar.CreateTab();
			var Content:TabContent = new TabContent();
			Content.OwnerTab = _Tab;
			Content.Owner = this;
			Content.width = width;
			Content.height = height - _TabBar.height;
			if(_EditMode)
			{
				Content.EnableEditMode();
			}
			_ContentDictionary[_Tab] = Content;
			//创建标签的同时出创建对应的内容面板
			if(null == _ActivedTab)
			{
				//默认第一个标签为当前选中标签
				_ActivedTab = _Tab;
				_ActivedTab.Actived();
				_TabContent = Content;
				addChild(Content);
			}
			
			return _Tab;
		}
		
		/**
		 * 删除标签.同时删除内容面板
		 **/
		public function DeleteTab(Child:Tab):void
		{
			if(Child)
			{
				_TabBar.DeleteTab(Child);
				delete _ContentDictionary[Child];
			}
		}
		
		/**
		 * 标签激活
		 **/
		private function OnTabClick(event:MouseEvent):void
		{
			if(event.target is Tab)
			{
				var Notify:TabPanelEvent = new TabPanelEvent(TabPanelEvent.TABSELECT);
				Notify.SelectTab = event.target as Tab;
				dispatchEvent(Notify);
				if(_TabContent)
				{
					removeChild(_TabContent);
				}
				_TabContent = _ContentDictionary[event.target];
				addChild(_TabContent);
				
				if(null != _ActivedTab)
				{
					_ActivedTab.UnActived();
					_ActivedTab = event.target as Tab;
				}
			}
		}
		
		override public function IsChildren(Obj:Object):Boolean
		{
			var Result:Boolean = false;
			if(Obj is TabContent || Obj is TabBar)
			{
				return Result;
			}
			Result = super.IsChildren(Obj);
			Result = Result ? Result: _TabContent.IsChildren(Obj);
			return Result;
		}
		
		override protected function ChildContainerLayout(Child:Object):int
		{
			if(_TabContent.IsChildren(Child))
			{
				return _TabContent.Layout;
			}
			else if(_TabBar.IsChildren(Child))
			{
				return _TabBar.Layout;
			}
			else
			{
				return Layout;
			}
			return Layout;
		}
		
		public function get Tabs():Array
		{
			if(_TabBar)
			{
				return _TabBar.TabChildren;
			}
			return [];
		}
		
		public function GetTabAtIndex(Index:int):Tab
		{
			if(_TabBar && Index < _TabBar.TabChildren.length)
			{
				return _TabBar.TabChildren[Index];
			}
			return null;
		}
		
		override public function set width(Value:Number):void
		{
			if(_TabBar)
			{
				_TabBar.width = Value;
			}
			if(_TabContent)
			{
				_TabContent.width = Value;
			}
			super.width = Value;
		}
		override public function set height(Value:Number):void
		{
			
			if(_TabContent)
			{
				_TabContent.height = Value - _TabBar.height;
			}
			super.height = Value;
		}
		
		override public function Render():void
		{
			super.Render();	
		}
		
		override public function get Children():Array
		{
			return [];
		}
		
		/**
		 * 编码特殊处理函数
		 **/
		override protected function SpecialEncode(Data:ByteArray):void
		{
			Data.writeByte(_TabBar.Children.length);
			
			var Idx:int = 0;
			var ChildByte:ByteArray = null;
			for(Idx; Idx<_TabBar.Children.length; Idx++)
			{
				ChildByte = _TabBar.Children[Idx].Encode();
				Data.writeBytes(ChildByte,0,ChildByte.length);
				
				ChildByte = _ContentDictionary[_TabBar.Children[Idx]].Encode();
				Data.writeBytes(ChildByte,0,ChildByte.length);
			}
		}
		
		override protected function SpecialDecode(Data:ByteArray):void
		{
			var TabLen:int = Data.readByte();
			
			var Idx:int = 0;
			var ChildByte:ByteArray = null;
			var ChildTab:Tab = null;
			var ChildTabContent:TabContent = null;
			for(Idx; Idx<TabLen; Idx++)
			{
				ChildTab = CreateTab();
				Data.readByte()
				ChildTab.Decode(Data);
				
				ChildTabContent = _ContentDictionary[ChildTab];
				Data.readByte()
				ChildTabContent.Decode(Data);
			}
		}
	}
}


