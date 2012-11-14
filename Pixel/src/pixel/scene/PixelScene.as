package pixel.scene
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import pixel.core.IPixelNode;
	import pixel.core.PixelNode;

	/**
	 * 场景基类
	 * 
	 * 
	 **/
	public class PixelScene extends Sprite implements IPixelScene
	{
		private var childNodes:Vector.<IPixelNode> = null;
		
		public function PixelScene()
		{
			super();
		}
		
		[Deprecated(message="该方法无效,请使用addNode")]
		override public function addChild(child:DisplayObject):DisplayObject
		{
			return null;
		}
		
		[Deprecated(message="该方法无效,请使用removeNode")]
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			return null;
		}
		
		/**
		 * 添加节点
		 * 
		 * 
		 **/
		public function addNode(value:IPixelNode):void
		{
			if(!childNodes)
			{
				childNodes = new Vector.<IPixelNode>();
			}
			childNodes.push(value);
			super.addChild(value as Sprite);
		}
		
		/**
		 * 删除节点
		 * 
		 * 
		 **/
		public function removeNode(value:IPixelNode):void
		{
			if(value && childNodes.indexOf(value) >= 0)
			{
				childNodes.splice(childNodes.indexOf(value),1);
				super.removeChild(value as Sprite);
			}
		}
		
		/**
		 * 场景复位
		 * 
		 * 
		 **/
		public function reset():void
		{
			
		}
		
		public function get nodes():Vector.<IPixelNode>
		{
			return childNodes;
		}
		
		protected var _node:IPixelNode = null;
		
		public function update():void
		{
			for each(_node in childNodes)
			{
				_node.update();
			}
		}
	}
}