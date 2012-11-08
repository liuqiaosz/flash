package mapassistant
{
	import game.sdk.map.layer.ILayer;

	/**
	 * Layer数据
	 * 
	 * 
	 **/
	public class WorldLayerItem
	{
		protected var _Layer:ILayer = null;
		public function get Layer():ILayer
		{
			return _Layer;
		}
		public function WorldLayerItem(Layer:ILayer)
		{
			_Layer = Layer;
		}
		
		protected var _LayerName:String = "";
		public function set LayerName(Value:String):void
		{
			_LayerName = Value;
		}
		public function get LayerName():String
		{
			return _LayerName;
		}
		
		protected var _Show:Boolean = true;
		public function Show():void
		{
			_Show = true;
		}
		public function Hide():void
		{
			_Show = false;
		}
		
		public function get Visible():Boolean
		{
			return _Show;
		}
		
		protected var _Actived:Boolean = false;
		public function set Actived(Value:Boolean):void
		{
			_Actived = Value;
		}
		public function get Actived():Boolean
		{
			return _Actived;
		}
	}
}