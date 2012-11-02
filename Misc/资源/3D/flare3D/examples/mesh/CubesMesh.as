package mesh
{
	import flare.basic.Scene3D;
	import flare.core.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	import flash.display.*;
	import flash.display3D.*;
	import flash.geom.*;
	
	/**
	 * ...
	 * @author Ariel Nehmad
	 */
	public class CubesMesh extends Mesh3D
	{
		private var _material:Shader3D
		private var _needToUpload:Boolean = false;
		
		public function CubesMesh() 
		{
			var mtx:Matrix = new Matrix(); 
				mtx.createGradientBox( 256, 10 );
				
			var shp:Shape = new Shape();
				shp.graphics.beginGradientFill( GradientType.LINEAR, [0x00FCFF, 0xB48AFF, 0xF72335, 0xFFD73A ], null, null, mtx );
				shp.graphics.drawRect( 0, 0, 256, 10 );
				
			var bmp:BitmapData = new BitmapData( 256, 2, false, 0 );
				bmp.draw( shp );
				
			_material = new Shader3D( "grayScale" );
			_material.filters.push( new TextureFilter( new Texture3D(bmp) ) );
			_material.build();
			
			surfaces[0] = new Surface3D();
			surfaces[0].material = _material;
			surfaces[0].addVertexData( Surface3D.POSITION );
			surfaces[0].addVertexData( Surface3D.UV0 );
			surfaces[0].addVertexData( Surface3D.NORMAL );
		}
		
		public function addCube( x:Number, y:Number, z:Number, size:Number = 5, color:Number = 0 ):void
		{
			// gets the last used surface.
			var surf:Surface3D = surfaces[surfaces.length - 1];
			
			// each surface could not have more than 65000 vertex.
			if ( surf.vertexVector.length / surf.sizePerVertex >= 65000 )
			{
				surf = new Surface3D();
				surf.addVertexData( Surface3D.POSITION );
				surf.addVertexData( Surface3D.UV0 );
				surf.addVertexData( Surface3D.NORMAL );
				surf.material = _material;
				surfaces.push( surf );
			}
			
			//color = 0.5;
			
			var s:Number = size * 0.5;
			
			var i:int = surf.vertexVector.length / surf.sizePerVertex;
			
			surf.vertexVector.push(
									// front
									-s + x,  s + y, -s + z, 	color, 0,	0, 0, -1,
									 s + x,  s + y, -s + z, 	color, 0,	0, 0, -1,
									-s + x, -s + y, -s + z, 	color, 0,	0, 0, -1,
									 s + x, -s + y, -s + z, 	color, 0,	0, 0, -1,
									// back	
									-s + x, -s + y,  s + z, 	color, 0,	0, 0, 1,
									 s + x, -s + y,  s + z, 	color, 0,	0, 0, 1,
									-s + x,  s + y,  s + z, 	color, 0,	0, 0, 1,
									 s + x,  s + y,  s + z, 	color, 0,	0, 0, 1,
									// left	
									-s + x,  s + y,  s + z, 	color, 0,	-1, 0, 0,
									-s + x,  s + y, -s + z, 	color, 0,	-1, 0, 0,
									-s + x, -s + y,  s + z, 	color, 0,	-1, 0, 0,
									-s + x, -s + y, -s + z, 	color, 0,	-1, 0, 0,
									// right 	
									 s + x,  s + y, -s + z, 	color, 0,	1, 0, 0,
									 s + x,  s + y,  s + z, 	color, 0,	1, 0, 0,
									 s + x, -s + y, -s + z, 	color, 0,	1, 0, 0,
									 s + x, -s + y,  s + z, 	color, 0,	1, 0, 0,
									// top 	
									-s + x,  s + y,  s + z, 	color, 0,	0, 1, 0,
									 s + x,  s + y,  s + z, 	color, 0,	0, 1, 0,
									-s + x,  s + y, -s + z, 	color, 0,	0, 1, 0,
									 s + x,  s + y, -s + z, 	color, 0,	0, 1, 0,
									// bottom	
									-s + x, -s + y, -s + z, 	color, 0,	0, -1, 0,
									 s + x, -s + y, -s + z, 	color, 0,	0, -1, 0,
									-s + x, -s + y,  s + z, 	color, 0,	0, -1, 0,
									 s + x, -s + y,  s + z, 	color, 0,	0, -1, 0
									)
			
			var l:int = i + 24;
			for ( i; i < l; i += 4 )
				surf.indexVector.push( i, i + 1, i + 2, i + 1, i + 3, i + 2 );
			
			_needToUpload = true;
		}

		override public function upload(scene:Scene3D = null, force:Boolean = false, includeChildren:Boolean = true ):Boolean
		{
			_needToUpload = false;
			
			if ( super.upload( scene, force, includeChildren ) == false ) return false;
			
			return true;
		}
		
		public override function draw( includeChildren:Boolean = false ):void 
		{
			if ( _needToUpload && scene ) upload( scene );
			
			if ( _needToUpload ) return;
			
			super.draw( includeChildren );
		}
	}
}