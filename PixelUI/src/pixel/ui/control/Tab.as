package pixel.ui.control
{
	import pixel.ui.control.event.TabPanelEvent;
	import pixel.ui.control.style.TabStyle;
	import pixel.ui.control.utility.ButtonState;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;

	public class Tab extends UIButton
	{
		private var _Actived:Boolean = false;
		public function Tab(Skin:Class = null)
		{
			var SkinClass:Class = Skin ? Skin : TabStyle;
			super(SkinClass);
			Text = "Tab";
		}
		
		/**
		 * 重写按钮的鼠标弹起事件和滑出事件
		 **/
		override protected function EventMouseUp(event:MouseEvent):void
		{
			//Update();
		}
		
		override protected function EventMouseOut(event:MouseEvent):void
		{
			if(!_Actived)
			{
				super.EventMouseOut(event);
			}
		}
		
		override protected function EventMouseDown(event:MouseEvent):void
		{
			super.EventMouseDown(event);
			_Actived = true;
		}
		
		public function Actived():void
		{
			_Actived = true;
			State = ButtonState.DOWN;
			Update();
		}
		
		public function UnActived():void
		{
			_Actived = false;
			State = ButtonState.NORMAL;
			Update();
		}
		
		override public function encode():ByteArray
		{
			State = ButtonState.NORMAL;
			return super.encode();
		}
		
		override public function decode(Data:ByteArray):void
		{
			//先对当前状态进行重置后再进行解码
			State = ButtonState.NORMAL;
			
			super.decode(Data);
		}
	}
}