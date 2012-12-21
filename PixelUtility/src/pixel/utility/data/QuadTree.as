package pixel.utility.data
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import mx.controls.Tree;
	
	import pixel.utility.PixelUtilityNS;
	
	use namespace PixelUtilityNS;
	
	/**
	 * 四叉树
	 * 
	 **/
	public class QuadTree
	{
		//顶层节点
		private var _root:QuadNode = null;
		//层级
		private var _layer:int = 0;
		
		private var _treeArea:Rectangle = null;
		
		//最小节点的区域大小
		private var _minWidth:Number = 0;
		private var _minHeight:Number = 0;
		
		private var _childDictCache:Dictionary = null;
		
		/**
		 * @param rect		四叉树范围
		 * @param layer		层级
		 * 
		 **/
		public function QuadTree(area:Rectangle,layer:int = 2)
		{
			_layer = layer + 1;
			_treeArea = area;
			_root = new QuadNode(_treeArea);
			
			_minWidth = area.width / Math.pow(2,_layer);
			_minHeight = area.height / Math.pow(2,_layer);
			
			_childDictCache = new Dictionary();
			initializer();
		}
		
		/**
		 * 
		 * 初始化树
		 * 
		 **/
		protected function initializer():void
		{
			buildNodes(_root);
		}
		
		/**
		 * 
		 * 创建节点
		 * 
		 **/
		protected function buildNodes(node:QuadNode):void
		{
			if(!node || node.area.width <= _minWidth || node.area.height <= _minHeight)
			{
				return;
			}
			var idx:int = 0;
			for(idx; idx<4; idx++)
			{
				var area:Rectangle = new Rectangle(
					node.area.x + (idx % 2) + node.area.width * .5,
					node.area.y + int(idx > 1) + node.area.height * .5,
					node.area.width * .5,node.area.height * .5
				);
				var child:QuadNode = node.createChildNode(area);
				buildNodes(child);
			}
		}
		
		/**
		 * 
		 * 通过坐标查找结点
		 * 
		 * @param	pos		要查找的坐标
		 * @param	node	当前节点
		 **/
		protected function searchNodeByPoint(pos:Point,node:QuadNode):QuadNode
		{
			if(node.hasChildren)
			{
				var children:Vector.<QuadNode> = node.childrenNodes;
				var child:QuadNode = null;
				for each(child in children)
				{
					if(child.checkPointInArea(pos))
					{
						node = searchNodeByPoint(pos,child);
					}						
				}
			}
			return node;
		}
		
		/**
		 * 
		 * 查找指定范围的节点
		 * 
		 **/
		protected function searchChildsByArea(childs:Vector.<DisplayObject>,node:QuadNode,area:Rectangle):void
		{
			if(!area.intersects(node.area))
			{
				return;
			}
			if(node.hasChildren)
			{
				var children:Vector.<QuadNode> = node.childrenNodes;
				var child:QuadNode = null;
				for each(child in children)
				{
					if(child.area.intersects(area))
					{
						searchChildsByArea(childs,child,area);
					}
				}
			}
			else
			{
				var objs:Vector.<DisplayObject> = node.children;
				var obj:DisplayObject = null;
				var checkArea:Rectangle = new Rectangle();
				for each(obj in objs)
				{
					checkArea.x = obj.x;
					checkArea.y = obj.y;
					checkArea.width = obj.width;
					checkArea.height = obj.height;
					
					if(area.intersects(checkArea))
					{
						childs.push(obj);
					}
				}
			}
		}
		
		/**
		 * 
		 * 更新显示对象
		 * 
		 **/
		public function updateChild(child:DisplayObject):void
		{
			if(child in _childDictCache)
			{
				var node:QuadNode = _childDictCache[child];
				var pos:Point = new Point(child.x,child.y);
				if(!node.checkPointInArea(pos))
				{
					node.removeChild(child);
					//在重新遍历之前首先检查当前所处节点的父节点
					var parent:QuadNode = node.parent;
					if(parent)
					{
						if(!parent.checkPointInArea(pos))
						{
						
							addChild(child);
						}
						else
						{
							node = searchNodeByPoint(pos,parent);
							node.addChild(child);
						}
					}
				}
			}
		}
		
		/**
		 * 
		 * 从当前树移除一个对象
		 * 
		 **/
		public function removeChild(child:DisplayObject):void
		{
			if(child in _childDictCache)
			{
				var node:QuadNode = _childDictCache[child];
				var idx:int = node.children.indexOf(child);
				if(idx >= 0)
				{
					node.children.splice(idx,1);
					delete _childDictCache[child];
				}
			}
		}
		
		/**
		 * 
		 * 添加一个显示对象到当前树
		 * 
		 * @param	child	显示对象
		 **/
		public function addChild(child:DisplayObject):QuadNode
		{
			var node:QuadNode = searchNodeByPoint(new Point(child.x,child.y),_root);
			if(node)
			{
				node.addChild(child);
				_childDictCache[child] = node;
			}
			return node;
		}
	}
}