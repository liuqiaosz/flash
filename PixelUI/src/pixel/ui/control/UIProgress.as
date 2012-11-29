package pixel.ui.control
{
	import com.greensock.TweenLite;
	import com.greensock.core.TweenCore;
	
	import pixel.ui.control.style.UIProgressStyle;

	public class UIProgress extends UIContainer
	{
		private var _ProgressBar:UIProgressBar = null;
		public function UIProgress(Style:Class = null)
		{
			super(Style?Style:UIProgressStyle);
			_ProgressBar =  new UIProgressBar();
			_ProgressBar.x =_ProgressBar.y = this.BorderThinkness;
			addChild(_ProgressBar);
		}
		
		private var _TweenEnable:Boolean = false;
		public function set TweenEnable(Value:Boolean):void
		{
			_TweenEnable = Value;
		}
		public function get TweenEnable():Boolean
		{
			return _TweenEnable;
		}
		
		/**
		 * 更新进度
		 **/
		public function UpdateProgress(Value:Number,Maxmize:Number):void
		{
			if(Value <= Maxmize)
			{
				if(_TweenEnable)
				{
					TweenLite.to(_ProgressBar,0.3,{"width":ContentWidth * (Value / Maxmize)});
				}
				else
				{
					_ProgressBar.width = ContentWidth * (Value / Maxmize);
				}
			}
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			_ProgressBar.height = ContentHeight;
		}
	}
}

//import corecom.control.UIControl;
//import corecom.control.style.UIProgressBarStyle;
//class ProgressBar extends UIControl
//{
//	public function ProgressBar(Style:Class = null)
//	{
//		super(Style?Style:UIProgressBarStyle);
//	}
//}