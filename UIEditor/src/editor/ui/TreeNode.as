package editor.ui
{
	import flash.display.Bitmap;

	public class TreeNode
	{
		public var label:String = "";
		public var Data:Object = null;
		public var children:Array = [];
		public var _Leaf:Boolean = false;
		
		public function get leaf():Boolean
		{
			if(children.length > 0)
			{
				return true;
			}
			return false;
		}
		
		public function TreeNode()
		{
		}
	}
}