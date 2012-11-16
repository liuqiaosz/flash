package
{
	import flash.events.MouseEvent;
	
	import pixel.core.PixelLauncher;
	import pixel.core.PixelScreen;
	import pixel.scene.IPixelScene;
	import pixel.transition.PixelTransitionContants;
	import pixel.transition.PixelTransitionFlipX;
	
	public class PixelSample extends PixelLauncher
	{
		public function PixelSample()
		{
			super(DefaultDirector);
			
			stage.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
				PixelLauncher.director.switchScene(DefaultScene);
				
			});
			
			stage.addEventListener(MouseEvent.RIGHT_CLICK,function(event:MouseEvent):void{
				var scene:IPixelScene = PixelLauncher.director.switchScene(SwitchScene,PixelTransitionContants.FLIPX_LEFT,3);
				//scene.x = 100;
				//scene.y = 100;
				//PixelLauncher.director.switchScene(SwitchScene);
			});
		}
	}
}