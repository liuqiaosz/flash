package game.sdk.map.tile
{
	import utility.ColorCode;

	/**
	 * 
	 * 绘制立体ISO对象
	 * 
	 **/
	public class GenericBox extends GenericTile
	{
		protected var _TileHeight:int = 0;
		public function GenericBox(Row:int = 0,Column:int = 0,Size:int = 0,Height:int = 0)
		{
			super(Row,Column,Size);	
			this._TileHeight = Height;
		}
//		public function GridBoxTile(Size:int = 0,Height:int = 0,x:Number = 0,y:Number = 0,z:Number = 0)
//		{
//			super(Size,x,y,z);
//			this._TileHeight = Height;
//		}
		
		public function set TileHeight(Value:int):void
		{
			_TileHeight = Value;
			Update();
		}
		public function get TileHeight():int
		{
			return _TileHeight;
		}
		
		override protected function DrawDiamond():void
		{
			if(_TileHeight <= 0)
			{
				super.DrawDiamond();
			}
			else
			{
				super.DrawDiamond();
				
				graphics.beginFill(ColorCode.BLUEVIOLET);
				// draw top
				graphics.lineStyle(0, 0, .5);
				graphics.moveTo(-TileSize, -_TileHeight);
				graphics.lineTo(0, -TileSize * .5 - _TileHeight);
				graphics.lineTo(TileSize, -_TileHeight);
				graphics.lineTo(0, TileSize * .5 - _TileHeight);
				graphics.lineTo(-TileSize, -_TileHeight);
				// draw left
				graphics.lineStyle(0, 0, .5);
				graphics.moveTo(-TileSize, -_TileHeight);
				graphics.lineTo(0, TileSize * .5 - _TileHeight);
				graphics.lineTo(0, TileSize * .5);
				graphics.lineTo(-TileSize, 0);
				graphics.lineTo(-TileSize, -_TileHeight);
				// draw right
				graphics.lineStyle(0, 0, .5);
				graphics.moveTo(TileSize, -_TileHeight);
				graphics.lineTo(0, TileSize * .5 - _TileHeight);
				graphics.lineTo(0, TileSize * .5);
				graphics.lineTo(TileSize, 0);
				graphics.lineTo(TileSize, -_TileHeight);
			}
		}
	}
}