package game.sdk.map.tile
{
	public class Position3D extends Position2D
	{
		public var z:Number = 0;
		public var Depth:int = 0;
		public function Position3D(x:Number=0,y:Number=0,z:Number=0)
		{
			super(x,y);
			this.z = z;
		}
	}
}