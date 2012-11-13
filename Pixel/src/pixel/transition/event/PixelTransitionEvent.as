package pixel.transition.event
{
	import flash.events.Event;

	public class PixelTransitionEvent extends Event
	{
		public static const TRANS_BEGIN:String = "TransitionBegin";
		public static const TRANS_PROGRESS:String = "TransitionProgress";
		public static const TRANS_COMPLETE:String = "TransitionComplete";
		public static const TRANS_SQUARE_COMPLETE:String = "TransitionSquareComplete";
		
		public function PixelTransitionEvent(type:String,bubbles:Boolean = true)
		{
			super(type,bubbles);
		}
	}
}