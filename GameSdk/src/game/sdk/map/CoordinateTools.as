package game.sdk.map
{
	import flash.geom.Point;
	
	import game.sdk.map.tile.Position2D;
	import game.sdk.map.tile.Position3D;

	public class CoordinateTools
	{
		private static var CORRECT:Number = 1.2447;
		public function CoordinateTools()
		{
		}
		
		
		/**
		 * 根据网格坐标取得象素坐标
		 * tileWidth  tile的象素宽
		 * tileHeight tile的象素高
		 * tx 网格坐标x
		 * ty 网格坐标x
		 * return 象素坐标的点
		 */
		public static function GetScreenPixelByStaggeredTile(TileWidth:uint,TileHeight:uint, Col:uint, Row:uint):Point
		{
			//var TileWidth:uint = TileSize * 2;
			//偶数行tile中心
			var tileCenter:int = (Col * TileWidth) + TileHeight;
			// x象素  如果为奇数行加半个宽
			var xPixel:int = tileCenter + (Row&1) * TileHeight;
			// y象素
			var yPixel:int = (Row + 1) * (TileHeight >> 1);
			return new Point(xPixel, yPixel);
		}
		
		/**
		 * 屏幕坐标获取数据格 
		 **/
		public static function GetStaggeredTileByScreenPosition(TileWidth:uint,TileHeight:uint,  Sx:int, Sy:int):Point
		{
			//var TileWidth:uint = TileSize * 2;
			var TileX:uint = 0;	//网格的x坐标
			var TileY:uint = 0;	//网格的y坐标
			
			var cx:int, cy:int, rx:int, ry:int;
			cx = int(Sx / TileWidth) * TileWidth + TileHeight;	//计算出当前X所在的以tileWidth为宽的矩形的中心的X坐标
			cy = int(Sy / TileHeight) * TileHeight + TileHeight / 2;//计算出当前Y所在的以tileHeight为高的矩形的中心的Y坐标
			
			rx = (Sx - cx) * TileHeight / 2;
			ry = (Sy - cy) * TileHeight / 2;
			
			if (Math.abs(rx)+Math.abs(ry) <= TileWidth * TileHeight/4)
			{
				//xtile = int(pixelPoint.x / tileWidth) * 2;
				TileX = int(Sx / TileWidth);
				TileY = int(Sy / TileHeight) * 2;
			}
			else
			{
				Sx = Sx - TileHeight;
				//xtile = int(pixelPoint.x / tileWidth) * 2 + 1;
				TileX = int(Sx / TileWidth) + 1;
				
				Sy = Sy - TileHeight/2;
				TileY = int(Sy / TileHeight) * 2 + 1;
			}
			
			return new Point(TileX - (TileY&1), TileY);
		}
		
		public static function Iso2ScreenPos(x:int,y:int,z:int):Point
		{
			return new Point(x - z, (y * CORRECT + ((x + z) >> 1)));
		}
		
		/**
		 * 等角坐标转平面坐标
		 **/
		public static function Iso2Screen(p3d:Position3D,p2d:Position2D):void
		{
			p2d.x = p3d.x - p3d.z; 
			p2d.y = p3d.y * CORRECT + (p3d.x + p3d.z) * .5;
		}
		public static function Iso2ScreenByPoint(x:int,y:int,z:int):Point
		{
			return new Point((x - z),(y * CORRECT + (x + z) * .5));
		}
		
		
		/**
		 * 平面坐标转等角坐标
		 **/
		public static function Screen2Iso(p2d:Position2D,p3d:Position3D):void
		{
			p3d.x = p2d.y + p2d.x * .5;
			p3d.y = 0;
			p3d.z = p2d.y - p2d.x * .5;
			Depth(p3d);
		}
		
		//		/**
		//		 * 2.5d Staggered布局屏幕坐标转换地图坐标
		//		 **/
		//		public static function StaggeredScreenToLoic(ScreenX:int,ScreenY:int,TileSize:int):Cell
		//		{
		//			var TileWidth:int = TileSize * 2;
		//			var xtile:int = 0;	//网格的x坐标
		//			var ytile:int = 0;	//网格的y坐标
		//			var cx:int, cy:int, rx:int, ry:int;
		//			cx = int(ScreenX / TileWidth) * TileWidth + TileWidth/2;	//计算出当前X所在的以tileWidth为宽的矩形的中心的X坐标
		//			cy = int(ScreenY / TileSize) * TileSize + TileSize/2;//计算出当前Y所在的以tileHeight为高的矩形的中心的Y坐标
		//			rx = (ScreenX - cx) * TileSize/2;
		//			ry = (ScreenY - cy) * TileWidth/2;
		//			
		//			if (Math.abs(rx)+Math.abs(ry) <= TileWidth * TileSize/4)
		//			{
		//				xtile = int(ScreenX / TileWidth);
		//				ytile = int(ScreenY / TileSize) * 2;
		//			}
		//			else
		//			{
		//				ScreenX = ScreenX - TileWidth/2;
		//				xtile = int(ScreenX / TileWidth) + 1;
		//				
		//				ScreenY = ScreenY - TileSize/2;
		//				ytile = int(ScreenY / TileSize) * 2 + 1;
		//			}
		//			return new Cell(ytile,xtile - (ytile&1));
		//		}
		//		/**
		//		 * 2.5d Staggered布局地图坐标转换屏幕坐标
		//		 **/
		//		public static function StaggeredLogicToScreen(Row:int,Column:int,TileSize:int):Point
		//		{
		//			var TileWidth:int = TileSize * 2;
		//			//偶数行tile中心
		//			var tileCenter:int = (Column * TileWidth) + TileWidth/2;
		//			// x象素  如果为奇数行加半个宽
		//			var xPixel:int = tileCenter + (Row&1) * TileWidth/2;
		//			
		//			// y象素
		//			var yPixel:int = (Row + 1) * TileSize/2;
		//			
		//			return new Point(xPixel, yPixel);
		//		}
		
		public static function Get3dByScreenPosition(x:Number,y:Number):Position3D
		{
			return new Position3D(
				y + x * .5,0,y - x *.5);
		}
		public static function Get2dByIsoPosition(x:Number,y:Number,z:Number):Position2D
		{
			return new Position2D(x - z, y * CORRECT + (x + z) * .5);
		}
		
		public static function Depth(p3d:Position3D):void
		{
			p3d.Depth = (p3d.x + p3d.z) * .866 - p3d.y * .707;
		}
		
		public static function CoverHeight(height:Number):Number
		{
			return height * CORRECT;
		}
	}
}