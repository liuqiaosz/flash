package game.sdk.math.astar
{
	public class AstarNode
	{
		public var G:int = 0;
		public var H:int = 0;
		public var F:int = 0;
		public var pr:uint = 0;
		public var pc:uint = 0;
		//public var size:int = 0;
		public var width:uint = 0;
		public var height:uint = 0;
		public var walk:Boolean = false;
		public var parent:AstarNode = null;
		public var InClose:Boolean = false;
		public function AstarNode(pr:uint,pc:uint,width:uint,height:uint,walk:Boolean)
		{
			this.pr = pr;
			this.pc = pc;
			//this.size = size;
			this.width = width;
			this.height = height;
			this.walk = walk;
		}
	}
}