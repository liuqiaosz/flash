package editor.ui
{
	import corecom.control.UIPanel;
	import corecom.control.UIControl;
	import corecom.control.event.ControlEditModeEvent;
	import corecom.control.event.UIControlEvent;
	
	import editor.event.NotifyEvent;
	import editor.model.ComponentModel;
	import editor.uitility.ui.ActiveFrame;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;

	public class Shell extends ActiveFrame
	{
		[Embed(source="../assets/Move.png")]
		private var MoveIcon:Class;
		
		private var _Control:DisplayObject = null;
		private var _Name:String = "";
		private var _IsComponent:Boolean = false;
		private var _Component:ComponentModel = null;
		
		public function get Name():String
		{
			return _Name;
		}
		public function set Name(Value:String):void
		{
			_Name = Value;
		}
		public function get IsComponent():Boolean
		{
			return _IsComponent;
		}
		
		public function get Component():ComponentModel
		{
			return _Component;
		}
		private var _Drag:Boolean = false;
		
		private var MoveAnchor:Bitmap;
		public function Shell(Control:Object,DragEnable:Boolean = false)
		{
			super(Control as UIControl);
			if(Control is UIControl)
			{
				_Control = Control as UIControl;
				Sprite(_Control).mouseEnabled = false;
				_Drag = DragEnable;
	//			if(DragEnable)
	//			{
	//				addEventListener(MouseEvent.MOUSE_DOWN,DragStart);
	//			}
				
				
				//移除控件本身的事件响应
				UIControl(_Control).Enable = false;
				//addChild(_Control);
				addChildAt(_Control,0);
				_Control.addEventListener(UIControlEvent.STYLE_UPDATE,function(event:UIControlEvent):void{
					//BorderDrawable();
					Update();
				});
			}
			else if(Control is ComponentModel)
			{
				_Control = ComponentModel(Control).Control;
				_IsComponent = true;
				_Component = ComponentModel(Control);
				
				if(ComponentModel(Control).Category == 1)
				{
					var Idx:int = 0;
					var Container:DisplayObject = addChild(_Control as DisplayObject);
					UIPanel(_Control).EnableEditMode();
					var Len:int = ComponentModel(Control).Children.length;
					if(Len < UIPanel(_Control).Children.length)
					{
						for(Idx=0; Idx<UIPanel(_Control).Children.length; Idx++)
						{
							ComponentModel(Control).Children[Idx] = UIPanel(_Control).Children[Idx];
							//Sprite(_Control).addChild(Child);
						}
					}
					else
					{
						for(Idx=0; Idx<Len; Idx++)
						{
							Sprite(_Control).addChild(ComponentModel(Control).Children[Idx]);
						}
					}
				}
				else
				{
					addChild(ComponentModel(Control).Control);
				}
			}
			
			x = _Control.x;
			y = _Control.y;
			_Control.x = _Control.y = 0;
			//addEventListener(MouseEvent.MOUSE_DOWN,DragStart);
		}
		
		public var EnableDrawable:Boolean = true;
		public function get Control():DisplayObject
		{
			return _Control;
		}
		
		override protected function FrameDragStart(OffsetX:int,OffsetY:int):void
		{
			var Notify:NotifyEvent = new NotifyEvent(NotifyEvent.COMPONENT_DRAG_START,false);
			
			
			Notify.Params.push(OffsetX);
			Notify.Params.push(OffsetY);
			Notify.Params.push(this);
			dispatchEvent(Notify);
		}
//		private function DragStart(event:MouseEvent):void
//		{
//			var Notify:NotifyEvent = new NotifyEvent(NotifyEvent.COMPONENT_DRAG_START,false);
//			
//			Notify.Params.push(event.localY);
//			Notify.Params.push(event.localX);
//			dispatchEvent(Notify);
//			//BorderDrawable();
//			Update();
//		}
		
//		public function BorderDrawable():void
//		{
//			if(EnableDrawable)
//			{
//				graphics.clear();
//				graphics.lineStyle(2,0x66CCFF);
//				graphics.drawRect(-2,-2,_Control.width + 5,_Control.height + 5);
//			}
//		}
	}
}