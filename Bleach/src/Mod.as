package
{
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;

	public class Mod extends Sprite
	{
		public function Mod()
		{
			domain();
		}
		
		private function domain():void
		{
//			var obj:Object = flash.utils.getDefinitionByName("login010");
			var names:Vector.<String> = ApplicationDomain.currentDomain.getQualifiedDefinitionNames();
			for each(var name:String in names)
			{
				trace(name);
				
			}
		}
	}
}