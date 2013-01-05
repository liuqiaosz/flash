package pixel.core
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import pixel.message.IPixelMessage;
	import pixel.message.PixelMessageBus;
	
	use namespace PixelNs;
	/**
	 * 场景基类
	 * 
	 * 
	 **/
	public class PixelLayer extends PixelSprite implements IPixelLayer
	{
		private var childNodes:Vector.<IPixelNode> = null;
		private var _id:String = "";
		public function PixelLayer(id:String = "")
		{
			super(null);
			this.initializer();
		}
		
		public function get id():String
		{
			return _id;
		}
		public function set id(value:String):void
		{
			_id = value;
		}
		
		public function initializer():void
		{
			
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
		 * 清除所有节点
		 **/
		public function clearNodes():void
		{
			var node:IPixelNode = null;
			for each(node in childNodes)
			{
				removeNode(node);
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
		override public function update():void
		{
			for each(_node in childNodes)
			{
				_node.update();
			}
		}
	}
}