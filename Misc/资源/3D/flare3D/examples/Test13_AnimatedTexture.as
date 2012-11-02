package  
{
	import base.*;
	import flare.basic.*;
	import flare.core.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	import flare.primitives.*;
	import flash.events.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Animated texture using sprite sheets.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test13_AnimatedTexture extends Base 
	{
		private var scene:Scene3D;
		private var animFilter:AnimatedTextureFilter;
		private var cube:Cube;
		
		public function Test13_AnimatedTexture() 
		{
			super( "Animated texture using sprite sheets." );
			
			scene = new Viewer3D( this );
			scene.camera.setPosition( 0, 0, -50 );
			
			// loads the sprite sheet.
			var texture:Texture3D = scene.addTextureFromFile( "../resources/INGAME_BIRDS_PIGS.png" );
			var texWidth:Number = 868;
			var texHeight:Number = 898;
			
			// creates the animation filter and frames.
			animFilter = new AnimatedTextureFilter( texture );
			for each ( var data:XML in xml.children() )
				animFilter.addFrame( data.@x / texWidth, data.@y / texHeight, data.@width / texWidth, data.@height / texHeight );
			
			var material:Shader3D = new Shader3D( "", [animFilter] );
			
			cube = new Cube( "", 10, 10, 10, 1, material );
			
			scene.addChild( cube );
			
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
		}
		
		private function updateEvent(e:Event):void 
		{
			animFilter.currentFrame += 0.2;
			
			cube.rotateY( 1.0 );
			cube.rotateZ( 0.3 );
		}
		
		private var xml:XML =
		<data>
			<sprite id = "PIG_HELMET_03_BLINK" x = "530" y = "560" width = "103" height = "88"/>
			<sprite id = "PIG_HELMET_02_SMILE" x = "425" y = "650" width = "103" height = "88"/>
			<sprite id = "PIG_BASIC_MEDIUM_02_SMILE" x = "610" y = "650" width = "78" height = "78"/>
			<sprite id = "PIG_BASIC_SMALL_02_BLINK" x = "790" y = "730" width = "47" height = "46"/>
			<sprite id = "PIG_MUSTACHE_03_SMILE" x = "134" y = "260" width = "119" height = "108"/>
			<sprite id = "PIG_BASIC_BIG_03_SMILE" x = "356" y = "368" width = "99" height = "100"/>
			<sprite id = "BIRD_YELLOW_FLYING_YELL" x = "356" y = "820" width = "67" height = "54"/>
			<sprite id = "PIG_MUSTACHE_03" x = "739" y = "150" width = "119" height = "108"/>
			<sprite id = "BIRD_RED_YELL" x = "690" y = "779" width = "49" height = "47"/>
			<sprite id = "PIG_MUSTACHE_02_BLINK" x = "497" y = "150" width = "119" height = "108"/>
			<sprite id = "PIG_BASIC_MEDIUM_02" x = "530" y = "730" width = "78" height = "78"/>
			<sprite id = "PIG_KING_02" x = "400" y = "1" width = "131" height = "147"/>
			<sprite id = "PIG_KING_03_BLINK" x = "1" y = "299" width = "131" height = "147"/>
			<sprite id = "PIG_BASIC_BIG_01_BLINK" x = "620" y = "260" width = "99" height = "100"/>
			<sprite id = "BIRD_BLACK_2" x = "134" y = "802" width = "67" height = "89"/>
			<sprite id = "BIRD_WHITE_2" x = "134" y = "478" width = "86" height = "106"/>
			<sprite id = "PIG_BASIC_BIG_01_SMILE" x = "721" y = "260" width = "99" height = "100"/>
			<sprite id = "BIRD_RED_2" x = "203" y = "802" width = "49" height = "47"/>
			<sprite id = "BIRD_WHITE_1" x = "134" y = "370" width = "86" height = "106"/>
			<sprite id = "BIRD_BLUE_YELL" x = "820" y = "608" width = "32" height = "31"/>
			<sprite id = "PIG_MUSTACHE_01" x = "1" y = "708" width = "119" height = "108"/>
			<sprite id = "BIRD_BLACK_YELL" x = "356" y = "561" width = "67" height = "89"/>
			<sprite id = "BIRD_RED_1" x = "81" y = "818" width = "49" height = "47"/>
			<sprite id = "BIRD_BLACK_BLINK" x = "457" y = "368" width = "67" height = "89"/>
			<sprite id = "BIRD_YELLOW_BLINK" x = "356" y = "708" width = "67" height = "54"/>
			<sprite id = "PIG_BASIC_MEDIUM_01_SMILE" x = "530" y = "650" width = "78" height = "78"/>
			<sprite id = "BIRD_BLACK_SPECIAL_3" x = "356" y = "470" width = "67" height = "89"/>
			<sprite id = "BIRD_WHITE_BLINK" x = "134" y = "586" width = "86" height = "106"/>
			<sprite id = "PIG_BASIC_BIG_02" x = "255" y = "368" width = "99" height = "100"/>
			<sprite id = "BIRD_WHITE_FLYING_YELL" x = "255" y = "260" width = "86" height = "106"/>
			<sprite id = "PIG_BASIC_BIG_03" x = "255" y = "674" width = "99" height = "100"/>
			<sprite id = "PIG_BASIC_SMALL_03_BLINK" x = "790" y = "778" width = "47" height = "46"/>
			<sprite id = "PIG_BASIC_MEDIUM_01" x = "1" y = "818" width = "78" height = "78"/>
			<sprite id = "PIG_BASIC_SMALL_02_SMILE" x = "741" y = "778" width = "47" height = "46"/>
			<sprite id = "BIRD_YELLOW_SPECIAL" x = "425" y = "830" width = "67" height = "54"/>
			<sprite id = "BIRD_WHITE_SPECIAL" x = "343" y = "260" width = "86" height = "106"/>
			<sprite id = "PIG_BASIC_BIG_02_SMILE" x = "255" y = "572" width = "99" height = "100"/>
			<sprite id = "PIG_BASIC_MEDIUM_03_BLINK" x = "610" y = "810" width = "78" height = "78"/>
			<sprite id = "BIRD_BLUE_2" x = "822" y = "293" width = "32" height = "31"/>
			<sprite id = "BIRD_YELLOW_2" x = "356" y = "652" width = "67" height = "54"/>
			<sprite id = "BIRD_YELLOW_FLYING" x = "356" y = "764" width = "67" height = "54"/>
			<sprite id = "BIRD_RED_FLYING" x = "802" y = "417" width = "49" height = "47"/>
			<sprite id = "BIRD_RED_FLYING_YELL" x = "690" y = "730" width = "49" height = "47"/>
			<sprite id = "PIG_HELMET_01" x = "425" y = "470" width = "103" height = "88"/>
			<sprite id = "BIRD_BLACK_1" x = "799" y = "1" width = "67" height = "89"/>
			<sprite id = "PIG_HELMET_03" x = "425" y = "740" width = "103" height = "88"/>
			<sprite id = "BIRD_BLUE_FLYING" x = "494" y = "830" width = "32" height = "31"/>
			<sprite id = "PIG_HELMET_02_BLINK" x = "425" y = "560" width = "103" height = "88"/>
			<sprite id = "BIRD_WHITE_FLYING" x = "134" y = "694" width = "86" height = "106"/>
			<sprite id = "PIG_BASIC_SMALL_01_SMILE" x = "690" y = "828" width = "47" height = "46"/>
			<sprite id = "PIG_BASIC_MEDIUM_03_SMILE" x = "690" y = "650" width = "78" height = "78"/>
			<sprite id = "PIG_HELMET_03_SMILE" x = "635" y = "560" width = "103" height = "88"/>
			<sprite id = "PIG_MUSTACHE_01_BLINK" x = "134" y = "150" width = "119" height = "108"/>
			<sprite id = "BIRD_WHITE_YELL" x = "431" y = "260" width = "86" height = "106"/>
			<sprite id = "PIG_BASIC_SMALL_01_BLINK" x = "820" y = "560" width = "47" height = "46"/>
			<sprite id = "PIG_MUSTACHE_02_SMILE" x = "618" y = "150" width = "119" height = "108"/>
			<sprite id = "BIRD_RED_BLINK" x = "802" y = "368" width = "49" height = "47"/>
			<sprite id = "PIG_HELMET_01_SMILE" x = "635" y = "470" width = "103" height = "88"/>
			<sprite id = "PIG_BASIC_BIG_02_BLINK" x = "255" y = "470" width = "99" height = "100"/>
			<sprite id = "PIG_BASIC_MEDIUM_02_BLINK" x = "530" y = "810" width = "78" height = "78"/>
			<sprite id = "PIG_KING_03" x = "1" y = "150" width = "131" height = "147"/>
			<sprite id = "PIG_KING_01_BLINK" x = "134" y = "1" width = "131" height = "147"/>
			<sprite id = "PIG_BASIC_BIG_03_BLINK" x = "255" y = "776" width = "99" height = "100"/>
			<sprite id = "PIG_BASIC_SMALL_01" x = "203" y = "851" width = "47" height = "46"/>
			<sprite id = "BIRD_BLACK_SPECIAL_2" x = "733" y = "368" width = "67" height = "89"/>
			<sprite id = "PIG_KING_02_SMILE" x = "666" y = "1" width = "131" height = "147"/>
			<sprite id = "PIG_MUSTACHE_01_SMILE" x = "255" y = "150" width = "119" height = "108"/>
			<sprite id = "BIRD_BLACK_FLYING_YELL" x = "595" y = "368" width = "67" height = "89"/>
			<sprite id = "PIG_MUSTACHE_02" x = "376" y = "150" width = "119" height = "108"/>
			<sprite id = "PIG_BASIC_SMALL_02" x = "741" y = "730" width = "47" height = "46"/>
			<sprite id = "PIG_KING_03_SMILE" x = "1" y = "448" width = "131" height = "147"/>
			<sprite id = "BIRD_YELLOW_YELL" x = "770" y = "650" width = "67" height = "54"/>
			<sprite id = "PIG_BASIC_MEDIUM_01_BLINK" x = "740" y = "560" width = "78" height = "78"/>
			<sprite id = "PIG_KING_01_SMILE" x = "267" y = "1" width = "131" height = "147"/>
			<sprite id = "BIRD_BLACK_FLYING" x = "526" y = "368" width = "67" height = "89"/>
			<sprite id = "PIG_BASIC_MEDIUM_03" x = "610" y = "730" width = "78" height = "78"/>
			<sprite id = "PIG_BASIC_SMALL_03_SMILE" x = "790" y = "826" width = "47" height = "46"/>
			<sprite id = "PIG_BASIC_BIG_01" x = "519" y = "260" width = "99" height = "100"/>
			<sprite id = "PIG_BASIC_SMALL_03" x = "741" y = "826" width = "47" height = "46"/>
			<sprite id = "PIG_MUSTACHE_03_BLINK" x = "1" y = "597" width = "119" height = "108"/>
			<sprite id = "PIG_HELMET_02" x = "740" y = "470" width = "103" height = "88"/>
			<sprite id = "PIG_HELMET_01_BLINK" x = "530" y = "470" width = "103" height = "88"/>
			<sprite id = "BIRD_BLACK_SPECIAL" x = "664" y = "368" width = "67" height = "89"/>
			<sprite id = "BIRD_BLUE_1" x = "822" y = "260" width = "32" height = "31"/>
			<sprite id = "BIRD_BLUE_BLINK" x = "822" y = "326" width = "32" height = "31"/>
			<sprite id = "BIRD_BLUE_FLYING_YELL" x = "494" y = "863" width = "32" height = "31"/>
			<sprite id = "BIRD_YELLOW_1" x = "799" y = "92" width = "67" height = "54"/>
			<sprite id = "PIG_KING_02_BLINK" x = "533" y = "1" width = "131" height = "147"/>
			<sprite id = "PIG_KING_01" x = "1" y = "1" width = "131" height = "147"/>
		</data>
	}
}