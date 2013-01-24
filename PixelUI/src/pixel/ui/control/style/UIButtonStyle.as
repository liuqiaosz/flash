package pixel.ui.control.style
{
	//import corecom.control.FontTextFactory;
	import flash.utils.ByteArray;

	/**
	 * 按钮基本样式
	 **/
	public class UIButtonStyle extends UIStyle
	{
		protected var _OverStyle:IVisualStyle = null;
		public function get OverStyle():IVisualStyle
		{
			return _OverStyle;
		}
		protected var _PressStyle:IVisualStyle = null;
		public function get PressStyle():IVisualStyle
		{
			return _PressStyle;
		}
		public function UIButtonStyle()
		{
			super();
			_OverStyle = new UIStyle();
			_PressStyle = new UIStyle();
			
//			_OverStyle.LeftBottomCorner = _OverStyle.LeftTopCorner = _OverStyle.RightBottomCorner = _OverStyle.RightTopCorner = 4;
//			_PressStyle.LeftBottomCorner = _PressStyle.LeftTopCorner = _PressStyle.RightBottomCorner = _PressStyle.RightTopCorner = 4;
//			this.LeftBottomCorner = this.LeftTopCorner = this.RightBottomCorner = this.RightTopCorner = 4;
		}
		
		override public function dispose():void
		{
			super.dispose();
			_OverStyle.dispose();
			_PressStyle.dispose();
		}
		
//		private var _Text:String = "";
//		public function set Text(Value:String):void
//		{
//			_Text = Value;
//		}
//		public function get Text():String
//		{
//			return _Text;
//		}
		/**
		 * 样式编码
		 **/
		override public function encode():ByteArray
		{
			var Data:ByteArray = super.encode();
			
			var OverStyleData:ByteArray = _OverStyle.encode();
			OverStyleData.position = 0;
			Data.writeBytes(OverStyleData,0,OverStyleData.length);
			
			var PressStyleData:ByteArray = _PressStyle.encode();
			PressStyleData.position = 0;
			Data.writeBytes(PressStyleData,0,PressStyleData.length);
			return Data;
		}
		
		/**
		 * 样式解码
		 **/
		override public function decode(Data:ByteArray):void
		{
			super.decode(Data);
			_OverStyle.decode(Data);
			_PressStyle.decode(Data);
		}
		
		override public function set ImagePack(Value:Boolean):void
		{
			super.ImagePack = _OverStyle.ImagePack = _PressStyle.ImagePack = Value;
		}
	}
}