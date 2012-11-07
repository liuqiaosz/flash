package mapassistant
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import game.sdk.map.layer.ILayer;
	
	import mapassistant.event.NotifyEvent;
	
	import utility.ISerializable;

	public class World extends Sprite implements ISerializable
	{
		protected var _LayerQueue:Vector.<WorldLayerItem> = null;
		protected var _Row:int = 0;
		protected var _Column:int = 0;
		protected var _TileWidth:int = 0;
		protected var _TileHeight:int = 0;
		protected var _LayerClass:Class = null;
		protected var _TopLayer:ILayer = null;
		
		public function World(Row:int,Column:int,TileWidth:int,TileHeight:int,LayerClass:Class)
		{
			_Row = Row;
			_Column = Column;
			_TileWidth = TileWidth;
			_TileHeight = TileHeight;
			_LayerClass = LayerClass;
			_LayerQueue = new Vector.<WorldLayerItem>();
			
			//创建默认图层
			var Default:ILayer = new _LayerClass() as ILayer;
			if(Default)
			{
				Default.LayerUpdate(_Row,_Column,_TileWidth,_TileHeight);
				var LayerItem:WorldLayerItem = new WorldLayerItem(Default);
				LayerItem.LayerName = "Layer" +  _LayerQueue.length;
				_LayerQueue.push(LayerItem);
				addChild(Default  as DisplayObject);
				_TopLayer = Default;
			}
			
			CreateObjectLayer();
		}
		
		public function get WorldWidth():int
		{
			return _TileWidth * _Column;
		}
		public function get WorldHeight():int
		{
			return _TileHeight * _Row;
		}
		
		/**
		 *  创建新图层
		 * 
		 * 
		 **/
		public function CreateLayer():WorldLayerItem
		{
			var Layer:ILayer = new _LayerClass() as ILayer;
			if(Layer)
			{
				Layer.LayerUpdate(_Row,_Column,_TileWidth,_TileHeight);
				var LayerItem:WorldLayerItem = new WorldLayerItem(Layer);
				LayerItem.LayerName = "Layer" +  _LayerQueue.length;
				_LayerQueue.push(LayerItem);
				addChild(Layer  as DisplayObject);
				if(_TopLayer)
				{
					
				}
				_TopLayer = Layer;
				LayerUpdateNotify();
				return LayerItem;
			}
			return null;
		}
		
		/**
		 * 创建新的对象图层
		 * 
		 * 
		 **/
		public function CreateObjectLayer():WorldLayerItem
		{
			var Layer:ILayer = new ObjectLayer();
			if(Layer)
			{
				Layer.LayerUpdate(_Row,_Column,_TileWidth,_TileHeight);
				var LayerItem:WorldLayerItem = new WorldLayerItem(Layer);
				LayerItem.LayerName = "Object" +  _LayerQueue.length;
				_LayerQueue.push(LayerItem);
				addChild(Layer as DisplayObject);
				LayerUpdateNotify();
				_TopLayer = Layer;
				return LayerItem;
			}
			return null;
		}
		
		public function RemoveLayer(LayerItem:WorldLayerItem):void
		{
			if(_LayerQueue.indexOf(LayerItem) >= 0)
			{
				_LayerQueue.splice(_LayerQueue.indexOf(LayerItem),1);
				LayerUpdateNotify();
			}
		}
		
		/**
		 * 层更新通知事件
		 * 
		 * 
		 **/
		private function LayerUpdateNotify():void
		{
			dispatchEvent(new NotifyEvent(NotifyEvent.WORLD_LAYERUPDATE));
		}
		
		public function get Layers():Vector.<WorldLayerItem>
		{
			return _LayerQueue;
		}
	
		
		public function Encode():ByteArray
		{
			return null;
		}
		public function Decode(Data:ByteArray):void
		{
		}
	}
}