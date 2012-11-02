package  
{
	import flare.basic.*;
	import flare.core.*;
	import flare.materials.*;
	import flare.materials.flsl.*;
	import flare.primitives.*;
	import flare.system.*;
	import flare.utils.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Terrain - Custom FLSL Filter and mesh deform.
	 * @author Ariel Nehmad
	 */
	public class Test17_CustomTerrainFilter extends Sprite 
	{
		[Embed(source = '../resources/terrain.png')]	private static var Layer0:Class;
		[Embed(source = '../resources/images.jpg')]		private static var Layer1:Class;
		[Embed(source = '../resources/tex6.jpg')]		private static var Layer2:Class;
		[Embed(source = '../resources/r42.jpg')] 		private static var Layer3:Class;
		
		[Embed(source = 'filters/terrain.flsl', mimeType = 'application/octet-stream')]
		private static var FilterSource:Class;
		private static var filterBytes:ByteArray = FLSLCompiler.compile( new FilterSource );
		
		private var scene:Scene3D;
		private var filter:FLSLFilter;
		
		public function Test17_CustomTerrainFilter() 
		{
			// creates the scene as usual.
			scene = new Viewer3D(this);
			scene.camera.setPosition( 800, 800, -800 );
			scene.camera.lookAt( 0, 0, 0 );
			
			// the texture used as a height map.
			// we'll use red channel to store the heighs, and green and blue to paint
			// different areas of the terrain.
			var heightMap:Texture3D = new Texture3D( new Layer0 );
			
			// creates our filter instance and passes all the needed textures.
			filter = new FLSLFilter( filterBytes );
			filter.textures.layer0.value = heightMap;
			filter.textures.layer1.value = new Texture3D( new Layer1 );
			filter.textures.layer2.value = new Texture3D( new Layer2 );
			filter.textures.layer3.value = new Texture3D( new Layer3 );
			
			// additionaly, pass other parameters.
			filter.params.repeat1.value = Vector.<Number>([15,15]);
			filter.params.repeat2.value = Vector.<Number>([3,3]);
			
			// creates the material that uses our custom filter and pass the 
			// filter in the same way as flare3d native filters.
			var terrainMaterial:Shader3D = new Shader3D( "terrainMaterial", null, true );
			terrainMaterial.filters.push( filter );
			terrainMaterial.build();
			
			// our base plane for the terrain.
			var terrain:Plane = new Plane( "terrain", 1000, 1000, 128, terrainMaterial, "+xz" );
			
			createTerrain( heightMap.bitmapData, terrain, 100 );
			
			scene.addChild( terrain );
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		/**
		 * Function to deform the terrain mesh according to the height map.
		 */
		private function createTerrain( map:BitmapData, plane:Plane, height:Number ):void
		{
			var surface:Surface3D = plane.surfaces[0];
			var positionOffset:int = surface.offset[Surface3D.POSITION];
			var normalOffset:int = surface.offset[Surface3D.NORMAL];
			var length:int = surface.vertexVector.length;
			
			var uv:Number = map.height / plane.height / height * 1 / ( height / plane.height );
			var normal:Vector3D = new Vector3D();
			var uVector:Vector3D = new Vector3D();
			var vVector:Vector3D = new Vector3D();
			
			for ( var i:int = 0; i < length; i += surface.sizePerVertex )
			{
				var x:Number = surface.vertexVector[i + positionOffset];
				var y:Number = surface.vertexVector[i + positionOffset + 1];
				var z:Number = surface.vertexVector[i + positionOffset + 2];
				
				var pixelX:int = ( x / plane.width + 0.5 ) * map.width;
				var pixelY:int = ( -z / plane.height + 0.5 ) * map.height;
				var value:int = map.getPixel( pixelX, pixelY ) >> 16;
				
				surface.vertexVector[i + positionOffset + 1] = height * value / 255;
				
				var nx:Number = ((map.getPixel( pixelX + 1, pixelY ) >> 16) - value) / 255;
				var nz:Number = ((map.getPixel( pixelX, pixelY + 1 ) >> 16) - value) / 255;
				
				uVector.setTo( uv, nx, 0 );
				vVector.setTo( 0, nz, -uv );
				normal = uVector.crossProduct( vVector );
				normal.normalize();
				
				surface.vertexVector[i + normalOffset] = normal.x;
				surface.vertexVector[i + normalOffset + 1] = normal.y;
				surface.vertexVector[i + normalOffset + 2] = normal.z;
			}
			
			Mesh3DUtils.split( plane );
		}
		
		private function updateEvent(e:Event):void 
		{
			filter.params.offset1.value[0] += 0.001;
			filter.update();
			
			if ( Input3D.keyHit( Input3D.NUMBER_1 ) ) scene.lights.techniqueName = "noLights";
			if ( Input3D.keyHit( Input3D.NUMBER_2 ) ) scene.lights.techniqueName = "linear";
		}
	}
}