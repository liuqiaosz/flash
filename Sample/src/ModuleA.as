package
{
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	
	import pixel.core.PixelLauncher;

	public class ModuleA extends Sprite
	{
		public function ModuleA()
		{
			var vc:Vector.<String> = ApplicationDomain.currentDomain.getQualifiedDefinitionNames();
			for each(var s:String in vc)
			{
				trace(s);
			}
		}
	}
}