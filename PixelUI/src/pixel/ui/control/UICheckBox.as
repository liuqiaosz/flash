package pixel.ui.control
{
	import flash.utils.ByteArray;

	public class UICheckBox extends UIContainer
	{
		private var _btn:UICheckButton = null;
		private var _label:UITextBase = null;
		
		public function UICheckBox()
		{
			super();
			this.BorderThinkness = 0;
			this.BackgroundAlpha = 0;
			super.Layout = LayoutConstant.HORIZONTAL;
		}
		
		/**
		 * 初始化默认样式和布局
		 **/
		override public function initializer():void
		{
			_btn = new UICheckButton();
			_btn.width = 15;
			_btn.height = 15;
			addChild(_btn);
			super.Gap = 3;
			_label = new UITextBase();
			addChild(_label);
			
			this.width = 50;
			this.height = 17;
			_label.text = "Label";
		}
		
		override protected function SpecialDecode(Data:ByteArray):void
		{
			_btn = new UICheckButton();
			Data.readByte();
			_btn.decode(Data);
			Data.readByte();
			_label = new UITextBase();
			_label.decode(Data);
			
			addChild(_btn);
			addChild(_label);
		}
		
		override protected function SpecialEncode(Data:ByteArray):void
		{
			var data:ByteArray = _btn.encode();
			Data.writeBytes(data,0,data.length);
			
			data = _label.encode();
			Data.writeBytes(data,0,data.length);
		}
		
		public function get labelField():UITextBase
		{
			return _label;
		}
		
		public function get boxField():UICheckButton
		{
			return _btn;
		}
		
		override public function EnableEditMode():void
		{
			
			this.mouseChildren = false;
			super.EnableEditMode();
		}
		
		public function set label(value:String):void
		{
			_label.text = value;
		}
		public function get label():String
		{
			return _label.text;
		}
		
		public function get selected():Boolean
		{
			return _btn.selected;
		}
		
		override public function set Layout(Value:uint):void
		{
		}
	}
}