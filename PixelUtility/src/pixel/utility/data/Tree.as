package pixel.utility.data
{
	public class Tree
	{
		private var _size:int = 0;
		public function Tree(size:int = 2)
		{
			_size = size;
		}
		
		public function get size():int
		{
			return _size;
		}
	}
}