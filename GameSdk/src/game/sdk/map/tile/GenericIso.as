package game.sdk.map.tile
{
	import flash.display.Sprite;
	
	import game.sdk.map.CoordinateTools;

	public class GenericIso extends Sprite
	{
		//2D坐标
		public var _Pos2D:Position2D = null;
		public function get Pos2D():Position2D
		{
			return _Pos2D;
		}
		//3D坐标
		public var _Pos3D:Position3D = null;
		public function get Pos3D():Position3D
		{
			return _Pos3D;
		}
		public function set Pos3D(Value:Position3D):void
		{
			_Pos3D = Value;
			UpdatePosition();
		}
		
		//单位大小
		protected var TileSize:int = 0;
		public function GenericIso(Size:int = 0,x:Number = 0,y:Number = 0,z:Number = 0)
		{
			TileSize = Size;
			_Pos2D = new Position2D();
			_Pos3D = new Position3D(x,y,z);
			UpdatePosition();
		}
		
		public function get Depth():Number
		{
			return (_Pos3D.x + _Pos3D.z) * .866 - _Pos3D.y * .707;
		}
		
		public function Initialize():void
		{
			Drawable();
		}
		
		protected function UpdatePosition():void
		{
			//更新等角坐标
			CoordinateTools.Iso2Screen(_Pos3D,_Pos2D);
			
			this.x = _Pos2D.x;
			this.y = _Pos2D.y;
		}
		
		/**
		 * 绘制
		 * 默认采用Graphics绘制菱形
		 **/
		public function Drawable():void
		{
			graphics.clear();
			DrawPrepared();
			DrawDiamond();
			graphics.endFill();
		}
		
		/**
		 * 
		 * 绘制前的样式准备
		 * 
		 **/
		protected function DrawPrepared():void
		{
			graphics.lineStyle(1);
			graphics.beginFill(0xFFFFFF);
		}
		
		/**
		 * 
		 * 菱形绘制
		 * 
		 **/
		protected function DrawDiamond():void
		{
			graphics.moveTo(-TileSize, 0);
			graphics.lineTo(0, -TileSize * .5);
			graphics.lineTo(TileSize, 0);
			graphics.lineTo(0, TileSize * .5);
			graphics.lineTo(-TileSize, 0);
		}
		
		public function Update():void
		{
			Drawable();
		}
	}
}