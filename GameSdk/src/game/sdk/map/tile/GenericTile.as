package game.sdk.map.tile
{
	public class GenericTile extends GenericIso
	{
		private var BorderActived:Boolean = true;
		//线条色彩,宽度和透明度
		public var BorderColor:uint = 0x000000;
		public var BorderAlpha:uint = 1;
		public var BorderThinkness:int = 1;
		
		//填充颜色和透明度
		public var Color:uint = 0xFFFFFF;
		public var ColorAlpha:uint = 1;
		
		private var _TileRow:int = 0;
		public function get TileRow():int
		{
			return _TileRow;
		}
		private var _TileColumn:int = 0;
		public function get TileColumn():int
		{
			return _TileColumn;
		}
		
		//锁定状态,以及锁定设置函数
		private var _Locked:Boolean = false;
		public function TileLocked():void
		{
			_Locked = true;
		}
		public function TileUnlocked():void
		{
			_Locked = false;
		}
		public function get Locked():Boolean
		{
			return _Locked;
		}
		
		/**
		 * 
		 * 映射的元件
		 * 
		 **/
//		private var _Symbol:TableSymbol = null;
//		public function set Symbol(Value:TableSymbol):void
//		{
//			_Symbol = Value;
//		}
//		public function get Symbol():TableSymbol
//		{
//			return _Symbol;
//		}
		public function GenericTile(Row:int = 0,Column:int = 0,Size:int = 0)
		{
			super(Size,Row * Size,0,Column * Size);	
			
			_TileRow = Row;
			_TileColumn = Column;
		}
//		public function GridTile(Size:int = 0,x:Number = 0,y:Number = 0,z:Number = 0)
//		{
//			super(Size,x,y,z);
//		}
		
		/**
		 * 
		 * 重写基类绘制前样式准备函数
		 * 
		 **/
		override protected function DrawPrepared():void
		{
			if(BorderActived)
			{
				if(BorderThinkness >= 1)
				{
					graphics.lineStyle(1,BorderColor,BorderAlpha);
				}
			}
			graphics.beginFill(Color,ColorAlpha);
		}
		
		/**
		 * 
		 * 关闭边框
		 * 
		 **/
		public function DisableBorder():void
		{
			BorderActived = false;
			Update();
		}
		public function EnabledBorder():void
		{
			BorderActived = true;
			Update();
		}
	}
}