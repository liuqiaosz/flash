package game.sdk.anim.event
{
	import flash.events.Event;

	public class AnimationEvent extends Event
	{
		public static const PLAY_COMPLETE:String = "PlayComplete";
		
		public function AnimationEvent(Type:String,Bubbles:Boolean = true)
		{
			super(Type,Bubbles);
		}
	}
}