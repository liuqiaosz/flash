package death.def.scene.vo
{
	import flash.geom.Point;

	public class WorldNodeVO
	{
		public static const NODE_BATTLE:int = 1;
		public static const NODE_SHOP:int = 2;
		public static const NODE_TRAIN:int = 3;
		public static const NODE_GATE:int = 4;
		
		private var _id:int = 0;
		public function set id(value:String):void
		{
			_id = value;
		}
		public function get id():int
		{
			return _id;
		}
		private var _title:String = "";
		public function set title(value:String):void
		{
			_title = value;
		}
		public function get title():String
		{
			return _title;
		}
		private var _desc:String = "";
		public function set desc(value:String):void
		{
			_desc = value;
		}
		public function get desc():String
		{
			return _desc;
		}
		private var _type:int = NODE_BATTLE;
		public function set type(value:int):void
		{
			_type = value;
		}
		public function get type():int
		{
			return _type;
		}
		private var _portraitImageId:String = "";
		public function set portraitImageId(value:String):void
		{
			_portraitImageId = value;
		}
		public function portraitImageId():String
		{
			return _portraitImageId;
		}
		
		private var _position:Point = new Point();
		public function set position(value:Point):void
		{
			_position = value;
		}
		public function get position():Point
		{
			return _position;
		}
		
		private var _redirectId:int = 0;
		public function set redirectId(value:int):void
		{
			_redirectId = value;
		}
		public function get redirectId():int
		{
			return _redirectId;
		}
		
		public function WorldNodeVO()
		{
			
		}
	}
}