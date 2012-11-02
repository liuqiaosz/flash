package corecom.control.event
{
	import corecom.control.ComboboxItem;

	public class ComboboxEvent extends UIControlEvent
	{
		public static const SELECT:String = "ItemSelect";
		private var _Item:ComboboxItem = null;
		
		public function set Item(Value:ComboboxItem):void
		{
			_Item = Value;
		}
		public function get Item():ComboboxItem
		{
			return _Item;
		}
		public function ComboboxEvent(Type:String,Bubbles:Boolean = false)
		{
			super(Type,Bubbles);
		}
		
		
	}
}