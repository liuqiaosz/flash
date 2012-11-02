package corecom.control.utility
{
	import corecom.control.UIControl;
	import corecom.control.event.EditModeEvent;
	import corecom.control.event.UIControlEvent;
	
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
	
	public class FocusFrame  extends Sprite
	{
		protected var _Update:Boolean = false;
		//protected var _FrameWidth:int = 0;
		//protected var _FrameHeight:int = 0;
		protected var _BorderColor:uint = 0x1B8DEA;
		protected var _PointSize:int = 5;
		//protected var _Actived:Boolean = false;
		private var _lt:AnchorPoint = null;
		private var _lm:AnchorPoint = null;
		private var _lb:AnchorPoint = null;
		private var _mt:AnchorPoint = null;
		private var _mb:AnchorPoint = null;
		private var _rt:AnchorPoint = null;
		private var _rm:AnchorPoint = null;
		private var _rb:AnchorPoint = null;
		
		private var _Control:UIControl = null;
		private var _Focus:Boolean = false;
		
		public function FocusFrame(Control:UIControl)
		{
			super();
			//			VerticalIcon = new VerticalIconClass() as Bitmap;
			//			var Data:MouseCursorData = new MouseCursorData();
			//			Data.data = new Vector.<BitmapData>();
			//			Data.data.push(VerticalIcon.bitmapData);
			//			Mouse.registerCursor("Vertical",Data);
			//			
			//			HorizontalIcon = new HorizontalClass() as Bitmap;
			//			Data = new MouseCursorData();
			//			Data.data = new Vector.<BitmapData>();
			//			Data.data.push(HorizontalIcon.bitmapData);
			//			Mouse.registerCursor("Horizontal",Data);
			//			
			//			RightTopIcon = new RightTopClass() as Bitmap;
			//			Data = new MouseCursorData();
			//			Data.data = new Vector.<BitmapData>();
			//			Data.data.push(RightTopIcon.bitmapData);
			//			Mouse.registerCursor("RightTop",Data);
			//			
			//			LeftTopIcon = new LeftTopClass() as Bitmap;
			//			Data = new MouseCursorData();
			//			Data.data = new Vector.<BitmapData>();
			//			Data.data.push(LeftTopIcon.bitmapData);
			//			Mouse.registerCursor("LeftTop",Data);
			
			_Control = Control;
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
			_lt.visible = _lm.visible = _lb.visible = _mt.visible = _mb.visible = _rt.visible = _rm.visible = _rb.visible = _Focus;
			
			addEventListener(Event.ADDED_TO_STAGE,OnAdded);
			addEventListener(MouseEvent.MOUSE_OVER,Over);
			addEventListener(MouseEvent.MOUSE_OUT,Out);
			addEventListener(MouseEvent.MOUSE_DOWN,Click,true);
		}
		
//		override public function set width(value:Number):void
//		{
//			_FrameWidth = value;
//			Update();
//		}
//		
//		override public function set height(value:Number):void
//		{
//			_FrameHeight = value;
//			Update();
//		}
		
		private function Out(event:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_MOVE,OnMove);
			Mouse.cursor = MouseCursor.AUTO;
		}
		private function Over(event:MouseEvent):void
		{
			addEventListener(MouseEvent.MOUSE_MOVE,OnMove);
		}
		
		private var _Resizable:Boolean = false;
		private var _ResizablePoint:AnchorPoint = null;
		private var _LastPoint:Point = new Point();
		protected function Click(event:MouseEvent):void
		{
			event.stopPropagation();
			Enable();
			//_Focus = !_Focus;
			//_bg.visible = _lt.visible = _lm.visible = _lb.visible = _mt.visible = _mb.visible = _rt.visible = _rm.visible = _rb.visible = _Focus;
			if(_Focus)
			{
				if(event.target is AnchorPoint)
				{
					trace("Resize start");
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
			else
			{
				
			}
		}
		
		public function EnableDragStart(Point:Object):void
		{
			Enable();
			//_Focus = !_Focus;
			//_bg.visible = _lt.visible = _lm.visible = _lb.visible = _mt.visible = _mb.visible = _rt.visible = _rm.visible = _rb.visible = _Focus;
			if(_Focus)
			{
				trace("Resize start");
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
			else
			{
				
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
				trace("Resize move");
				//				Pos.x = x;
				//				Pos.y = y;
				//				Pos = stage.localToGlobal(Pos);
				Pos.x = event.stageX - _LastPoint.x;
				Pos.y = event.stageY - _LastPoint.y;
				_LastPoint.x = event.stageX;
				_LastPoint.y = event.stageY;
				
				if(_ResizablePoint == _mt || _ResizablePoint == _mb)
				{
					//_FrameHeight = event.stageY - Pos.y;
					if(_ResizablePoint == _mt)
					{
						Pos.y *= -1;
						//_FrameHeight = _FrameHeight * -1;
						_Control.height += Pos.y;
						parent.y -= Pos.y;
					}
					else
					{
						//_Control.height = _FrameHeight;
						_Control.height += Pos.y;
						
					}
					//_FrameHeight = _Control.height;
				}
				else if(_ResizablePoint == _lm || _ResizablePoint == _rm)
				{
					//_FrameWidth = event.stageX - Pos.x;
					
					if(_ResizablePoint == _lm)
					{
						//_FrameWidth *= -1;
						Pos.x *= -1;
						_Control.width += Pos.x;
						parent.x -= Pos.x;
					}
					else
					{
						_Control.width += Pos.x;
						
					}
					//_FrameWidth = _Control.width;
				}
				var Notify:EditModeEvent = new EditModeEvent(EditModeEvent.FRAME_RESIZED);
				dispatchEvent(Notify);
			}
			
		}
		
		private function OnMove(event:MouseEvent):void
		{
			if(event.target is AnchorPoint)
			{
				Mouse.cursor = MouseCursor.HAND;
			}
			else
			{
				Mouse.cursor = MouseCursor.ARROW;
			}
		}
		
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
		
		public function Enable():void
		{
			_Focus = true;
			_lt.visible = _lm.visible = _lb.visible = _mt.visible = _mb.visible = _rt.visible = _rm.visible = _rb.visible = _Focus;
			var Notify:EditModeEvent = new EditModeEvent(EditModeEvent.FRAME_FOCUS);
			dispatchEvent(Notify);
			Update();
		}
		public function Disable():void
		{
			_Focus = false;
			_lt.visible = _lm.visible = _lb.visible = _mt.visible = _mb.visible = _rt.visible = _rm.visible = _rb.visible = _Focus;
			var Notify:EditModeEvent = new EditModeEvent(EditModeEvent.FRAME_UNFOCUS);
			dispatchEvent(Notify);
			Update();
		}
		
		protected function Render(event:Event):void
		{
			_Update = false;
			
			var Offset:int = _PointSize / 2 + 1;
			var Width:int = _Control.width;
			var Height:int = _Control.height;
			if(_Focus)
			{
				
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
		}
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