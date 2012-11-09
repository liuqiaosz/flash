package mapassistant
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.sdk.map.layer.ILayer;
	import game.sdk.map.tile.TileData;
	
	import mapassistant.event.NotifyEvent;
	import mapassistant.map.world.AreaPartitionLayer;

	public class ObjectLayer extends AreaPartitionLayer implements ILayer
	{
		protected var _ObjectDraw:Sprite = new Sprite();
		protected var _Focus:Sprite = new Sprite();
		protected var _ObjectQueue:Vector.<ObjectItem> = new Vector.<ObjectItem>();
		
		public function ObjectLayer(Row:uint = 0,Column:uint = 0,TileWidth:uint = 0,TileHeight:uint = 0)
		{
			super(Row,Column,TileWidth,TileHeight);
			//addEventListener(MouseEvent.MOUSE_MOVE,OnMove);
			
			addChild(_ObjectDraw);
		}
		
		/**
		 * 
		 * 重写图层激活函数，激活的同时开启对象图层的鼠标操作
		 **/ 
		override public function Active():void
		{
			addEventListener(MouseEvent.MOUSE_DOWN,OnPressDown);
			super.Active();
			 
		}
		override public function UnActived():void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN,OnPressDown);
			super.UnActived();
		}
		
		private var _SelectItem:ObjectItem = null;
		private var _StartPoint:Point = new Point();
		private var _DropPoint:Point = new Point();
		private var _Drag:Boolean = false;
		private function OnPressDown(event:MouseEvent):void
		{
			var SelectItem:ObjectItem = CheckObjectArea(event.stageX,event.stageY);
			if(SelectItem)
			{
				_SelectItem = SelectItem;
				var Notify:NotifyEvent = new NotifyEvent(NotifyEvent.OBJECT_SELECTED);
				Notify.Params.push(_SelectItem);
				dispatchEvent(Notify);
				Update();
			}
			else
			{
				_StartPoint.x = event.stageX;
				_StartPoint.y = event.stageY;
				_StartPoint = globalToLocal(_StartPoint);
				_Drag = true;
				stage.addEventListener(MouseEvent.MOUSE_MOVE,OnDragMove);
				stage.addEventListener(MouseEvent.MOUSE_UP,OnDrop);
				_Focus.graphics.clear();
				addChild(_Focus);
			}
		}
		
		public function RemoveObjectItem(Item:ObjectItem = null):void
		{
			if(Item)
			{
				if(_ObjectQueue.indexOf(Item) >= 0)
				{
					_ObjectQueue.splice(_ObjectQueue.indexOf(Item),1);
				}
			}
			else
			{
				if(_SelectedItem)
				{
					_ObjectQueue.splice(_ObjectQueue.indexOf(_SelectedItem),1);
				}
			}
		}
		
		private var _SelectedItem:ObjectItem = null;
		/**
		 * 检测当前鼠标所在的点是否有对象存在
		 * 
		 **/
		private function CheckObjectArea(MouseX:int,MouseY:int):ObjectItem
		{
			var Item:ObjectItem = null;
			var Pos:Point = new Point(MouseX,MouseY);
			Pos = globalToLocal(Pos);
			for each(Item in _ObjectQueue)
			{
				if(Item.Rect.containsPoint(Pos))
				{
					_SelectedItem = Item;
					return Item;
				}
			}
			return null;
		}
		
		private var _DropRect:Rectangle = new Rectangle();
		
		private function OnDrop(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,OnDragMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP,OnDrop);
			var Item:ObjectItem = new ObjectItem();
			Item.Rect = _DropRect;
			_ObjectQueue.push(Item);
			_DropRect = new Rectangle();
			removeChild(_Focus);
			Update(); 
		}
		
		private function OnDragMove(event:MouseEvent):void
		{
			_DropPoint.x = event.stageX;
			_DropPoint.y = event.stageY;
			
			_DropPoint = globalToLocal(_DropPoint);
			
			_DropRect.width = Math.abs(_DropPoint.x - _StartPoint.x);
			_DropRect.height = Math.abs(_DropPoint.y - _StartPoint.y);
			
			_DropRect.x = _DropPoint.x < _StartPoint.x ? _DropPoint.x : _StartPoint.x;
			_DropRect.y = _DropPoint.y < _StartPoint.y ? _DropPoint.y : _StartPoint.y;
			
			_Focus.graphics.clear();
			_Focus.graphics.lineStyle(2,0x6D6D6D);
			_Focus.graphics.beginFill(0x000000,0.5);
			_Focus.graphics.drawRect(_DropRect.x,_DropRect.y,_DropRect.width,_DropRect.height);
			_Focus.graphics.endFill();
		}
		
		public function AddObject(Obj:ObjectItem):void
		{
			_ObjectQueue.push(Obj);
		}
		
		override public function Render():void
		{
			var Pen:Graphics = this.graphics;
			Pen.clear();
			Pen.beginFill(0xFFFFFF,0.1);
			Pen.drawRect(0,0,this.LayerWidth,this.LayerHeight);
			Pen.endFill();
			
			var Obj:ObjectItem = null;
			for each(Obj in _ObjectQueue)
			{
				if(Obj == _SelectItem)
				{
					Pen.beginFill(0xFF0000,0.5);
				}
				else
				{
					Pen.beginFill(0x000000,0.5);
				}
				
				Pen.drawRect(Obj.Rect.x,Obj.Rect.y,Obj.Rect.width,Obj.Rect.height);
				Pen.endFill();
			}
		}
	}
}