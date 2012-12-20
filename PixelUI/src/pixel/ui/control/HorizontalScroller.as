package pixel.ui.control
{
	import pixel.ui.control.style.UIContainerStyle;
	import pixel.ui.control.event.ScrollerEvent;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import pixel.ui.control.style.ScrollerStyle;
	
	public class HorizontalScroller extends Scroller
	{
		private var _parentContainer:UIContainer = null;
		
		//容器的宽度和高度
		private var _BoxWidth:int = 0;
		private var _BoxHeight:int = 0;
		private var _RealWidth:int = 0;
		//private var _RealHeight:int = 0;
		
		//实际宽度比容器宽度溢出的数量
		private var _RemainWidth:int = 0;
		
		
		private var _PixelUnit:Number = 0;
		
		public function HorizontalScroller(Skin:Class = null)
		{
			var StyleSkin:Class = Skin ? Skin:UIContainerStyle;
			super(StyleSkin);
			
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,MouseDrag);
		}
		
		override public function dispose():void
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
			
			Pos.x = Pos.x > _offset.x ? Pos.x - _offset.x:0;
			
			if(Pos.x + _Handler.width >= _BoxWidth)
			{
				Pos.x = _BoxWidth - _Handler.width;
				_Handler.x = Pos.x;
			}
			else
			{
				_Handler.x = Pos.x;
			}
			
			var Notify:ScrollerEvent = new ScrollerEvent(ScrollerEvent.SCROLL_UPDATE);
			Notify.ScrollRect.x = _Handler.x * _PixelUnit;
			Notify.ScrollRect.y = 0;
			Notify.ScrollRect.x = Notify.ScrollRect.x >= _RealWidth - _BoxWidth ? _RealWidth - _BoxWidth :Notify.ScrollRect.x;
			Notify.ScrollRect.width = _BoxWidth- _parentContainer.Gap;
			Notify.ScrollRect.height = _BoxHeight;
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
			_parentContainer = parent as UIContainer;
			if(_parentContainer)
			{
				
				//获取容器的实际宽度和实际高度
				_RealWidth = _parentContainer.RealWidth;
				//_RealHeight = _parentContainer.RealHeight;
				
				//获取容器的样式高度
				_BoxWidth = _parentContainer.width;
				_BoxHeight = _parentContainer.height;
				
				if(_RealWidth > _BoxWidth)
				{
					width = _BoxWidth;
					height = height;
					//设定位置
					x = 0;
					y = _BoxHeight - height;
					
					_Handler.height = height;
					
					_RemainWidth = _RealWidth - _BoxWidth;
					//计算手柄的宽度
					var HandlerWidth:int = _BoxWidth - _RemainWidth;
					
					if(HandlerWidth < HANDLER_MINMIZE)
					{
						HandlerWidth = HANDLER_MINMIZE;
					}
					_Handler.width = HandlerWidth;
					_PixelUnit = (_RealWidth - _BoxWidth) / (_BoxWidth - HandlerWidth);
					
					this.visible = true;
					
					var Notify:ScrollerEvent = new ScrollerEvent(ScrollerEvent.SCROLL_UPDATE);
					Notify.ScrollRect.x = _Handler.y * _PixelUnit;
					Notify.ScrollRect.y = 0;
					
					Notify.ScrollRect.width = _BoxWidth - _parentContainer.Gap;
					Notify.ScrollRect.height = _BoxHeight;
					
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