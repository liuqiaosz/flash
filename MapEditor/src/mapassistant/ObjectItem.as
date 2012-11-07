package mapassistant
{
	import flash.geom.Rectangle;

	public class ObjectItem
	{
		private var _Rect:Rectangle = null;
		public function set Rect(Value:Rectangle):void
		{
			_Rect = Value;
		}
		public function get Rect():Rectangle
		{
			return _Rect;
		}
		private var _Type:int = 0;
		public function set Type(Value:int):void
		{
			_Type = Value;
		}
		public function get Type():int
		{
			return _Type;
		}
		private var _Name:String = "";
		public function set Name(Value:String):void
		{
			_Name = Value;
		}
		public function get Name():String
		{
			return _Name;
		}
		
		public function ObjectItem()
		{
		}
	}
}