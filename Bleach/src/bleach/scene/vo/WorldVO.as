package bleach.scene.vo
{
	public class WorldVO
	{
		private var _id:int = 0;
		public function set id(value:int):void
		{
			_id = value;
		}
		public function get id():int
		{
			return _id;
		}
		
		private var _bgImageId:String = "";
		public function set bgImageId(value:String):void
		{
			_bgImageId = value;
		}
		public function get bgImageId():String
		{
			return _bgImageId;
		}
		private var _nodes:Vector.<WorldNodeVO> = null;
		public function set nodes(value:Vector.<WorldNodeVO>):void
		{
			_nodes = value;
		}
		public function get nodes():Vector.<WorldNodeVO>
		{
			return _nodes;
		}
		
		public function WorldVO()
		{
			_nodes = new Vector.<WorldNodeVO>();
		}
	}
}