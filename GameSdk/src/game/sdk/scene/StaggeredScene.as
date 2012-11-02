package game.sdk.scene
{
	import flash.utils.ByteArray;
	
	import game.sdk.map.CoordinateTools;
	import game.sdk.map.tile.TileData;
	
	import utility.Tools;

	/**
	 * Staggered场景
	 **/
	public class StaggeredScene extends GenericScene
	{
		protected var _SceneColumn:uint = 0;
		protected var _SceneRow:uint = 0;
		protected var _DataGridByte:ByteArray = null;
		protected var _TerrainByte:ByteArray = null;
		public function StaggeredScene()
		{
			super();
		}
		
		override public function Initializer(Model:ByteArray):void
		{
			super.Initializer(Model);
			_Mode = _Model.readByte();
			_Name = _Model.readUTFBytes(Tools.ByteFinder(_Model,32));
			_Model.readByte();
			
			_SceneColumn = _Model.readShort();
			_SceneRow = _Model.readShort();
			
			//地图编辑模式下是否启用分区功能
			var Partition:Boolean = Boolean(_Model.readByte());
			if(Partition)
			{
				//跳过编辑模式设置的分区宽,高
				_Model.readShort();
				_Model.readShort();
			}
			
			var Body:ByteArray = new ByteArray();
			_Model.readBytes(Body);
			
			Body.uncompress();
			Body.position = 0;
			
			var Len:uint = 0;
			_DataGridByte = new ByteArray();
			
			//数据层
			Len = Body.readInt();
			Body.readBytes(_DataGridByte,0,Len);
			//DataGridInitializer();
			
			//地表层
			_TerrainByte = new ByteArray();
			Len = Body.readInt();
			Body.readBytes(_TerrainByte,0,Len);
			TerrainInitializer();
		}
		
		/**
		 * 数据层初始化
		 **/
		protected function DataGridInitializer():void
		{
		}
		
		/**
		 * 地表层初始化
		 **/
		protected function TerrainInitializer():void
		{
		}
		
	}
}