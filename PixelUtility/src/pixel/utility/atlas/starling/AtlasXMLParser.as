package pixel.utility.atlas.starling
{
	import pixel.utility.atlas.starling.vo.SubTexture;
	import pixel.utility.atlas.starling.vo.TextureAtlas;
	
	/**
	 * starling格式sprite序列帧配置解析
	 * 
	 **/
	public class AtlasXMLParser
	{
		public static const TAG_TEXTUREATLAS:String = "TextureAtlas";
		public static const TAG_SUBTEXTURE:String = "SubTexture";
		
		public static const ATTR_IMGPATH:String = "imagePath";
		public static const ATTR_NAME:String = "name";
		public static const ATTR_X:String = "x";
		public static const ATTR_Y:String = "y";
		public static const ATTR_WIDTH:String = "width";
		public static const ATTR_HEIGHT:String = "height";
		public static const ATTR_FX:String = "frameX";
		public static const ATTR_FY:String = "frameY";
		public static const ATTR_FW:String = "frameWidth";
		public static const ATTR_FH:String = "frameHeight";
		
		public function AtlasXMLParser()
		{
		}
		
		public function parse(cfg:String):TextureAtlas
		{
			var doc:XML = new XML(cfg);
			var textures:XMLList = doc.SubTexture;
			var atlas:TextureAtlas = new TextureAtlas();
			atlas.imagePath = doc.imagePath;
			
			var texture:SubTexture = null;
			var node:XML = null;
			for each(node in textures)
			{
				texture = new SubTexture();
				texture.name = node.@name;
				texture.x = node.@x;
				texture.y = node.@y;
				texture.width = node.@width;
				texture.height = node.@height;
				texture.frameWidth = node.@frameWidth;
				texture.frameHeight = node.@frameHeight;
				texture.frameX = node.@frameX;
				texture.frameY = node.@frameY;
				atlas.pushTexture(texture);
			}
			return atlas;
		}
	}
}