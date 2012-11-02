package game.sdk.data
{
	import flash.utils.ByteArray;

	public class ByteVector extends ByteArray
	{
		public function ByteVector()
		{
			super();
		}
		
		private var Pos:int = 0;
		public function GetValue(Row:uint,Column:uint):int
		{
			Pos = Row * Column + Column;
			if(Pos < this.length)
			{
				position = Row * Column + Column;
				return readByte();
			}
			return -1;
		}
	}
	
}