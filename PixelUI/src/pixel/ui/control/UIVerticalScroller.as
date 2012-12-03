package pixel.ui.control
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import pixel.ui.control.event.ScrollerEvent;
	import pixel.ui.control.style.IVisualStyle;
	import pixel.ui.control.style.UIVerticalScrollerStyle;
	import pixel.ui.core.NSPixelUI;

	use namespace NSPixelUI;
	
	/**
	 * 纵向滚动条
	 * 
	 * 
	 **/
	public class UIVerticalScroller extends UIContainer implements IUIScroller
	{
		public static const DEFAULT_WIDTH:int = 22;
		public static const DEFAULT_HANDLER_MIN:int = 44;
		
		[Embed(source="Scrolldown.png")]
		private var DOWN:Class;
		[Embed(source="Scrollup.png")]
		private var UP:Class;
		
		protected var _minHeight:int = 0;
		protected var _scrollUp:UIButton = null;
		protected var _scrollDown:UIButton = null;
		protected var _scrollHandlerPanel:UIContainer = null;
		protected var _scrollHandler:UIButton = null;
		public function UIVerticalScroller(skin:Class = null,initiazlier:Boolean = true)
		{
			super(skin?skin:UIVerticalScrollerStyle);
			_minHeight = DEFAULT_HANDLER_MIN;
			if(initiazlier)
			{
				initializer();
			}
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,MouseDrag);
		}
		
		/**
		 * 默认样式初始化
		 * 
		 **/
		override public function initializer():void
		{
			width = DEFAULT_WIDTH;
			
			_scrollUp = new UIButton();
			_scrollUp.width = _scrollUp.height = DEFAULT_WIDTH;
			
			_scrollDown = new UIButton();
			_scrollDown.width = _scrollDown.height = DEFAULT_WIDTH;
			
			_scrollHandlerPanel = new UIContainer();
			_scrollHandlerPanel.BorderThinkness = 0;
			_scrollHandler = new UIButton();
			_scrollHandler.borderThinknessForAllState = 0;
			_scrollHandlerPanel.width = _scrollHandler.width = DEFAULT_WIDTH;
			_scrollHandlerPanel.height = _scrollHandler.height = height - DEFAULT_WIDTH * 2;
			_scrollHandlerPanel.BackgroundAlpha = 0;
			
			_scrollHandlerPanel.addChild(_scrollHandler);
			//_scrollHandler.BackgroundColor = 0xff0000;
			
			addChild(_scrollUp);
			addChild(_scrollDown);
			addChild(_scrollHandlerPanel);
			
			_scrollDown.y = height - DEFAULT_WIDTH;
			_scrollHandlerPanel.y = DEFAULT_WIDTH; 
			
			_scrollUp.backgroundImageForAllState = new UP() as Bitmap;
			//_scrollUp.Scale9Grid = true;
			//_scrollUp.Scale9GridAll = 4;
			_scrollUp.borderThinknessForAllState = 0;
			_scrollUp.width = DEFAULT_WIDTH;
			_scrollUp.height = DEFAULT_WIDTH;
			
			_scrollDown.backgroundImageForAllState = new DOWN() as Bitmap;
			//_scrollDown.Scale9Grid = true;
			//_scrollDown.Scale9GridAll = 4;
			_scrollDown.width = DEFAULT_WIDTH;
			_scrollDown.height = DEFAULT_WIDTH;
			_scrollDown.borderThinknessForAllState = 0;
			
			_scrollUp.addEventListener(MouseEvent.CLICK,clickUp);
			_scrollDown.addEventListener(MouseEvent.CLICK,clickDown);
		}
		
		private function clickUp(event:MouseEvent):void
		{
			_scrollHandler.y -= 5;
			if(_scrollHandler.y < 0)
			{
				_scrollHandler.y = 0;	
			}
			this.refresh();
		}
		private function clickDown(event:MouseEvent):void
		{
			_scrollHandler.y += 5;
			if(_scrollHandler.y + _scrollHandler.height > _scrollHandlerPanel.height)
			{
				_scrollHandler.y = _scrollHandlerPanel.height - _scrollHandler.height;
			}
			this.refresh();
		}
		
		protected var _Draging:Boolean = false;
		private var _offset:Point = new Point();
		private function MouseDrag(event:MouseEvent):void
		{
			if(event.target == _scrollHandler)
			{
				//拖拽开始
				_Draging = true;
				stage.addEventListener(MouseEvent.MOUSE_MOVE,MouseDragMove);
				stage.addEventListener(MouseEvent.MOUSE_UP,MouseDrop);
				_offset.x = event.localX;
				_offset.y = event.localY;
				//_offset = globalToLocal(_offset);
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
			Pos = globalToLocal(Pos);
			Pos.y = Pos.y > _offset.y ? Pos.y - _offset.y:0;
			if(Pos.y + _scrollHandler.height >= _scrollHandlerPanel.height)
			{
				Pos.y = _scrollHandlerPanel.height - _scrollHandler.height;
				_scrollHandler.y = Pos.y;
			}
			else
			{
				_scrollHandler.y = Pos.y;
			}
			//trace(_scrollHandler.y);
			
			var Notify:ScrollerEvent = new ScrollerEvent(ScrollerEvent.SCROLL_UPDATE);
			Notify.ScrollRect.x = 0;
			Notify.ScrollRect.y = _scrollHandler.y * _stepPixel;
			Notify.ScrollRect.y = Notify.ScrollRect.y >= _remainValue ? _remainValue:(Notify.ScrollRect.y);
			
			Notify.ScrollRect.width = _containerWidth;
			Notify.ScrollRect.height = _containerHeight - _container.padding * 2 + _container.BorderThinkness;
			_container.Content.scrollRect = Notify.ScrollRect;
			dispatchEvent(Notify);
		}
		
		/**
		 * 覆写高度设置方法
		 * 设置高度的同时调整各子控件的位置
		 * 
		 **/
		override public function set height(value:Number):void
		{
			super.height = value;
			_scrollDown.y = height - _scrollDown.height;
			_scrollHandlerPanel.height = value - DEFAULT_WIDTH * 2;
			_scrollHandlerPanel.y = DEFAULT_WIDTH;
		}
		
		protected var _container:UIContainer = null;
		protected var _containerRealHeight:int = 0;
		protected var _containerHeight:int = 0;
		protected var _containerWidth:int = 0;
		protected var _remainValue:Number = 0
		protected var _stepPixel:Number = 0;
		//需要滚动的像素
		protected var _remainHeight:int = 0;
		
		/**
		 * 刷新样式
		 * 
		 * 
		 **/
		NSPixelUI function refresh():void
		{
			_container = parent as UIContainer;
			if(_container)
			{
				
				//获取容器的实际宽度和实际高度
				//_RealWidth = _parentContainer.RealWidth;
				_containerRealHeight = _container.RealHeight;
				
				//获取容器的样式高度
				_containerWidth = _container.width;
				_containerHeight = _container.height;
				
				if(_containerRealHeight > _containerHeight)
				{
					height = _containerHeight;
					//设定位置
					x = _containerWidth - width;
					y = 0;
					
					_scrollHandlerPanel.width = _scrollHandler.width = width;
					
					_remainValue = _containerRealHeight - _containerHeight;
					
					//计算手柄的高度
					var handlerHeight:int = _scrollHandlerPanel.height - _remainValue;
					
					if(handlerHeight < _minHeight)
					{
						handlerHeight = _minHeight;
					}

					_scrollHandler.height = handlerHeight;
					_stepPixel = _remainValue / (_scrollHandlerPanel.height - handlerHeight);
					
					this.visible = true;
					
					var Notify:ScrollerEvent = new ScrollerEvent(ScrollerEvent.SCROLL_UPDATE);
					Notify.ScrollRect.x = 0;
					Notify.ScrollRect.y = (_scrollHandler.y) * _stepPixel;
					
					Notify.ScrollRect.width = _containerWidth;
					Notify.ScrollRect.height = _containerHeight - _container.padding * 2 + _container.BorderThinkness;
					
					_container.Content.scrollRect = Notify.ScrollRect;
					dispatchEvent(Notify);
				}
				else
				{
					this.visible = false;
				}
			}
		}
		
		public function get handlerStyle():IVisualStyle
		{
			return _scrollHandler.Style;
		}
		public function get buttonUpStyle():IVisualStyle
		{
			return _scrollUp.Style;
		}
		public function get buttonDownStyle():IVisualStyle
		{
			return _scrollDown.Style;
		}
	}
}