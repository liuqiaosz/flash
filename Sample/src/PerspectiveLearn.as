package
{
	import com.adobe.utils.AGALMiniAssembler;
	import com.adobe.utils.PerspectiveMatrix3D;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;

	public class PerspectiveLearn extends Sprite
	{
		[Embed(source="arrow_down.png")]
		private var MAP:Class;
		private var _context:Context3D = null;
		private var vertices:Vector.<Number> = null;
		private var index:IndexBuffer3D = null;
		private var ver:VertexBuffer3D = null;
		private var program:Program3D = null;
		private var texture:Texture = null;
		private var per:PerspectiveMatrix3D = null;
		public function PerspectiveLearn(context:Context3D)
		{
			_context = context;
			
			//设置矩形的顶点
			vertices = Vector.<Number>([
				-0.3,-0.3,0, 0, 0,
				-0.3, 0.3, 0, 0, 1,
				0.3, 0.3, 0, 1, 1,
				0.3, -0.3, 0, 1, 0]);
			
			ver = _context.createVertexBuffer(4,5);
			ver.uploadFromVector(vertices,0,4);
			index = _context.createIndexBuffer(6);
			index.uploadFromVector(Vector.<uint>([0,1,2,2,3,0]),0,6);

			var bit:Bitmap = new MAP() as Bitmap;
			texture = _context.createTexture(bit.width,bit.height,Context3DTextureFormat.BGRA,false);
			texture.uploadFromBitmapData(bit.bitmapData);
			
			var assembler:AGALMiniAssembler = new AGALMiniAssembler();
			assembler.assemble(Context3DProgramType.VERTEX,
				"m44 op,va0,vc0\n" +
				"mov v0,va1");
			
			var fragmentAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			fragmentAssembler.assemble(Context3DProgramType.FRAGMENT,
				"tex ft1,v0,fs0<2D,linear,nomip>\n" +
				"mov oc,ft1");
			
			program = _context.createProgram();
			program.upload(assembler.agalcode,fragmentAssembler.agalcode);
			per = new PerspectiveMatrix3D();
			per.perspectiveFieldOfViewLH(45*Math.PI/180,4/3,0.1,1000);
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		private function onAdded(event:Event):void
		{
			stage.addEventListener(Event.ENTER_FRAME,function(event:Event):void{
			
				_context.clear(0,0,0,0);
				_context.setVertexBufferAt(0,ver,0,Context3DVertexBufferFormat.FLOAT_3);
				_context.setVertexBufferAt(1,ver,3,Context3DVertexBufferFormat.FLOAT_2);
				_context.setTextureAt(0,texture);
				_context.setProgram(program);

				var m:Matrix3D = new Matrix3D();
				m.appendRotation(getTimer()/30, Vector3D.Y_AXIS);
				m.appendRotation(getTimer()/10, Vector3D.X_AXIS);
				m.appendTranslation(0, 0, 2);
				m.append(per);
				
				_context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, m, true);
				
				_context.drawTriangles(index);
				
				_context.present();
				trace("!");
			});
		}
	}
}