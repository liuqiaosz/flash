package pixel.ui.control.style
{
	import flash.utils.ByteArray;
	
	import pixel.ui.control.LayoutConstant;

	/**
	 * 容器组件样式
	 * 
	 * 所有容器类型组件如果要定义皮肤都必须从该样式继承
	 **/
	public class UIContainerStyle extends UIStyle
	{
		private var _Gap:int = 0;
		public function UIContainerStyle()
		{
			super();
		}
		
		public function set Gap(Value:int):void
		{
			_Gap = Value;
		}
		public function get Gap():int
		{
			return _Gap;
		}
		
		private var _padding:int = 0;
		public function set padding(value:int):void
		{
			_padding = value;
		}
		public function get padding():int
		{
			return _padding;
		}

		private var _Layout:uint = LayoutConstant.ABSOLUTE;
		public function set Layout(Value:uint):void
		{
			_Layout = Value;
		}
		public function get Layout():uint
		{
			return _Layout;
		}
		
		override public function encode():ByteArray
		{
			var Data:ByteArray = super.encode();
			Data.writeByte(_Gap);
			Data.writeByte(_Layout);
			Data.writeByte(_padding);
			return Data;
		}
		override public function decode(Data:ByteArray):void
		{
			super.decode(Data);
			_Gap = Data.readByte();
			_Layout = Data.readByte();
			_padding = Data.readByte();
		}
	}
}