package mapassistant
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import game.sdk.map.layer.ILayer;
	import game.sdk.map.tile.TileData;
	
	import mapassistant.map.world.AreaPartitionLayer;

	public class ObjectLayer extends AreaPartitionLayer implements ILayer
	{
		protected var _ObjectQueue:Vector.<ObjectItem> = new Vector.<ObjectItem>();
		
		public function ObjectLayer(Row:uint = 0,Column:uint = 0,TileWidth:uint = 0,TileHeight:uint = 0)
		{
			super(Row,Column,TileWidth,TileHeight);
		}
		
		public function AddObject(Obj:ObjectItem):void
		{
			_ObjectQueue.push(Obj);
		}
		
		override public function Render():void
		{
			var Pen:Graphics = this.graphics;
			Pen.clear();
			
//			var Grid:Vector.<Vector.<TileData>> = this.Grid;
//			var Row:uint = 0;
//			var Col:uint = 0;
//			var GridRow:uint = Grid.length;
//			var GridColumn:uint = Grid[0].length;
//			var Width:uint = GridColumn * this._GridTileWidth;
//			var Height:uint = GridRow * this._GridTileHeight;
			Pen.beginFill(0x5D5D5D,0.2);
			Pen.drawRect(0,0,this.LayerWidth,this.LayerHeight);
			Pen.endFill();
			Pen.lineStyle(2,0x5d5d5d);
			var Obj:ObjectItem = null;
			for each(Obj in _ObjectQueue)
			{
				Pen.drawRect(Obj.Rect.x,Obj.Rect.y,Obj.Rect.width,Obj.Rect.height);
			}
		}
	}
}