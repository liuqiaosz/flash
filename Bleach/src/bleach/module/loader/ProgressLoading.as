package bleach.module.loader
{
	import bleach.ILoading;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.UIProgress;
	import pixel.ui.control.vo.UIMod;

	public class ProgressLoading extends Sprite implements ILoading
	{
		private static var _instance:ILoading = null;
		
		private var _progress:UIProgress = null;
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
			_progress = mod.controls.pop().control as UIProgress;
			this.addChild(_progress);
			
			_progress.x = (1000 - _progress.width) / 2;
			_progress.y = (600 - _progress.height) / 2;
			
			addEventListener(Event.ADDED_TO_STAGE,function(event:Event):void{
				_progress.x += _progress.width;
				_progress.y += _progress.height;
				_progress.scaleX = 0;
				_progress.scaleY = 0;
				var tx:Number = (1000 - _progress.width) / 2;
				var ty:Number = (600 - _progress.height) / 2;
				
				TweenLite.to(_progress,0.5,{scaleX: 1,scaleY: 1,onUpdate:onTweenUpdate,ease:Back.easeOut});
			});
		}
		
		private function onTweenUpdate():void
		{
			trace(_progress.scaleX);
			trace(_progress.width);
			_progress.x = (1000 - _progress.scaleX * _progress.width) / 2;
			_progress.y = (600 - _progress.scaleY * _progress.height) / 2;
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
			_progress.UpdateProgress(value,total);
		}
	}
}