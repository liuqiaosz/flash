package corecom.control
{
	public class ComboboxItem
	{
		protected var _Label:String = "";
		public function set Label(Value:String):void
		{
			_Label = Value;
		}
		public function get Label():String
		{
			return _Label;
		}
		protected var _Value:String = "";
		public function set Value(Data:String):void
		{
			_Value = Data;
		}
		public function get Value():String
		{
			return _Value;
		}
		public function ComboboxItem(LabelV:String = "",ValueV:String = "")
		{
			_Label = LabelV;
			_Value = ValueV;
		}
	}
}