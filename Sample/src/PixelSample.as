package
{
	import flash.events.MouseEvent;
	
	import pixel.core.PixelLauncher;
	import pixel.core.PixelScreen;
	import pixel.core.IPixelLayer;
	import pixel.animation.PixelTransitionContants;
	import pixel.animation.PixelTransitionFlipX;
	
	public class PixelSample extends PixelLauncher
	{
		public function PixelSample()
		{
			super(DefaultDirector);
			
			stage.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
				PixelLauncher.director.switchScene(DefaultScene);
				
			});
			
			stage.addEventListener(MouseEvent.RIGHT_CLICK,function(event:MouseEvent):void{
				var scene:IPixelLayer = PixelLauncher.director.switchScene(SwitchScene,PixelTransitionContants.FLIPX_LEFT,3);
				//scene.x = 100;
				//scene.y = 100;
				//PixelLauncher.director.switchScene(SwitchScene);
			});
		}
	}
}