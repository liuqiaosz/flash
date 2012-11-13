package pixel.core
{
	import pixel.message.MessageBus;

	use namespace PixelNs;
	/**
	 * 
	 * 模组基类
	 * 
	 * 实现和封装部分基本方法
	 * 
	 * 
	 **/
	public class PixelModule implements IPixelModule
	{
		public function PixelModule()
		{
			
		}
		
		/**
		 * 如果子类有自定义的初始化动作可以覆盖该方法实现
		 * 
		 * 但是覆盖的同时必须同时调用父类的初始化
		 * 
		 * 
		 **/
		protected function initializer():void
		{
			
		}
		
		/**
		 * 向消息中心注册接收消息
		 * 
		 * 
		 **/
		protected function register(message:String,callback:Function):void
		{
			MessageBus.Instance.register(message,callback);
		}
		
		/**
		 * 向消息中心取消接收消息
		 * 
		 * 
		 **/
		protected function unRegister(message:String,callback:Function):void
		{
			MessageBus.Instance.unRegister(message,callback);
		}
	}
}