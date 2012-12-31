package death.def.scene
{
	import death.def.communication.CommMarshal;
	
	import pixel.core.PixelLayer;
	import pixel.net.msg.IPixelNetMessage;

	public class GenericScene extends PixelLayer
	{
		public function GenericScene(id:String = "")
		{
			super(id);
		}
		
		/**
		 * 从服务端同步场景数据
		 * 
		 **/
		public function syncSceneData():void
		{
		}
	
	}
}