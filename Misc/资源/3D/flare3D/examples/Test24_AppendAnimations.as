package  
{
	import base.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.loaders.*;
	import flare.modifiers.*;
	import flare.utils.*;
	import flash.display.*;
	import flash.events.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Loads external animation files.
	 * @author Ariel Nehmad
	 */
	public class Test24_AppendAnimations extends Base 
	{
		private var scene:Scene3D;
		private var char:Pivot3D;
		private var anim1:Pivot3D;
		private var anim2:Pivot3D;
		
		public function Test24_AppendAnimations() 
		{
			scene = new Viewer3D(this);
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			
			// load and add the main character without animations.
			char = scene.addChildFromFile( "../resources/anim_base.f3d" );
			
			// there is no needed to add the animations to the scene, so
			// we just load them through the scene library that manages all resources 
			// loading process.
			anim1 = new Flare3DLoader( "../resources/anim_base1.f3d" );
			anim2 = new Flare3DLoader( "../resources/anim_base2.f3d" );
			scene.library.push( anim1 as Flare3DLoader );
			scene.library.push( anim2 as Flare3DLoader );
		}
		
		private function completeEvent(e:Event):void 
		{
			// adds the loaded animations to the char pivot.
			Pivot3DUtils.appendAnimation( char, anim1, "anim1" );
			Pivot3DUtils.appendAnimation( char, anim2, "anim2" );
			char.gotoAndPlay( "anim1" )
			
			trace( char.labels["anim1"] )
			trace( char.labels["anim2"] )
		}
	}
}