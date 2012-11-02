package corecom.control
{
	import corecom.control.event.ControlEditModeEvent;
	import corecom.control.event.EditModeEvent;
	import corecom.control.style.ContainerStyle;
	import corecom.control.style.UIPanelStyle;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class UIPanel extends Container
	{
		public function UIPanel(Skin:Class = null)
		{
			super(Skin == null ? UIPanelStyle:Skin);
			//默认大小
//			width = 300;
//			height = 300;
		}

		override public function EnableEditMode():void
		{
			super.EnableEditMode();
			addEventListener(MouseEvent.MOUSE_DOWN,ChildDrag);
		}
		
		protected var _DragTarget:UIControl = null;
		override public function DisableEditMode():void
		{
			super.DisableEditMode();
			removeEventListener(MouseEvent.MOUSE_DOWN,ChildDrag);
		}
		
//		private var _ContainerEdit:Boolean = false;
//		public function EnableContainerEdit():void
//		{
//			if(!_EditMode)
//			{
//				EnableEditMode();
//			}
//			
//			_ContainerEdit = true;
//		}
		
		protected function ChildDrag(event:MouseEvent):void
		{
			if(IsChildren(event.target))
			{
				//UIControl(event.target).FrameFocus();
				var Notify:ControlEditModeEvent = new ControlEditModeEvent(ControlEditModeEvent.CHILDSELECTED);
				Notify.Params.push(event.target);
				dispatchEvent(Notify);
				
				if(_EditMode)
				{
					_DragTarget = event.target as UIControl;
					var Layout:int = ChildContainerLayout(event.target);
					if(Layout == LayoutConstant.ABSOLUTE)
					{
						OffsetX = event.localX;
						OffsetY = event.localY;
						stage.addEventListener(MouseEvent.MOUSE_MOVE,ChildDragMove,false,0,true);
						stage.addEventListener(MouseEvent.MOUSE_UP,ChildDragEnd,false,0,true);
						return;
					}
				}
			}
		}
		
		protected function ChildContainerLayout(Child:Object):int
		{
			return Layout;
		}
		
		protected var OffsetX:int = 0;
		protected var OffsetY:int = 0;
		
		protected var Local:Point = new Point();
		protected function ChildDragMove(event:MouseEvent):void
		{
			event.stopPropagation();
			if(_DragTarget)
			{
				Local.x = event.stageX;
				Local.y = event.stageY;
				Local = this.globalToLocal(Local);
				Local.x -= OffsetX;
				Local.y -= OffsetY;
				_DragTarget.x = (Local.x > 0 ? (Local.x + _DragTarget.width > width) ? width - _DragTarget.width: Local.x:0) ;
				_DragTarget.y = (Local.y > 0 ? (Local.y + _DragTarget.height > height) ? height - _DragTarget.height:Local.y:0);
				
				_DragTarget.dispatchEvent(new EditModeEvent(EditModeEvent.CONTROL_MOVED));
			}
		}
		protected function ChildDragEnd(event:MouseEvent):void
		{
			event.stopPropagation();
			_DragTarget = null;
		}
		
		/**
		 * 重写拖拽释放后的添加子对象动作
		 * 
		 * 这里禁止TabPanel加入到子对象
		 **/
		override public function OnDrop(Control:UIControl):void
		{
//			if(Control is SimpleTabPanel)
//			{
//				throw new Error("Valid operation");
//			}
			super.OnDrop(Control);
		}
	}
}