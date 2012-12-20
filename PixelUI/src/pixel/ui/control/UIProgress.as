package pixel.ui.control
{
	import com.greensock.TweenLite;
	import com.greensock.core.TweenCore;
	
	import flash.utils.ByteArray;
	
	import pixel.ui.control.style.UIProgressStyle;

	public class UIProgress extends UIContainer
	{
		private var _ProgressBar:UIProgressBar = null;
		public function UIProgress(Style:Class = null)
		{
			super(Style?Style:UIProgressStyle);
			_ProgressBar =  new UIProgressBar();
			
			addChild(_ProgressBar);
			width = 150;
			height = 30;
		}
		
		private var _TweenEnable:Boolean = true;
		public function set TweenEnable(Value:Boolean):void
		{
			_TweenEnable = Value;
		}
		public function get TweenEnable():Boolean
		{
			return _TweenEnable;
		}
		
		public function get progressBar():UIProgressBar
		{
			return _ProgressBar;
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
		
		override protected function SpecialEncode(Data:ByteArray):void
		{
			var data:ByteArray = _ProgressBar.encode();
			Data.writeBytes(data);
		}
		override protected function SpecialDecode(Data:ByteArray):void
		{
			Data.readByte();
			_ProgressBar.decode(Data);
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