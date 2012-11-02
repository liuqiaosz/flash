package game.sdk.map
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import game.sdk.assets.AssetLibraryManager;
	import game.sdk.assets.IAssetLibrary;
	import game.sdk.map.tile.TileData;
	import game.sdk.net.IHTTPConnection;
	import game.sdk.net.downloader.IBatchDownloader;
	import game.sdk.net.event.BatchDownloadEvent;
	import game.sdk.net.event.NetEvent;
	
	/**
	 * 地表视窗
	 **/
	public class TerrainScroller extends Sprite
	{
		//地表视窗宽度和高度
		private var _ViewPortWidth:int = 0;
		private var _ViewPortHeight:int = 0;
		
		//视窗所处舞台X
		private var _StageX:int = 0;
		//视窗所处舞台Y
		private var _StageY:int = 0;
		
		//地表单位的宽度和高度
		private var _TerrainUnitWidth:int = 0;
		private var _TerrainUnitHeight:int = 0;
		
		//地表的最大宽度和高度
		private var _TerrainWidth:int = 0;
		private var _TerrainHeight:int = 0;
		
		private var _MapGrid:Vector.<Vector.<TileData>> = null;
		
		//当前视窗注册点所处大地图的坐标
		private var _TerrainX:int = 0;
		public function get TerrainX():int
		{
			return _TerrainX;
		}
		private var _TerrainY:int = 0;
		public function get TerrainY():int
		{
			return _TerrainY;
		}
		
		private var _Terrain:BitmapData = null;
		
		private var _ViewCellColumn:int = 0;
		private var _ViewCellRow:int = 0;
		
		//资源下载实例
		private var _ImageDownloader:IBatchDownloader = null;
		
		//资源下载器类
		private var _Downloader:Class = null;
		
		private var _DownloadProcess:Boolean = false;
		
		private var _TileBitmapCache:Dictionary = new Dictionary();
		
		public function get Terrain():BitmapData
		{
			return _Terrain;
		}
		
		/**
		 * 
		 * @param Width:		视窗宽度
		 * @param Height:		视窗高度
		 * @TerrainUnitWidth:	地表单位宽度
		 * @TerrainUnitHeight:	地表单位高度
		 **/
		public function TerrainScroller(Grid:Vector.<Vector.<TileData>>,Width:int,Height:int,TerrainUnitWidth:int,TerainUnitHeight:int,Downloader:Class = null)
		{
			_Downloader = Downloader;
			if(Downloader)
			{
				_ImageDownloader = new Downloader() as IBatchDownloader;
				_ImageDownloader.addEventListener(BatchDownloadEvent.DOWNLOAD_COMPLETE,TaskDownloadComplete);
				_ImageDownloader.addEventListener(BatchDownloadEvent.DOWNLOAD_QUEUE_COMPLETE,AllDownloadComplete);
			}
			_TerrainUnitWidth = TerrainUnitWidth;
			_TerrainUnitHeight = TerainUnitHeight
			_ViewPortWidth = Width;
			_ViewPortHeight = Height;
			_MapGrid = Grid;
			
			//计算整个地表的大小
			_TerrainWidth = _MapGrid.length * TerrainUnitWidth;
			_TerrainHeight = _MapGrid[0].length * TerainUnitHeight;
			
			_Terrain = new BitmapData(_ViewPortWidth,_ViewPortHeight);
			
			_ViewCellRow = _ViewPortHeight / _TerrainUnitHeight;
			_ViewCellRow += (_ViewPortHeight % _TerrainUnitHeight > 0 ? 1:0);
			
			_ViewCellColumn = _ViewPortWidth / _TerrainUnitWidth;
			_ViewCellColumn += (_ViewPortWidth % _TerrainUnitWidth > 0 ? 1:0);
		}
		
		/**
		 * 以当前位置为基准,移动指定的偏移量
		 * 
		 * 
		 **/
		public function Move(OffsetX:int,OffsetY:int):void
		{
			_TerrainX += OffsetX;
			_TerrainY += OffsetY;
			
			CheckPosition();
			Scroll();
		}
		
		/**
		 * 滚屏逻辑
		 **/
		private function Scroll():void
		{
			var CutX:int = _TerrainX / _TerrainUnitWidth;
			var CutOffsetX:int = _TerrainX % _TerrainUnitWidth;
			var CutY:int = _TerrainY / _TerrainUnitHeight;
			var CutOffsetY:int = _TerrainY % _TerrainUnitHeight;
			
			var CellRow:int = (_ViewCellRow + (CutOffsetY > 0?1:0));
			var CellCol:int = (_ViewCellColumn + (CutOffsetX > 0?1:0));
			var Rect:Rectangle = new Rectangle();
			var DestPos:Point = new Point();
			var RowValue:int = 0;
			var ColumnValue:int = 0;
			
			CheckResource(CutX,CutY,CellCol,CellRow,1);
			_Terrain.fillRect(_Terrain.rect,0);
			for(var Col:int=0; Col < CellCol; Col++)
			{
				for(var Row:int=0; Row < CellRow; Row++)
				{
					if(CutX + Col >= _MapGrid.length || CutY + Row >= _MapGrid[0].length)
					{
						continue;
					}
					
					var Tile:TileData = _MapGrid[CutX + Col][CutY + Row];
					RowValue = Row == 0 ? _TerrainUnitHeight - CutOffsetY:_TerrainUnitHeight;
					ColumnValue = Col == 0 ? _TerrainUnitWidth - CutOffsetX:_TerrainUnitWidth;
					Rect.width = ColumnValue;
					Rect.height = RowValue;
					Rect.x = _TerrainUnitWidth - Rect.width;
					Rect.y = _TerrainUnitHeight - Rect.height;
					if(DestPos.y + Rect.height > _Terrain.height)
					{
						Rect.height = _Terrain.height - DestPos.y;
						Rect.y = 0;
					}
					
					if(DestPos.x + Rect.width > _Terrain.width)
					{
						Rect.width = _Terrain.width - DestPos.x;
						ColumnValue = Rect.width;
					}
					
					if(Tile.Resource == null && _TileBitmapCache[Tile.ResourceClass] != null)
					{
						Tile.Resource = _TileBitmapCache[Tile.ResourceClass];
					}
					
					if(Tile.Resource)
					{
						_Terrain.copyPixels(Tile.Resource,Rect,DestPos);
					}
					
					DestPos.y += Rect.height;
				}
				DestPos.x += ColumnValue;
				DestPos.y = 0;
			}
		}
		
		/**
		 * 移动至指定全局坐标
		 * 
		 * @param Posx	全局坐标X
		 * @param PosY	全局坐标Y
		 **/
		public function MoveTo(PosX:int,PosY:int):void
		{
			_TerrainX = PosX;
			_TerrainY = PosY;
			CheckPosition();
			Scroll();
		}
		
		//private var _CurrentDownloadQueue:Dictionary = new Dictionary();
		private var _UrlQueue:Vector.<String> = new Vector.<String>();
		
		/**
		 * 检查资源情况.将未加载的数据加入下载队列
		 * 
		 * @Param 	StartColumn:	开始列
		 * @Param	StartRow:		开始行
		 * @Param	ColumnCount:	列数
		 * @Param	RowCount:		行数
		 * @Param	Deep:			缓存深度
		 **/
		private function CheckResource(StartColumn:int,StartRow:int,ColumnCount:int,RowCount:int,Deep:int):void
		{
			var Queue:Vector.<Vector.<TileData>> = new Vector.<Vector.<TileData>>();
			
			//依据深度获取缓存的开始位置
			var ColSeek:int = StartColumn - Deep;
			ColSeek = ColSeek < 0 ? 0:ColSeek;
			var RowSeek:int = StartRow - Deep;
			RowSeek = RowSeek < 0 ? 0:RowSeek;
			
			var ColEnd:int = StartColumn + ColumnCount + Deep;
			if(ColEnd >= _MapGrid.length)
			{
				ColEnd = _MapGrid.length;
			}
			var RowEnd:int = StartRow + RowCount + Deep;
			if(RowEnd >= _MapGrid[0].length)
			{
				RowEnd = _MapGrid[0].length;
			}
			
			for(var Col:int = ColSeek; Col <ColEnd; Col++)
			{
				for(var Row:int = RowSeek; Row < RowEnd; Row++)
				{
					var Tile:TileData = _MapGrid[Col][Row];
					//检测资源是否存在.不存在则加入下载队列
					if(!Tile.Resource && _TileBitmapCache[Tile.ResourceClass] == null)
					{
						if(null == _ImageDownloader)
						{
							var Lib:IAssetLibrary = AssetLibraryManager.Instance.FindAssetLibraryById(Tile.ResourceId) as IAssetLibrary;
							if(Lib)
							{
								if(Lib.Data)
								{
									//资源管理器已经有该资源缓存.
									var Img:Bitmap = Lib.FindBitmapById(Tile.ResourceClass);
									if(Img)
									{
										//缓存的数据
										_TileBitmapCache[Tile.ResourceClass] = Img.bitmapData;
									}
								}
								else
								{
									//加载该模块
									AssetLibraryManager.Instance.DownloadAssetLibrary(Lib);
								}
							}
						}
						else
						{
							if(_UrlQueue.indexOf(Tile.ResourceClass)<0)
							{
								_ImageDownloader.PushToQueue(Tile.ResourceClass);
							}
						}
//						if(_DownloadProcess)
//						{
//							_ImageDownloader.PushToQueue(Tile.ResourceURL);
//						}
					}
				}
			}
			
			if(!_DownloadProcess)
			{
				if(_UrlQueue.length)
				{
					_ImageDownloader.StartBatchDownload(_UrlQueue);
				}
			}
		}
		
		private function TaskDownloadComplete(event:BatchDownloadEvent):void
		{
			try
			{
				_TileBitmapCache[event.DownloadURL] = Bitmap(event.CompleteContent).bitmapData;
//				if(_CurrentDownloadQueue[event.DownloadURL] == null)
//				{
//					trace("null!");
//				}
//				TileData(_CurrentDownloadQueue[event.DownloadURL]).Resource = event.CompleteImage.bitmapData;
				//delete _CurrentDownloadQueue[event.DownloadURL];
				//_CurrentDownloadQueue[event.DownloadURL] = null;
				//_UrlQueue.splice(_UrlQueue.indexOf(event.DownloadURL),1);
				
//				if(TileData(_CurrentDownloadQueue[event.DownloadIndex]).ResourceURL == event.DownloadURL)
//				{
//					
//				}
				
			}
			catch(Err:Error)
			{
				trace("!!");
			}
			MoveTo(_TerrainX,_TerrainY);
		}
		private function AllDownloadComplete(event:BatchDownloadEvent):void
		{
			trace("all complete");
			//_CurrentDownloadQueue = [];
			//_UrlQueue = new Vector.<String>();
		}
		
		/**
		 * 坐标合法性校验
		 **/
		private function CheckPosition():void
		{
			if(_TerrainX < 0)
			{
				_TerrainX = 0;
			}
			if(_TerrainX > _TerrainWidth || _TerrainX + _ViewPortWidth > _TerrainWidth)
			{
				_TerrainX = _TerrainWidth - _ViewPortWidth;
			}
			
			if(_TerrainY > -(_ViewPortHeight - _TerrainHeight))
			{
				_TerrainY = -(_ViewPortHeight - _TerrainHeight);
			}
			if(_TerrainY < 0)
			{
				_TerrainY = 0;
			}
		}
	}
}