package  
{
	import flare.basic.*;
	import flare.core.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	import flare.primitives.*;
	import flash.display.*;
	import flash.events.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	/**
	 * ...
	 * @author Ariel Nehmad
	 */
	public class Test15_SimpleNormalMap extends Sprite 
	{
		private var scene:Scene3D;
		private var sphere:Mesh3D;
		
		public function Test15_SimpleNormalMap() 
		{
			scene = new Viewer3D(this);
			scene.camera.setPosition( 0, 0, -15 );
			
			var shader:Shader3D = new Shader3D();
			shader.filters.push( new TextureFilter( new Texture3D( "../resources/tex6.jpg" ) ) );
			shader.filters.push( new NormalMapFilter( new Texture3D( "../resources/images.jpg" ) ) );
			shader.filters.push( new EnvironmentFilter( new Texture3D( "../resources/reflections.jpg" ), BlendMode.MULTIPLY, 1.5 ) );
			shader.build();
			
			shader.filters[1].repeatX = 4;
			shader.filters[1].repeatY = 4;
			
			sphere = new Sphere( "sphere", 5, 25, shader );
			sphere.parent = scene;
			
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		private function updateEvent(e:Event):void 
		{
			sphere.rotateY(0.5);
		}
	}
}