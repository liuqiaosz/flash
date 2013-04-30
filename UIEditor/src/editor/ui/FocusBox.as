package editor.ui
{
	//import pixel.ui.control.UIControl;
	//import pixel.ui.control.event.EditModeEvent;
	//import pixel.ui.control.event.UIControlEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.ui.MouseCursorData;
	
	import pixel.ui.control.UIControl;

	public class FocusBox extends Sprite
	{
		protected var _Update:Boolean = false;
		//protected var _FrameWidth:int = 0;
		//protected var _FrameHeight:int = 0;
		protected var _BorderColor:uint = 0x1B8DEA;
		protected var _PointSize:int = 10;
		//protected var _Actived:Boolean = false;
		private var _lt:AnchorPoint = null;
		private var _lm:AnchorPoint = null;
		private var _lb:AnchorPoint = null;
		private var _mt:AnchorPoint = null;
		private var _mb:AnchorPoint = null;
		private var _rt:AnchorPoint = null;
		private var _rm:AnchorPoint = null;
		private var _rb:AnchorPoint = null;
		
		private var _control:UIControl = null;
		public function set control(value:UIControl):void
		{
			_control = value;
		}
		
		//private var _Control:UIControl = null;
		//private var _Focus:Boolean = false;
		
		public function FocusBox()
		{
			//_FrameWidth = _Control.width;
			//_FrameHeight = _Control.height;
			//addChild(_Control);
			_lt = new AnchorPoint(_PointSize,_BorderColor);
			_lm = new AnchorPoint(_PointSize,_BorderColor);
			_lb = new AnchorPoint(_PointSize,_BorderColor);
			_mt = new AnchorPoint(_PointSize,_BorderColor);
			_mb = new AnchorPoint(_PointSize,_BorderColor);
			_rt = new AnchorPoint(_PointSize,_BorderColor);
			_rm = new AnchorPoint(_PointSize,_BorderColor);
			_rb = new AnchorPoint(_PointSize,_BorderColor);
			
			addChild(_lt);
			addChild(_lm);
			addChild(_lb);
			addChild(_mt);
			addChild(_mb);
			addChild(_rt);
			addChild(_rm);
			addChild(_rb);
			//_lt.visible = _lm.visible = _lb.visible = _mt.visible = _mb.visible = _rt.visible = _rm.visible = _rb.visible = true;
			//addEventListener(Event.ADDED_TO_STAGE,OnAdded);
			
			addEventListener(MouseEvent.MOUSE_OVER,onOver);
			addEventListener(MouseEvent.MOUSE_OUT,onOut);
			/*
			_lt.addEventListener(MouseEvent.MOUSE_DOWN,Click);
			_lm.addEventListener(MouseEvent.MOUSE_DOWN,Click);
			_lb.addEventListener(MouseEvent.MOUSE_DOWN,Click);
			_mt.addEventListener(MouseEvent.MOUSE_DOWN,Click);
			_mb.addEventListener(MouseEvent.MOUSE_DOWN,Click);
			_rt.addEventListener(MouseEvent.MOUSE_DOWN,Click);
			_rm.addEventListener(MouseEvent.MOUSE_DOWN,Click);
			_rb.addEventListener(MouseEvent.MOUSE_DOWN,Click);
			*/
			this.addEventListener(MouseEvent.MOUSE_DOWN,Click);
		}
		
		public function redraw(w:int,h:int):void
		{
			
			this.graphics.clear();
			
			this.graphics.lineStyle(1,0x0000ff);
			this.graphics.drawRect(0,0,w,h);
			
			
			var Offset:int = _PointSize / 2 + 1;
			var Width:int = w;
			var Height:int = h;
			
			_lt.x = -Offset;
			_lt.y = -Offset;
			
			_lm.y = ((Height - _PointSize)) / 2;
			_lm.x = -Offset;
			
			_lb.y = Height - Offset;
			_lb.x = -Offset;
			
			_mt.x = (Width - _PointSize) / 2;
			_mt.y = -Offset;
			
			_mb.x = _mt.x;
			_mb.y = _lb.y;
			
			_rt.x = Width - Offset;
			_rt.y = _mt.y;
			
			_rm.x = _rt.x;
			_rm.y = _lm.y;
			
			_rb.x = _rt.x;
			_rb.y = _mb.y;
			
			
		}
		
		private function onOver(event:MouseEvent):void
		{
			//addEventListener(MouseEvent.MOUSE_MOVE,onMove);
			if(event.target is AnchorPoint)
			{
				Mouse.cursor = MouseCursor.HAND;
			}
			else
			{
				Mouse.cursor = MouseCursor.ARROW;
			}
		}
		
		private function onOut(event:MouseEvent):void
		{
			//removeEventListener(MouseEvent.MOUSE_MOVE,onOut);
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		private var _Resizable:Boolean = false;
		private var _ResizablePoint:AnchorPoint = null;
		private var _LastPoint:Point = new Point();
		protected function Click(event:MouseEvent):void
		{
			//event.stopImmediatePropagation();
			//Enable();
			//_Focus = !_Focus;
			//_bg.visible = _lt.visible = _lm.visible = _lb.visible = _mt.visible = _mb.visible = _rt.visible = _rm.visible = _rb.visible = _Focus;
			if(event.target is AnchorPoint)
			{
				_Resizable = true;
				_ResizablePoint = event.target as AnchorPoint;
				stage.addEventListener(MouseEvent.MOUSE_MOVE,ResizeMove,true);
				stage.addEventListener(MouseEvent.MOUSE_UP,ResizeClose,true);
				_LastPoint.x = event.stageX;
				_LastPoint.y = event.stageY;
			}
			else
			{
				FrameDragStart(event.localX,event.localY);
			}
		}
		
		public function EnableDragStart(Point:Object):void
		{
			//Enable();
			//_Focus = !_Focus;
			//_bg.visible = _lt.visible = _lm.visible = _lb.visible = _mt.visible = _mb.visible = _rt.visible = _rm.visible = _rb.visible = _Focus;
			_Resizable = true;
			_ResizablePoint = Point as AnchorPoint;
			if(_ResizablePoint)
			{
				stage.addEventListener(MouseEvent.MOUSE_MOVE,ResizeMove,true);
				stage.addEventListener(MouseEvent.MOUSE_UP,ResizeClose,true);
				_LastPoint.x = stage.mouseX;
				_LastPoint.y = stage.mouseY;
			}
		}
		
		protected function FrameDragStart(OffsetX:int,OffsetY:int):void
		{
			
		}
		
		private function ResizeClose(event:MouseEvent):void
		{
			if(stage)
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE,ResizeMove,true);
				stage.removeEventListener(MouseEvent.MOUSE_UP,ResizeClose,true);
				_Resizable = false;
				_ResizablePoint = null;
			}
			
		}
		
		private var Pos:Point = new Point();
		private function ResizeMove(event:MouseEvent):void
		{
			if(_Resizable)
			{
				event.stopPropagation();
				Pos.x = event.stageX - _LastPoint.x;
				Pos.y = event.stageY - _LastPoint.y;
				_LastPoint.x = event.stageX;
				_LastPoint.y = event.stageY;
				
				if(_ResizablePoint == _mt || _ResizablePoint == _mb)
				{
					if(_ResizablePoint == _mt)
					{
						Pos.y *= -1;
						_control.height += Pos.y;
						parent.y -= Pos.y;
					}
					else
					{
						_control.height += Pos.y;
						
					}
				}
				else if(_ResizablePoint == _lm || _ResizablePoint == _rm)
				{
					if(_ResizablePoint == _lm)
					{
						Pos.x *= -1;
						_control.width += Pos.x;
						parent.x -= Pos.x;
					}
					else
					{
						_control.width += Pos.x;
						
					}
				}
				else if(_ResizablePoint == _lt || _ResizablePoint == _lb)
				{
					if(_ResizablePoint == _lt)
					{
						Pos.x *= -1;
						_control.width += Pos.x;
						parent.x -= Pos.x;
						
						Pos.y *= -1;
						_control.height += Pos.y;
						parent.y -= Pos.y;
					}
					else
					{
						Pos.x *= -1;
						_control.width += Pos.x;
						parent.x += Pos.x * -1;
						
						_control.height += Pos.y;
						//parent.y = Pos.y + _Control.height;
					}
				}
				else if(_ResizablePoint == _rt || _ResizablePoint == _rb)
				{
					if(_ResizablePoint == _rt)
					{
						//Pos.x *= -1;
						_control.width += Pos.x;
						
						Pos.y *= -1;
						_control.height += Pos.y;
						parent.y -= Pos.y;
					}
					else
					{
						_control.width += Pos.x;
						
						_control.height += Pos.y;
					}
				}
				
				redraw(_control.width,_control.height);
			}
			
		}
		
		
		/*
		
		
		
		
		
		
		
		
		
		protected function OnAdded(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,OnAdded);
			this.addEventListener(Event.RENDER,Render);
			
			if(_Update)
			{
				stage.invalidate();	
			}
		}
		
		
		protected function Update():void
		{
			_Update = true;
			if(stage)
			{
				stage.invalidate();
			}
		}
		*/
		/*
		
		
		protected function Render(event:Event):void
		{
			_Update = false;
			
			
		}
		*/
	}
}


import flash.display.Shape;
import flash.display.Sprite;

class AnchorPoint extends Sprite
{
	public function AnchorPoint(Size:int,Color:uint)
	{
		super();
		this.graphics.clear();
		this.graphics.beginFill(0xFFFFFF);
		this.graphics.lineStyle(1,Color);
		this.graphics.drawRect(0,0,Size,Size);
		this.graphics.endFill();
		//this.addEventListener(
	}
}