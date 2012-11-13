package pixel.io
{
	import flash.display.Stage;
	
	import pixel.core.PixelLauncher;
	import pixel.core.PixelModule;
	import pixel.core.PixelNs;
	import pixel.error.ErrorContants;
	import pixel.error.PixelError;

	use namespace PixelNs;
	
	/** 
	 * IO模块
	 * 
	 * 负责网络数据的输入输出
	 * 
	 **/
	public class PixelIOModule extends PixelModule implements IPixelIOModule
	{
		
		public function PixelIOModule()
		{
			
		}
		
		/**
		 * 初始化
		 * 
		 * 
		 **/
		override protected function initializer():void
		{
			
		}
	}
}