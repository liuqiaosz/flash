package pixel.ui.control.style
{
	import flash.utils.ByteArray;

	/**
	 * 
	 * 滑动组件样式
	 * 
	 **/
	public class SimpleSliderStyle extends UIContainerStyle
	{
		/**
		 * 滑动线的宽度
		 **/
		private var _SliderLineHeight:int = 1;
		public function set SliderLineHeight(Value:int):void
		{
			_SliderLineHeight = Value;
		}
		public function get SliderLineHeight():int
		{
			return _SliderLineHeight;
		}
		/**
		 * 滑动线的颜色
		 **/
		private var _SliderLineColor:uint = 0xFF0000;
		public function set SliderLineColor(Value:uint):void
		{
			_SliderLineColor = Value;
		}
		public function get SliderLineColor():uint
		{
			return _SliderLineColor;
		}
		
		public function SimpleSliderStyle()
		{
			super();
			this.BackgroundAlpha = 0;
		}
		
		override public function Encode():ByteArray
		{
			var Data:ByteArray = super.Encode();
			Data.writeShort(_SliderLineHeight);
			Data.writeFloat(_SliderLineColor);
			return Data;
		}
		
		override public function Decode(Data:ByteArray):void
		{
			super.Decode(Data);
			_SliderLineHeight = Data.readShort();
			_SliderLineColor = Data.readFloat();
		}
	}
}