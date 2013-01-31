package bleach.module.loader
{
	import bleach.ILoading;
	
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.UIProgress;
	import pixel.ui.control.vo.UIMod;

	public class ProgressLoading extends Sprite implements ILoading
	{
		private static var _instance:ILoading = null;
		
		private var _prgress:UIProgress = null;
		public function ProgressLoading()
		{
			if(null != _instance)
			{
				throw new Error("Singlton");
			}
			
			var commonUI:Object = getDefinitionByName("ui.common");
			var mod:UIMod = UIControlFactory.instance.decode(new commonUI() as ByteArray);
			
			this.graphics.beginFill(0x000000,0.8);
			this.graphics.drawRect(0,0,1000,600);
			this.graphics.endFill();
			_prgress = mod.controls.pop().control as UIProgress;
			this.addChild(_prgress);
			
			_prgress.x = (1000 - _prgress.width) / 2;
			_prgress.y = (600 - _prgress.height) / 2;
		}
		
		public static function get instance():ILoading
		{
			if(null == _instance)
			{
				_instance = new ProgressLoading();
			}
			return _instance;
		}
		
		public function progressUpdate(total:Number,value:Number):void
		{
			_prgress.UpdateProgress(value,total);
		}
	}
}