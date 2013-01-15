package bleach.module.scene
{
	import bleach.communicator.CommMarshal;
	
	import pixel.core.PixelLayer;
	import bleach.module.message.IMsg;

	public class GenericScene extends PixelLayer implements IScene
	{
		private var _pause:Boolean = false;
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
		
		public function pause():void
		{
			_pause = true;
		}
		public function resume():void
		{
			_pause = false;
		}
	
		override public final function update():void
		{
			if(!_pause)
			{
				super.update();
				sceneUpdate();
			}
		}
		
		protected function sceneUpdate():void
		{}
	}
}