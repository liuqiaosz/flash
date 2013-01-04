package
{
	import death.def.scene.Battle;
	
	import flash.display.Sprite;
	
	import pixel.core.PixelLauncher;
	
	[SWF(width="1280",height="600",backgroundColor="0x000000")]
	public class DeathDefense extends PixelLauncher
	{
		public function DeathDefense()
		{
			super();
			var a:Battle = new Battle();
		}
	}
}