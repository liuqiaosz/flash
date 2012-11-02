package corecom.control.event
{
	public class SliderEvent extends UIControlEvent
	{
		public static var VALUE_CHANGED:String = "ValueChanged";
		
		private var _Value:int = 0;
		public function set Value(Data:int):void
		{
			_Value = Data;
		}
		public function get Value():int
		{
			return _Value;
		}
		
		public function SliderEvent(Type:String,Bubbles:Boolean = false)
		{
			super(Type,Bubbles);
		}
	}
}