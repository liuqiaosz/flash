package pixel.utility
{
	public class FileObj3DVertexIndex
	{
		private var _vertexIdx:int = 0;
		public function set vertexIdx(value:int):void
		{
			_vertexIdx = value;
		}
		public function get vertexIdx():int
		{
			return _vertexIdx;
		}
		private var _uvIdx:int = 0;
		public function set uvIdx(value:int):void
		{
			_uvIdx = value;
		}
		public function get uvIdx():int
		{
			return _uvIdx;
		}
		private var _normalsIdx:int = 0;
		public function set normalsIdx(value:int):void
		{
			_normalsIdx = value;
		}
		public function get normalsIdx():int
		{
			return _normalsIdx;
		}
		public function FileObj3DVertexIndex()
		{
		}
	}
}