package pixel.ui.control.style
{
	import pixel.ui.control.LayoutConstant;
	
	import flash.utils.ByteArray;

	/**
	 * 容器组件样式
	 * 
	 * 所有容器类型组件如果要定义皮肤都必须从该样式继承
	 **/
	public class ContainerStyle extends UIStyle
	{
		private var _Gap:int = 0;
		public function ContainerStyle()
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

		private var _Layout:uint = LayoutConstant.ABSOLUTE;
		public function set Layout(Value:uint):void
		{
			_Layout = Value;
		}
		public function get Layout():uint
		{
			return _Layout;
		}
		
		override public function Encode():ByteArray
		{
			var Data:ByteArray = super.Encode();
			Data.writeByte(_Gap);
			Data.writeByte(_Layout);
			return Data;
		}
		override public function Decode(Data:ByteArray):void
		{
			super.Decode(Data);
			_Gap = Data.readByte();
			_Layout = Data.readByte();
		}
	}
}