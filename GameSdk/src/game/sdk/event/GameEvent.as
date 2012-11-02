package game.sdk.event
{
	import flash.events.Event;

	public class GameEvent extends Event
	{
		//配置初始化完成
		public static const PREFERENCE_INITIALIZED:String = "PreferenceInitialized";
		//配置初始化异常
		public static const PREFERENCE_INITFAILURE:String = "PreferenceInitFailure";
		
		public static const RENDER_OVER:String = "RenderOver";
		
		public var EventMessage:String = "";
		public function GameEvent(Type:String,Bubbles:Boolean = true)
		{
			super(Type,Bubbles);
		}
	}
}