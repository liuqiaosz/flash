package pixel.utility
{
	public class FileObj3DVertexIndexGroup
	{
		private var _groupName:String = "";
		public function set groupName(value:String):void
		{
			_groupName = value;
		}
		public function get groupName():String
		{
			return _groupName;
		}
		private var _vertexIndexs:Vector.<FileObj3DVertexIndex> = null;
		
		public function FileObj3DVertexIndexGroup(name:String)
		{
			_vertexIndexs = new Vector.<FileObj3DVertexIndex>();
		}
		
		public function addVertexIndex(value:FileObj3DVertexIndex):void
		{
			_vertexIndexs.push(value);
		}
		public function get vertexIndexs():Vector.<FileObj3DVertexIndex>
		{
			return _vertexIndexs;
		}
	}
}