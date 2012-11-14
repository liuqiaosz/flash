package pixel.transition
{
	import flash.events.EventDispatcher;
	
	import pixel.core.PixelNs;
	import pixel.message.PixelMessageBus;
	
	use namespace PixelNs;
	
	/**
	 * 过渡效果基类
	 * 
	 * 
	 **/
	public class PixelTransition extends EventDispatcher implements IPixelTransition
	{
		protected var _vars:PixelTransitionVars = null;
		public function PixelTransition(param:PixelTransitionVars)
		{
			_vars = param;
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
			PixelMessageBus.Instance.register(message,callback);
		}
		
		/**
		 * 向消息中心取消接收消息
		 * 
		 * 
		 **/
		protected function unRegister(message:String,callback:Function):void
		{
			PixelMessageBus.Instance.unRegister(message,callback);
		}
	}
}