package pixel.utility
{
	public class FileObj3D
	{
		//顶点
		private var _vertex:Vector.<Number> = null;
		public function get vertex():Vector.<Number>
		{
			return _vertex;
		}
		//UV
		private var _vertexUV:Vector.<Number> = null;
		public function get vertexUV():Vector.<Number>
		{
			return _vertexUV;
		}
		//法线
		private var _normals:Vector.<Number> = null;
		//顶点索引
		private var _vertexIndex:Vector.<FileObj3DVertexIndex> = null;
		public function get vertexIndex():Vector.<FileObj3DVertexIndex>
		{
			return _vertexIndex;
		}
		
		private var _vertexIndexGroup:Vector.<FileObj3DVertexIndexGroup> = null;
		public function FileObj3D()
		{
			_vertex = new Vector.<Number>();
			_vertexUV = new Vector.<Number>();
			_normals = new Vector.<Number>();
			_vertexIndex = new Vector.<FileObj3DVertexIndex>();
			_vertexIndexGroup = new Vector.<FileObj3DVertexIndexGroup>();
		}
		
		public function addVertex(pos:Number):void
		{
			_vertex.push(pos);
		}
		
		public function addNormals(pos:Number):void
		{
			_normals.push(pos);
		}
		public function addVertexUV(pos:Number):void
		{
			_vertexUV.push(pos);
		}
		public function addVertexIndex(idx:FileObj3DVertexIndex):void
		{
			_vertexIndex.push(idx);
		}
		public function addVertexIndexGroup(group:FileObj3DVertexIndexGroup):void
		{
			_vertexIndexGroup.push(group);
		}
	}
}