package
{
	import com.adobe.utils.AGALMiniAssembler;
	import com.adobe.utils.PerspectiveMatrix3D;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.events.Event;
	
	public class PerspectiveLearn extends Sprite
	{
		[Embed(source="map1.jpg")]
		private var MAP:Class;
		private var _context:Context3D = null;
		private var vertices:Vector.<Number> = null;
		private var index:IndexBuffer3D = null;
		private var ver:VertexBuffer3D = null;
		private var program:Program3D = null;
		public function PerspectiveLearn(context:Context3D)
		{
			_context = context;
			
			//设置矩形的顶点
			vertices = new Vector.<Number>([
				-.4,-.4,0,0,0,
				-.4,.4,0,0,1,
				.4,.4,0,1,1,
				.4,-.4,0,1,0
			]);
			
			ver = _context.createVertexBuffer(4,5);
			ver.uploadFromVector(vertices,0,4);
			index = _context.createIndexBuffer(6);
			index.uploadFromVector(new Vector.<uint>([
				0,1,2,2,3,0
			]),0,6);

			var bit:Bitmap = new MAP() as Bitmap;
			var texture:Texture = _context.createTexture(bit.width,bit.height,Context3DTextureFormat.BGRA,false);
			texture.uploadFromBitmapData(bit.bitmapData);
			
			var assembler:AGALMiniAssembler = new AGALMiniAssembler();
			assembler.assemble(Context3DProgramType.VERTEX,
				"mv44 op va0,vc0\n" +
				"mov v0,va1");
			
			var fragmentAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			fragmentAssembler.assemble(Context3DProgramType.FRAGMENT,
				"tex ft1 v0 fs0<2D,linear,nomip\n" +
				"mov oc,ft1");
			
			program = _context.createProgram();
			program.upload(assembler.agalcode,fragmentAssembler.agalcode);
			var per:PerspectiveMatrix3D = new PerspectiveMatrix3D();
			per.perspectiveFieldOfViewLH(45*Math.PI/180,4/3,0.1,1000);
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		private function onAdded(event:Event):void
		{
			stage.addEventListener(Event.ENTER_FRAME,function(event:Event):void{
			
				_context.clear(1,1,1,1);
			});
		}
	}
}