package corecom.control
{
	import corecom.control.event.ScrollerEvent;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import corecom.control.style.ScrollerStyle;
	
	/**
	 * 垂直下拉条
	 * 
	 **/
	public class VerticalScroller extends Scroller
	{
		private var _parentContainer:Container = null;
		
		//容器的宽度和高度
		private var _BoxWidth:int = 0;
		private var _BoxHeight:int = 0;
		//private var _RealWidth:int = 0;
		private var _RealHeight:int = 0;
		
		//实际宽度比容器宽度溢出的数量
		private var _RemainHeight:int = 0;
		private var _Handler:ScrollHandler = null;
		
		private var _PixelUnit:Number = 0;
		public function VerticalScroller(Skin:Class = null)
		{
			var StyleSkin:Class = Skin ? Skin:ScrollerStyle;
			super(StyleSkin);
			_Handler = new ScrollHandler();
			OrignalAddChild(_Handler);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,MouseDrag);
		}
		
		override public function Dispose():void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN,MouseDrag);
		}
		
		protected var _Draging:Boolean = false;
		private var _offset:Point = new Point();
		private function MouseDrag(event:MouseEvent):void
		{
			if(event.target == _Handler)
			{
				//拖拽开始
				_Draging = true;
				stage.addEventListener(MouseEvent.MOUSE_MOVE,MouseDragMove);
				stage.addEventListener(MouseEvent.MOUSE_UP,MouseDrop);
				_offset.x = event.localX;
				_offset.y = event.localY;
			}
 			else
			{
				//直接点击目标
			}
		}
		
		private function MouseDrop(event:MouseEvent):void
		{
			if(_Draging)
			{
				_Draging = false;
				stage.removeEventListener(MouseEvent.MOUSE_MOVE,MouseDragMove);
				stage.removeEventListener(MouseEvent.MOUSE_UP,MouseDrop);
			}
		}
		
		private var Pos:Point = new Point();
		private function MouseDragMove(event:MouseEvent):void
		{
			Pos.x = event.stageX;
			Pos.y = event.stageY;
			
			Pos = this.globalToLocal(Pos);
			
			Pos.y = Pos.y > _offset.y ? Pos.y - _offset.y:0;
			
			if(Pos.y + _Handler.height >= _BoxHeight)
			{
				Pos.y = _BoxHeight - _Handler.height;
				_Handler.y = Pos.y;
			}
			else
			{
				_Handler.y = Pos.y;
			}
			
			var Notify:ScrollerEvent = new ScrollerEvent(ScrollerEvent.SCROLL_UPDATE);
			Notify.ScrollRect.x = 0;
			Notify.ScrollRect.y = _Handler.y * _PixelUnit;
			Notify.ScrollRect.y = Notify.ScrollRect.y >= _RealHeight - _BoxHeight ? _RealHeight - _BoxHeight :Notify.ScrollRect.y;
			Notify.ScrollRect.width = _BoxWidth;
			Notify.ScrollRect.height = _BoxHeight - _parentContainer.Gap;
			_parentContainer.Content.scrollRect = Notify.ScrollRect;
			dispatchEvent(Notify);
		}
		
		override protected function Initialize():void
		{
			RefreshSize();
		}
		
		/**
		 * 刷新样式
		 * 
		 * 
		 **/
		public function RefreshSize():void
		{
			_parentContainer = parent as Container;
			if(_parentContainer)
			{
				
				//获取容器的实际宽度和实际高度
				//_RealWidth = _parentContainer.RealWidth;
				_RealHeight = _parentContainer.RealHeight;
				
				//获取容器的样式高度
				_BoxWidth = _parentContainer.width;
				_BoxHeight = _parentContainer.height;
				
				if(_RealHeight > _BoxHeight)
				{
					height = _BoxHeight;
					//设定位置
					x = _BoxWidth - width;
					y = 0;
					
					_Handler.width = width;
					
					_RemainHeight = _RealHeight - _BoxHeight;
					//计算手柄的宽度
					var HandlerHeight:int = _BoxHeight - _RemainHeight;
					
					if(HandlerHeight < HANDLER_MINMIZE)
					{
						HandlerHeight = HANDLER_MINMIZE;
					}
					_Handler.height = HandlerHeight;
					_PixelUnit = (_RealHeight - _BoxHeight) / (_BoxHeight - HandlerHeight);
					
					this.visible = true;
					
					var Notify:ScrollerEvent = new ScrollerEvent(ScrollerEvent.SCROLL_UPDATE);
					Notify.ScrollRect.x = 0;
					Notify.ScrollRect.y = _Handler.y * _PixelUnit;
					
					Notify.ScrollRect.width = _BoxWidth;
					Notify.ScrollRect.height = _BoxHeight - _parentContainer.Gap;
					
					_parentContainer.Content.scrollRect = Notify.ScrollRect;
					dispatchEvent(Notify);
				}
				else
				{
					this.visible = false;
				}
			}
		}
	}
}