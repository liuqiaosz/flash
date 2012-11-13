package pixel.transition
{
	import flash.events.EventDispatcher;
	
	import pixel.core.PixelNs;
	import pixel.message.MessageBus;
	
	use namespace PixelNs;
	
	/**
	 * 过渡效果基类
	 * 
	 * 
	 **/
	public class PixelTransition extends EventDispatcher implements IPixelTransition
	{
		public function PixelTransition(param:PixelTransitionVars)
		{
			
		}
		
		public function begin():void
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