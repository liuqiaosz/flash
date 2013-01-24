package bleach.scene
{
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import pixel.ui.control.UIControl;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.vo.UIMod;

	public class ChooseRoleScene extends GenericScene
	{
		public function ChooseRoleScene()
		{
			super();
		}
		
		private var ui:UIControl = null;
		override public function initializer():void
		{
			var cls:Object = getDefinitionByName("ui.chooserole");
			var data:ByteArray = new cls() as ByteArray;
			var mod:UIMod = UIControlFactory.instance.decode(data,false);
			ui = mod.controls.pop().control;
			ui.x = 0;
			ui.y = 0;
			addChild(ui);
		}
		
		override public function dealloc():void
		{
			ui.dispose();
			ui = null;
		}
	}
}