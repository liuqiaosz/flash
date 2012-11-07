package mapassistant.ui
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import game.sdk.map.tile.GenericBox;
	import game.sdk.map.tile.GenericTile;
	
	import utility.IDispose;
	
	
	/**
	 * 
	 * 元件占用网格预览
	 * 
	 **/
	public class SymbolGridShowcase extends Sprite implements IDispose
	{
		private var Layer:Sprite = null;
		private var TileVector:Vector.<GenericTile> = null;
		//基准Tile
		public var Anchor:GenericTile = null;
		
		public var Resource:Bitmap = null;
		
		private var ResourceSprite:Sprite = null;
		
		private var Drag:Boolean = false;
		
		//资源图片拖动时的通知回调函数
		public var OnResourceDragMoveNotify:Function = null;
		
		public function SymbolGridShowcase()
		{
			Layer = new Sprite();
			TileVector = new Vector.<GenericTile>();
			ResourceSprite = new Sprite();
			addChild(Layer);
		}
		
		/**
		 * 
		 * 更新资源偏移量
		 * 
		 **/
		public function UpdateResourceOffset(OffsetX:int,OffsetY:int):void
		{
			//ResourceSprite.x = Anchor.x + OffsetX;
			//ResourceSprite.y = Anchor.y + OffsetY;
			ResourceSprite.x = OffsetX;
			ResourceSprite.y = OffsetY;
		}
		
		/**
		 * 
		 * 更新网格预览
		 * 
		 **/
		public function UpdateShowcase(Row:int,Column:int,Size:int,Height:int):void
		{
			while(TileVector.length > 0)
			{
				Layer.removeChild(TileVector.shift());
			}
			
			//创建网格对象
			for(var RowIndex:int=0; RowIndex<Row; RowIndex++)
			{
				for(var ColIndex:int=0; ColIndex<Column; ColIndex++)
				{
					var Tile:GenericBox = new GenericBox(RowIndex,ColIndex,Size,Height);
					Tile.Color = 0xFF0000;
					Tile.Initialize();
					Layer.addChild(Tile);
					TileVector.push(Tile);
				}
			}
			
			Layer.x = width >> 1;
			Layer.y = height >> 1;
			
			Anchor = TileVector[0];
			Anchor.Color = 0x00FF00;
			Anchor.alpha = 0.5;
			Anchor.Update();
			if(ResourceSprite)
			{
				ResourceSprite.x = Anchor.Pos2D.x;
				ResourceSprite.y = Anchor.Pos2D.y;
			}
			
			if(!Layer.contains(ResourceSprite))
			{
				Resource.alpha = 0.5;
				ResourceSprite.addChild(Resource);
				Layer.addChild(ResourceSprite);
				if(Drag)
				{
					ResourceSprite.addEventListener(MouseEvent.MOUSE_DOWN,ResourceDragStart);
				}
			}
		}
		/**
		 * 
		 * 拖拽开始
		 * 
		 **/
		private function ResourceDragStart(event:MouseEvent):void
		{
			OffsetX = event.localX;
			OffsetY = event.localY;
			stage.addEventListener(MouseEvent.MOUSE_MOVE,ResourceDragMove);
			stage.addEventListener(MouseEvent.MOUSE_UP,ResourceDragStop);
		}
		
		private var OffsetX:int = 0;
		private var OffsetY:int = 0;
		
		/**
		 * 
		 * 拖拽资源移动
		 * 
		 **/
		private function ResourceDragMove(event:MouseEvent):void
		{
			var Pos:Point = Layer.globalToLocal(new Point(event.stageX,event.stageY));
			ResourceSprite.x = (Pos.x - OffsetX);
			ResourceSprite.y = (Pos.y - OffsetY);
			if(OnResourceDragMoveNotify != null)
			{
				OnResourceDragMoveNotify(ResourceSprite.x,ResourceSprite.y);
			}
		}
		
		/**
		 * 
		 * 
		 * 停止资源拖拽
		 * 
		 **/
		private function ResourceDragStop(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,ResourceDragMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP,ResourceDragStop);
		}
		
		public function EnableDrag():void
		{
			Drag = true;
		}
		public function DisableDrag():void
		{
			Drag = false;
		}
		
		public function Dispose():void
		{
			while(TileVector.length > 0)
			{
				Layer.removeChild(TileVector.shift());
			}
			
			removeChild(Layer);
			TileVector = null;
			Layer = null;
		}
	}
}