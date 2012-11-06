package corecom.control.style
{
	//import corecom.control.FontTextFactory;
	
	import flash.utils.ByteArray;

	/**
	 * 按钮基本样式
	 **/
	public class UIButtonStyle extends UIStyle
	{
		private var _OverStyle:IVisualStyle = null;
		public function get OverStyle():IVisualStyle
		{
			return _OverStyle;
		}
		private var _PressStyle:IVisualStyle = null;
		public function get PressStyle():IVisualStyle
		{
			return _PressStyle;
		}
		public function UIButtonStyle()
		{
			super();
			_OverStyle = new UIStyle();
			_PressStyle = new UIStyle();
		}
		
		private var _Text:String = "";
		public function set Text(Value:String):void
		{
			_Text = Value;
		}
		public function get Text():String
		{
			return _Text;
		}
		/**
		 * 样式编码
		 **/
		override public function Encode():ByteArray
		{
			var Data:ByteArray = super.Encode();
			
			var OverStyleData:ByteArray = _OverStyle.Encode();
			OverStyleData.position = 0;
			Data.writeBytes(OverStyleData,0,OverStyleData.length);
			
			var PressStyleData:ByteArray = _PressStyle.Encode();
			PressStyleData.position = 0;
			Data.writeBytes(PressStyleData,0,PressStyleData.length);
			return Data;
		}
		
		/**
		 * 样式解码
		 **/
		override public function Decode(Data:ByteArray):void
		{
			super.Decode(Data);
			_OverStyle.Decode(Data);
			_PressStyle.Decode(Data);
		}
	}
}