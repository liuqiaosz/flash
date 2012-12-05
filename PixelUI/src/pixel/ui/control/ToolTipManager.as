package pixel.ui.control
{
	import pixel.ui.core.NSPixelUI;

	use namespace NSPixelUI
	public class ToolTipManager
	{
		private static var _Instance:IToolTip;
		public function ToolTipManager()
		{
		}
		
		public static function get Instance():IToolTip
		{
			if(null == _Instance)
			{
				_Instance = new ToolTipImpl();
			}
			return _Instance;
		}
	}
}
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;
import flash.utils.getTimer;

import pixel.ui.control.DefaultTip;
import pixel.ui.control.IPixelTip;
import pixel.ui.control.IToolTip;
import pixel.ui.control.TextAlign;
import pixel.ui.control.UIControl;
import pixel.ui.control.UILabel;
import pixel.ui.control.UIPanel;
import pixel.ui.control.asset.IPixelAssetManager;
import pixel.ui.control.style.IVisualStyle;
import pixel.ui.core.NSPixelUI;

class ToolTipImpl implements IToolTip
{
	use namespace NSPixelUI;
	
	//private var _Tip:TipPanel = new TipPanel();
	private var _tip:IPixelTip = null;
	private var _LazyTime:int = 0;
	private var _LazyTimer:Timer = new Timer(30);
	private var _Queue:Vector.<UIControl> = null;
	public function ToolTipImpl()
	{
		_Queue = new Vector.<UIControl>();
		_LazyTimer.addEventListener(TimerEvent.TIMER,TimerProcess);
		_tip = new DefaultTip();
	}
	
	//给控件绑定ToolTip
	public function Bind(Control:UIControl):void
	{
		if(_Queue.indexOf(Control) < 0)
		{
			_Queue.push(Control);
			Control.addEventListener(MouseEvent.MOUSE_MOVE,ToolTipActive);
			Control.addEventListener(MouseEvent.MOUSE_OUT,ToolTipUnActive);
		}
	}
	
	//解绑
	public function UnBind(Control:UIControl):void
	{
		if(_Queue.indexOf(Control) > 0)
		{
			_Queue.splice(_Queue.indexOf(Control),1);
			Control.removeEventListener(MouseEvent.MOUSE_MOVE,ToolTipActive);
			Control.removeEventListener(MouseEvent.MOUSE_OUT,ToolTipUnActive);
		}
	}
	
	public function set LazyTime(Value:int):void
	{
		_LazyTime = Value;
	}
	
	private var _Start:int = 0;
	private var _Show:Boolean = false;
	
	private function ShowTip():void
	{
		if(_CurrentControl && _CurrentControl.stage)
		{
			if(!_Show)
			{
				_CurrentControl.stage.addChild(_tip as DisplayObject);
				_tip.tipText = _CurrentControl.ToolTip;
				
				_Show = true;
			}
			_tip.x = _CurrentControl.stage.mouseX + 10;
			_tip.y = _CurrentControl.stage.mouseY + 30;
		}
	}
	
	/**
	 * 变更Tip面板
	 * 
	 **/
	public function changeTip(tip:IPixelTip):void
	{
		_tip = tip;
	}
	
	private function HideTip():void
	{
		_Show = false;
		if(_CurrentControl && _CurrentControl.stage)
		{
			if(_CurrentControl.stage.contains(_tip as DisplayObject))
			{
				_CurrentControl.stage.removeChild(_tip as DisplayObject);
			}
		}
	}
	
	/**
	 * 延迟计时器处理
	 **/
	private function TimerProcess(event:TimerEvent):void
	{
		var Delay:int = flash.utils.getTimer() - _Start;
		if(Delay >= _LazyTime)
		{
			//延迟时间到达。显示TIP。停止计时器
			_LazyTimer.stop();
			ShowTip();
		}
	}
	
	private var _CurrentControl:UIControl = null;
	/**
	 * 激活ToolTip
	 * 
	 * 
	 **/
	private function ToolTipActive(event:MouseEvent):void
	{
		_CurrentControl = event.currentTarget as UIControl;
		
		if(_CurrentControl)
		{
			if(_LazyTime > 0 && !_Show)
			{
				if(!_LazyTimer.running)
				{
					//延迟显示时间大于0则启动计时器
					_Start = flash.utils.getTimer();
					_LazyTimer.start();
				}
				
			}
			else
			{
				ShowTip();
			}
		}
	}
	
	/**
	 * 取消激活ToolTip
	 * 
	 * 
	 **/
	private function ToolTipUnActive(event:MouseEvent):void
	{
		if(_LazyTimer.running)
		{
			_LazyTimer.stop();
		}
		HideTip();
	}
	
	//变更皮肤
	public function ChangeSkin(style:IVisualStyle):void
	{
		UIControl(_tip).Style = style;
	}
}

//class TipPanel extends UIPanel
//{
//	private var _Label:UILabel = null;
//	public function TipPanel()
//	{
//		super();
//		_Label = new UILabel();
//		_Label.Align = TextAlign.LEFT;
//		_Label.Mutiline = true;
//		addChild(_Label);
//		this.Style.BackgroundColor = 0xFFCC33;
//	}
//	
//	public function set TipText(Value:String):void
//	{
//		_Label.Text = Value;
//		width = _Label.TextWidth + 5;
//		height = _Label.TextHeight + 5;
//	}
//}
