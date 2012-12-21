package pixel.utility.data
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import pixel.utility.IDispose;
	import pixel.utility.PixelUtilityNS;
	
	use namespace PixelUtilityNS;
	/**
	 * 
	 * 四叉树节点
	 * 
	 **/
	public class QuadNode implements IDispose
	{
		private var _area:Rectangle = null;
		private var _childrenNodes:Vector.<QuadNode> = null;
		private var _children:Vector.<DisplayObject> = null;
		private var _parent:QuadNode = null;
		private var _hasChildren:Boolean = false;
		
		public function QuadNode(area:Rectangle,parent:QuadNode = null)
		{
			_childrenNodes = new Vector.<QuadNode>();
			_children = new Vector.<DisplayObject>();
			_area = area;
			_parent = parent;
		}
		
		/**
		 * 
		 * 创建一个新的子节点
		 * 
		 * @param	area	子节点管理范围
		 * 
		 **/
		public function createChildNode(area:Rectangle):QuadNode
		{
			if(_childrenNodes.length < 4)
			{
				var child:QuadNode = new QuadNode(area,this);
				_childrenNodes.push(child);
				_hasChildren = true;
				return child;
			}
			return null;
		}
		
		/**
		 * 
		 * 返回所有子节点
		 * 
		 **/
		public function get childrenNodes():Vector.<QuadNode>
		{
			return _childrenNodes;
		}
		
		public function get parent():QuadNode
		{
			return _parent;
		}
		
		/**
		 * 返回当前节点所处区域
		 * 
		 **/
		public function get area():Rectangle
		{
			return _area;
		}
		
		public function get hasChildren():Boolean
		{
			return _hasChildren;
		}
		
		public function get children():Vector.<DisplayObject>
		{
			return _children;
		}
		
		private var pos:Point = new Point();
		/**
		 * 
		 * 为当前节点添加一个范围内的对象
		 * 
		 **/
		PixelUtilityNS function addChild(child:DisplayObject):void
		{
			pos.x = child.x;
			pos.y = child.y;
			if(checkPointInArea(pos))
			{
				_children.push(child);
			}
		}
		
		/**
		 * 
		 * 检查点是否在节点范围内
		 * 
		 **/
		public function checkPointInArea(pos:Point):Boolean
		{
			if(pos.x >= _area.x && pos.y >= _area.y && pos.x < _area.x+_area.width && pos.y < _area.y + _area.height)
			{
				return true;
			}
			return false;
		}
		
		/**
		 * 
		 * 移除管理的显示对象
		 * 
		 **/
		public function removeChild(child:DisplayObject):void
		{
			var idx:int = _children.indexOf(child);
			if(idx >= 0)
			{
				_children.splice(idx,1);
			}
		}
		
		public function dispose():void
		{
			var node:QuadNode = null;
			for each(node in _childrenNodes)
			{
				node.dispose();
			}
		}
	}
}