package corecom.control
{
	import corecom.core.LibraryInternal;

	use namespace LibraryInternal
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
import corecom.control.IToolTip;
import corecom.control.TextAlign;
import corecom.control.UIControl;
import corecom.control.UILabel;
import corecom.control.UIPanel;
import corecom.control.asset.IControlAssetManager;
import corecom.control.style.IVisualStyle;
import corecom.core.LibraryInternal;

import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;
import flash.utils.getTimer;

class ToolTipImpl implements IToolTip
{
	use namespace LibraryInternal;
	
	private var _Tip:TipPanel = new TipPanel();
	private var _LazyTime:int = 0;
	private var _LazyTimer:Timer = new Timer(30);
	private var _Queue:Vector.<UIControl> = null;
	public function ToolTipImpl()
	{
		_Queue = new Vector.<UIControl>();
		_LazyTimer.addEventListener(TimerEvent.TIMER,TimerProcess);
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
			
			//获取控件所处坐标然后转换成全局坐标
//			var Pos:Point = new Point(_CurrentControl.x,_CurrentControl.y);
//			Pos = _CurrentControl.stage.localToGlobal(Pos);
			if(!_Show)
			{
				_CurrentControl.stage.addChild(_Tip);
				_Tip.TipText = _CurrentControl.ToolTip;
				
				_Show = true;
			}
			_Tip.x = _CurrentControl.stage.mouseX + 10;
			_Tip.y = _CurrentControl.stage.mouseY + 30;
		}
	}
	
	private function HideTip():void
	{
		_Show = false;
		if(_CurrentControl && _CurrentControl.stage)
		{
			if(_CurrentControl.stage.contains(_Tip))
			{
				_CurrentControl.stage.removeChild(_Tip);
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
	public function ChangeSkin(Skin:IVisualStyle):void
	{
	}
}

class TipPanel extends UIPanel
{
	private var _Label:UILabel = null;
	public function TipPanel()
	{
		super();
		_Label = new UILabel();
		_Label.Align = TextAlign.LEFT;
		_Label.Mutiline = true;
		addChild(_Label);
		this.Style.BackgroundColor = 0xFFCC33;
	}
	
	public function set TipText(Value:String):void
	{
		_Label.Text = Value;
		width = _Label.TextWidth + 5;
		height = _Label.TextHeight + 5;
	}
}
