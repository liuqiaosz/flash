package mapassistant.assetblock
{
	public class AssetBlockSelectGroup
	{
		private var _Nodes:Vector.<BlockImageNode> = null;
		public function get Nodes():Vector.<BlockImageNode>
		{
			return _Nodes;
		}
		private var _Row:int = 0;
		public function get Row():int
		{
			return _Row;
		}
		private var _Column:int = 0;
		public function get Column():int
		{
			return _Column;
		}
		public function AssetBlockSelectGroup(Row:int,Column:int,Group:Vector.<BlockImageNode>)
		{
			_Row = Row;
			_Column = Column;
			_Nodes = Group;
		}
	}
}