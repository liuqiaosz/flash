package  
{
	import base.*
	import components.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.system.*;
	import flash.display.*;
	import flash.events.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Animations.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test06_Animations extends Base 
	{
		private var scene:Scene3D;
		private var model:Pivot3D;
		
		public function Test06_Animations() 
		{
			super( "Animations - Press 1 and 2 to switch between the animations.\n" +
			"'S' to stop the animation and '+' and '-' (from numpad) to change the animation speed." );
			
			// stage configuration.
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			scene = new Viewer3D( this );
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			
			model = scene.addChildFromFile( "../resources/player.f3d" );
		}
		
		private function completeEvent(e:Event):void 
		{
			// this component search for a skinned mesh 
			// and draw the bones as lines.
			model.addComponent( new DrawBones() );
			
			// the labels can be defined in 3dmax, but also can be define manually by code.
			model.addLabel( new Label3D( "walk", 0, 41 ) );
			model.addLabel( new Label3D( "run", 50, 74 ) );
			model.gotoAndPlay( "walk" );
			
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		private function updateEvent(e:Event):void 
		{
			// stop the model animation.
			if ( Input3D.keyHit( Input3D.S ) ) model.stop();
			// resume the model animation.
			if ( Input3D.keyHit( Input3D.P ) ) model.play();
			
			// play certain animation label and blend between the animations.
			if ( Input3D.keyHit( Input3D.NUMBER_1 ) ) model.gotoAndPlay( "walk", 15 );
			if ( Input3D.keyHit( Input3D.NUMBER_2 ) ) model.gotoAndPlay( "run", 15 );
			if ( Input3D.keyHit( Input3D.NUMBER_3 ) ) model.gotoAndStop( 0, 10 );
			
			// increment and decrement frameSpeed.
			if ( Input3D.keyHit( Input3D.NUMPAD_ADD ) ) model.frameSpeed += 0.1;
			if ( Input3D.keyHit( Input3D.NUMPAD_SUBTRACT ) ) model.frameSpeed -= 0.1;
			
			// reset the frameSpeed.
			if ( Input3D.keyHit( Input3D.R ) ) model.frameSpeed = 1;
		}		
	}
}