package pixel.ui.control
{
	import pixel.ui.control.event.SliderEvent;
	import pixel.ui.control.event.UIControlEvent;
	import pixel.ui.control.style.UISliderStyle;
	import pixel.ui.control.utility.Utils;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import pixel.utility.Tools;

	/**
	 * 滑动条
	 **/
	public class UISlider extends UIContainer
	{
		/**
		 * 
		 * 滑动的当前值
		 * 
		 **/
		private var _value:Number = 0;
		public function set value(data:Number):void
		{
			_value = data;
		}
		public function get value():Number
		{
			return _value;
		}
		
		/**
		 * 
		 * 滑动步进值
		 * 
		 **/
		private var _stepValue:Number = 1;
		public function set stepValue(data:Number):void
		{
			_stepValue = data;
		}
		public function get stepValue():Number
		{
			return _stepValue;
		}
		
		/**
		 * 
		 * 最大值
		 * 
		 **/
		private var _maxmizeValue:Number = 0;
		public function set maxmizeValue(data:Number):void
		{
			_maxmizeValue = data;
			_stepValue = _maxmizeValue / (width - SliderButton.width);
			//_stepValue = Number(_stepValue.toFixed(1));
		}
		public function get maxmizeValue():Number
		{
			return _maxmizeValue;
		}
		
		/**
		 * 
		 * 最小值
		 * 
		 **/
		private var _minimizeValue:Number = 0;
		public function set MinimizeValue(data:Number):void
		{
			_minimizeValue = data;
		}
		public function get MinimizeValue():Number
		{
			return _minimizeValue;
		}
		
		/**
		 * 变更滑动杆按钮宽度
		 **/
		public function set SliderButtonWidth(Value:int):void
		{
			SliderButton.width = Value;
		}
		public function get SliderButtonWidth():int
		{
			return SliderButton.width;
		}
		
		/**
		 * 滑动按钮高度
		 **/
		public function set SliderButtonHeight(Value:int):void
		{
			SliderButton.height = Value;
			SliderButton.y = ((height - Value) >> 1);
		}
		public function get SliderButtonHeight():int
		{
			return SliderButton.height;
		}
		
		public function set SliderButtonImage(Value:Bitmap):void
		{
			SliderButton.BackgroundImage = Value;
		}
		public function set SliderButtonImageId(Value:String):void
		{
			SliderButton.BackgroundImageId = Value;
		}
		
		//滑动杆按钮对象
		private var SliderButton:SimpleSliderButton = null;
		
		public function UISlider(Skin:Class = null)
		{
			super((Skin?Skin:UISliderStyle));
			Style.BorderThinkness = 0;
			//创建滑动杆按钮
			SliderButton = new SimpleSliderButton();
			SliderButton.width = 10;
			SliderButton.height = 20;
			addChild(SliderButton);
			this.padding = 0;
			
			addEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
			addEventListener(UIControlEvent.RENDER_UPDATE,OnUpdate);
			width = 150;
			height = 40;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			SliderButton.height = value;
		}
		
		/**
		 * 渲染
		 **/
		override public function Render():void
		{
			super.Render();
			graphics.beginFill(UISliderStyle(Style).SliderLineColor);
			graphics.drawRect(0,((height - UISliderStyle(Style).SliderLineHeight) >> 1),width,UISliderStyle(Style).SliderLineHeight);
			graphics.endFill();
		}
		
		
		private function OnUpdate(event:UIControlEvent):void
		{
			SliderButton.y = ((height - SliderButton.height) >> 1);
		}
		
		private function OnMouseDown(event:MouseEvent):void
		{
			if(event.target is SimpleSliderButton)
			{
				//注册全局鼠标移动事件
				stage.addEventListener(MouseEvent.MOUSE_MOVE,SliderScrollMove);
				stage.addEventListener(MouseEvent.MOUSE_UP,SliderScrollStop);
			}
		}
		
		//上一次数值更新的数字
		private var _lastChangeNotifyValue:Number = 0;
		private var Pos:Point = new Point();
		private function SliderScrollMove(event:MouseEvent):void
		{
			Pos.x = event.stageX;
			Pos.y = event.stageY;
			Pos = globalToLocal(Pos);
			if(Pos.x > (width - SliderButton.width))
			{
				SliderButton.x = width - SliderButton.width;
				_value = _maxmizeValue;
			}
			else
			{
				SliderButton.x = Pos.x < 0 ? 0: Pos.x;
				_value = Math.round(SliderButton.x * _stepValue);
			}
			if(_lastChangeNotifyValue != _value)
			{
				_lastChangeNotifyValue = _value;
				var NotifyEvent:SliderEvent = new SliderEvent(SliderEvent.VALUE_CHANGED);
				NotifyEvent.Value = _value;
				dispatchEvent(NotifyEvent);
			}
		}
		private function SliderScrollStop(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,SliderScrollMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP,SliderScrollStop);
		}
		
		override public function dispose():void
		{
			super.dispose();
			removeEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
			removeEventListener(UIControlEvent.RENDER_UPDATE,OnUpdate);
		}
		
		override public function get Children():Array
		{
			return [];
		}
		
		/**
		 * 滑动线样式变更
		 **/
		public function get SliderLineColor():uint
		{
			return UISliderStyle(Style).SliderLineColor;
		}
		public function set SliderLineColor(Value:uint):void
		{
			UISliderStyle(Style).SliderLineColor = Value;
			StyleUpdate();
		}
		
		/**
		 * 滑动线高度设置
		 **/
//		public function get LineHeight():int
//		{
//			return SimpleSliderStyle(Style).SliderLineHeight;
//		}
//		public function set LineHeight(Value:int):void
//		{
//			SimpleSliderStyle(Style).SliderLineHeight = Value;
//			StyleUpdate();
//		}
		
		public function set SliderLineHeight(Value:int):void
		{
			UISliderStyle(Style).SliderLineHeight = Value;
			StyleUpdate();
		}
		public function get SliderLineHeight():int
		{
			return UISliderStyle(Style).SliderLineHeight; 
		}
	}
}
import pixel.ui.control.UIButton;
import pixel.ui.control.UIImage;
import pixel.ui.control.SimpleShape;
import pixel.ui.control.UIControl;

/**
 * 滑动杆拖动按钮
 **/
class SimpleSliderButton extends SimpleShape
{
	public function SimpleSliderButton():void
	{
		super();
	}
}