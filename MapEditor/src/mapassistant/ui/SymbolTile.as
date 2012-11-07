package mapassistant.ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import game.sdk.map.tile.GenericBox;
	import game.sdk.map.tile.GenericIso;
	import game.sdk.map.tile.GenericTile;
	
	import mapassistant.data.table.TableSymbol;
	import mapassistant.resource.Resource;
	import mapassistant.resource.ResourceItem;
	import mapassistant.symbol.BitmapSymbol3D;
	import mapassistant.symbol.GenericSymbol;
	
	import utility.BitmapTools;

	public class SymbolTile extends GenericIso
	{
		private var _Symbol:GenericSymbol = null;
		private var Resource:ResourceItem = null;
		
		private var _Img:Bitmap = null;
		public function get Img():Bitmap
		{
			return _Img;
		}
		public function SymbolTile(Symbol:GenericSymbol,Resource:ResourceItem):void
		{
			this._Symbol = Symbol;
			this.Resource = Resource;
			
			_Img = new Bitmap(BitmapTools.BitmapClone(Bitmap(Resource.Source).bitmapData));
			addChild(_Img);
			if(_Symbol.Type == GenericSymbol.TYPE_IMAGE_3D)
			{
				var Symbol3D:BitmapSymbol3D = _Symbol as BitmapSymbol3D;
				//创建网格对象
				for(var RowIndex:int=0; RowIndex<Symbol3D.SymbolColumn; RowIndex++)
				{
					for(var ColIndex:int=0; ColIndex<Symbol3D.SymbolRow; ColIndex++)
					{
						var Tile:GenericBox = new GenericBox(RowIndex,ColIndex,Symbol3D.SymbolSize,0);
						Tile.Color = 0xFF0000;
						Tile.Initialize();
						addChild(Tile);
					}
				}
				_Img.x = Symbol3D.OffsetX;
				_Img.y = Symbol3D.OffsetY;
			}
		}
		
		public function get Symbol():GenericSymbol
		{
			return _Symbol;
		}
		//元件锚点占用的GridTile对象
		private var _Tile:GenericTile = null;
		public function set Tile(Value:GenericTile):void
		{
			_Tile = Value;
		}
		public function get Tile():GenericTile
		{
			return _Tile;
		}
	}
}