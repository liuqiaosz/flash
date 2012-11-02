package game.sdk.scene
{
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import game.sdk.core.GameSprite;
	import game.sdk.map.tile.TileData;
	
	import utility.Tools;

	public class GenericScene extends GameSprite implements IScene
	{
		protected var _Model:ByteArray = null;
		protected var _Mode:uint = 0;
		protected var _Name:String = "";
		
		public function GenericScene()
		{
		}
		
		public function Initializer(Model:ByteArray):void
		{
			_Model = Model;
		}
		
		public function Reset():void
		{
			
		}
		
		public function AddedToCamera():void
		{
		}
		
		public function RemoveFromCamera():void
		{
		}
		
		/**
		 * 
		 * Interface  method
		 * 
		 * 
		 * 获取当前场景名称
		 **/
		public function get Name():String
		{
			return _Name;
		}
		
		public function Dispose():void
		{
			if(_Model)
			{
				_Model.clear();
				_Model = null;
			}
		}
	}
}