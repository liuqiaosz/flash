package death.def.event
{
	import flash.events.Event;

	public class BleachDefenseEvent extends Event
	{
		//同步场景数据
		public static const BLEACH_SYNCSCENEDATA:String = "SyncSceneData";
		public function BleachDefenseEvent(type:String,bubbles:Boolean = true)
		{
			super(type,bubbles);
		}
	}
}