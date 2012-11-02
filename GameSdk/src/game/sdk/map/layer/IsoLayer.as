package game.sdk.map.layer
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import game.sdk.map.tile.GenericTile;
	
	/**
	 * 
	 * ISO对象容器层
	 * 
	 **/
	public class IsoLayer extends Sprite implements ILayer
	{
		private var ChildrenArray:Vector.<Vector.<GenericTile>> = new Vector.<Vector.<GenericTile>>();
		
		private var Children:Array = [];
		private var Row:int = 0;
		private var Column:int = 0;
		private var TileSize:int = 0;
		public function IsoLayer(Row:int,Column:int,TileSize:int)
		{
			this.Row = Row;
			this.Column = Column;
			this.TileSize = TileSize;
		}
		
		public function get Childrens():Array
		{
			return Children;
		}
		
		/**
		 * 
		 * 获取TILE组
		 * 
		 **/
		public function FindGridGroup(AnchorTile:GenericTile,Row:int,Column:int):Array
		{
			var Group:Array = [];
			if(AnchorTile)
			{
				for(var RowIdx:int = 0; RowIdx<Row; RowIdx++)
				{
					for(var ColIdx:int = 0; ColIdx<Column; ColIdx++)
					{
						if(ChildrenArray.length > RowIdx+AnchorTile.TileRow && ChildrenArray[RowIdx+AnchorTile.TileRow].length > ColIdx + AnchorTile.TileColumn)
						{
							Group.push(ChildrenArray[RowIdx+AnchorTile.TileRow][ColIdx + AnchorTile.TileColumn]);
						}
					}
				}
			}
			return Group;
		}
		
		public function Render():void
		{
			
		}
		
		public function GridLineSwitch():void
		{
		}
		
		public function FindGridByStageMouse():GenericTile
		{
			var Local:Point = new Point(stage.mouseX,stage.mouseY);
			var Childs:Array = stage.getObjectsUnderPoint(Local);
			if(Childs.length > 0)
			{
				for(var Idx:int=0; Idx<Childs.length; Idx++)
				{
					if(Childs[Idx] is GenericTile)
					{
						return Childs[Idx];	
					}
				}
			}
			return null;	
		}
		
		public function InitializeGridTile():Vector.<Vector.<GenericTile>>
		{
			//创建网格对象
			for(var RowIndex:int=0; RowIndex<Row; RowIndex++)
			{
				ChildrenArray[RowIndex] = new Vector.<GenericTile>();
				for(var ColIndex:int=0; ColIndex<Column; ColIndex++)
				{
					var Tile:GenericTile = new GenericTile(RowIndex,ColIndex,TileSize);
					Tile.Initialize();
					ChildrenArray[RowIndex][ColIndex] = Tile;
					addChild(Tile);
				}
			}
			return ChildrenArray;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			Children[Children.length] = child;
			return super.addChild(child);
		}
		
		public function UpdateChildrenDepth():void
		{
			Children.sortOn("Depth",Array.NUMERIC);
			for(var Idx:int=0; Idx<Children.length; Idx++)
			{
				this.setChildIndex(Children[Idx],Idx);
			}
		}
	}
}