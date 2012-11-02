package  
{
	import base.*;
	import components.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.events.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	import flare.primitives.*;
	import flare.system.*;
	import flare.utils.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import particles.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * 3D picture gallery.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test11_Picture_Gallery extends Base
	{
        private var scene:Scene3D;
		private var emiter:ParticleEmiter3D;
		private var textures:Vector.<Texture3D>;
		private var loading:Vector.<Cube>;
		
		public function Test11_Picture_Gallery() 
		{
			super( "Drag to rotate the camera" );
			
			scene = new Viewer3D( this )
			scene.lights.ambientColor = new Vector3D( 0.3, 0.3, 0.3 );
			
			scene.camera = new Camera3D( "cam", 70 );
			scene.camera.setPosition( 0, 50, -400 );
			scene.camera.lookAt( 0, 50, 0 );
			
			// load the beatifull logo :)
			scene.addChildFromFile( "../resources/flare3d_logo.f3d" );
			
			// initialize the lists to store the textures and cubes.
			textures = new Vector.<Texture3D>();
			loading = new Vector.<Cube>();
			
			var particle:Texture3D = scene.addTextureFromFile( "../resources/Cross_0005.jpg" );
			
			var material:ParticleMaterial3D = new ParticleMaterial3D();
			material.filters.push( new TextureFilter( particle ) );
			material.filters.push( new ColorParticleFilter( [ 0xffff00, 0xff0000, 0x00ff00, 0x0000ff ], [1, 1, 1, 0] ) );
			material.build();
			
			// similar as the particles example.
			emiter = new ParticleEmiter3D( "emiter", material, new CustomParticle2() );
			emiter.useGlobalSpace = true;
			emiter.particlesLife = 50;
			emiter.decrementPerFrame = -1; // one shot mode.
			emiter.layer = 10;
			scene.addChild( emiter );
			
			// stage configuration.
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener( Event.RESIZE, resizeEvent );
			
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
		}
		
		private function completeEvent(e:Event):void 
		{
			// go for the pictures.
			loadAllImages();
			
			// start to update the scene.
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		/**
		 * Resizes the 3d scene when the stage is resized.
		 */
		private function resizeEvent(e:Event):void 
		{
			scene.setViewport( 0, 0, stage.stageWidth, stage.stageHeight, scene.antialias );
		}
		
		/**
		 * Load an external image, create the texture and the cube.
		 */
		private function loadImage( url:String ):void
		{
			var texture:Texture3D = new Texture3D( url + "?id=" + Math.random() );
			texture.addEventListener( "progress", progressTextureEvent );
			texture.addEventListener( "complete", completeTextureEvent );
			texture.load();
			
			var cube:Cube = new Cube( url );
			
			// create a random position.
			var position:Vector3D = Vector3DUtils.random( 100, 200 );
			cube.x = position.x;
			cube.y = position.y;
			cube.z = position.z;			
			if ( Math.random() > 0.5 ) cube.x = -cube.x;
			if ( Math.random() > 0.5 ) cube.y = -cube.y;
			if ( Math.random() > 0.5 ) cube.z = -cube.z;			
			
			// add the cube to the scene.
			scene.addChild( cube );
			
			// store the cube and texture.
			textures.push( texture )
			loading.push( cube );
		}
		
		/**
		 * When the texture is loading, scale the cube acording the progress.
		 */
		private function progressTextureEvent(e:Event):void 
		{
			var texture:Texture3D = e.target as Texture3D;
			
			// we add +1 to the scale to prevent scale = 0.
			var scale:Number = texture.bytesLoaded / texture.bytesTotal * 4 + 1;
			
			// get the index of texture we are loading.
			var index:int = textures.indexOf( texture );
			
			// textures and loading lists have the same indices.
			loading[index].setScale( scale, scale, scale );
		}
		
		/**
		 * Once completed the loading, creates a new material with the loaded texture.
		 * Also, adds a orientation component to all pictures look at the same orientation as the camera.
		 */
		private function completeTextureEvent(e:Event):void 
		{
			var texture:Texture3D = e.target as Texture3D;
			
			var index:int = textures.indexOf( texture );
			
			// create a new shader.
			var material:Shader3D = new Shader3D( "textureMaterial" );
			material.filters = [ new TextureFilter( texture ) ]; 
			
			// access to stored cube. the texture and the cube should have the same index.
			var cube:Cube = loading[index];
			cube.setScale( texture.bitmapData.width / 50, texture.bitmapData.height / 50, 3 );
			cube.setMaterial( material );
			
			// we can add behaviors to the 3d objets through
			cube.addComponent( new SetOrientationComponent( scene.camera ) );
			
			// add mouse events.
			cube.addEventListener( MouseEvent3D.MOUSE_DOWN, mouseDownCubeEvent );
			cube.useHandCursor = true;
			
			// fire the particles.
			emiter.setPosition( cube.x, cube.y, cube.z );
			emiter.emitParticlesPerFrame = 50;
			
			// remove the objects from the lists.
			loading.splice( index, 1 );
			textures.splice( index, 1 );
		}
		
		private function mouseDownCubeEvent(e:MouseEvent3D):void 
		{
			// fire some particles on mouse down.
			emiter.setPosition( e.target.x, e.target.y, e.target.z );
			emiter.emitParticlesPerFrame = 50;
		}
		
		private function updateEvent(e:Event):void 
		{
			// rotate the cubes that are on the loading list.
			for each ( var cube:Cube in loading )
			{
				cube.rotateX( 2 );
				cube.rotateY( 1.3 );
			}
			
			// orbit the camera trough the center of the scene.
			scene.camera.rotateY( 0.2, false, Vector3DUtils.ZERO );
		}
		
		
		private function loadAllImages():void 
		{
			loadImage( "http://www.flare3d.com/upload/products/galleries/61" );
			loadImage( "http://www.flare3d.com/upload/products/galleries/42" );
			loadImage( "http://www.flare3d.com/upload/products/galleries/47" );
			loadImage( "http://www.flare3d.com/upload/products/galleries/49" );
			loadImage( "http://www.flare3d.com/upload/products/galleries/65" );
			loadImage( "http://www.flare3d.com/upload/products/galleries/60" );
			loadImage( "http://www.flare3d.com/blog/wp-content/uploads/venus_post_4.jpg" );
			loadImage( "http://www.flare3d.com/blog/wp-content/uploads/airone_post.jpg" );
			loadImage( "http://www.flare3d.com/blog/wp-content/uploads/radiosity_post.jpg" );
			loadImage( "http://www.flare3d.com/blog/wp-content/uploads/skin_post.jpg" );
			loadImage( "http://www.flare3d.com/blog/wp-content/uploads/labels.png" );
			loadImage( "http://www.flare3d.com/blog/wp-content/uploads/elsas2.jpg" );
			loadImage( "http://www.3d-test.com/sites/default/files/2011_02_flare3d_1.png" );
			loadImage( "http://www.flare3d.com/blog/wp-content/uploads/10.jpg" );
			loadImage( "http://www.flare3d.com/upload/products/galleries/62" );
			loadImage( "http://www.flare3d.com/upload/products/galleries/16" );
			loadImage( "http://www.flare3d.com/upload/products/galleries/52" );
			loadImage( "http://www.flare3d.com/upload/products/galleries/55" );
			loadImage( "http://www.flare3d.com/upload/products/galleries/18" );
			loadImage( "http://www.flare3d.com/docs/text/images/exporter.jpg" );
			loadImage( "http://profile.ak.fbcdn.net/hprofile-ak-snc4/211218_480021110505_4361428_n.jpg" );
			loadImage( "http://flare3d.com/docs/tutorials/animatedTexture/02.png" );
			loadImage( "http://www.hebiflux.com/blog/images//2010/10/flare3D.jpg" );
			loadImage( "http://home.siainteractive.com/desarrollo/baner_03.jpg" );
			loadImage( "http://www.katurn.co.kr/blog/wp-content/uploads/2010/05/physics-300x198.jpg" );
			loadImage( "http://flashgamesdownloadswf.com/wp-content/thumbs/a-small-car_img1.jpg" );
			loadImage( "http://www.katurn.co.kr/blog/wp-content/uploads/2010/11/republicbike1.jpg" );
			loadImage( "http://www.asmallgame.com/wp-content/uploads/2011/03/logga_moln_940.png" );
			loadImage( "http://www.emanueleferonato.com/wp-content/uploads/2011/05/wip.jpg" );
			loadImage( "http://3.bp.blogspot.com/_4-LtXwX7Yuo/S_vZfUEME1I/AAAAAAAAAp4/tJ-jmu1rMRM/s400/goldenstars.jpg" );
			loadImage( "http://home.siainteractive.com/desarrollo/baner_02.jpg" );
		}
	}
}
