package pixel.utility
{
	import flash.utils.ByteArray;

	/**
	 * 
	 * 3d obj模型文件解析
	 * 
	 **/
	public class Object3DLoader
	{
		
		//行结尾
		public static const ENTER:int = 10;
		// "/"分隔符
		public static const SLASH:int = 0x2f;
		//空格
		public static const SPACE:int = 32;
		
		private var _objStream:ByteArray = null;
		
		private var _obj3D:FileObj3D = null;
		public function Object3DLoader()
		{
		}
		
		/**
		 * 解析OBJ模型文件，返回解析数据对象
		 * 
		 **/
		public function load(stream:ByteArray):FileObj3D
		{
			//_objStream = stream;
			_objStream = new ByteArray();
			_objStream.writeBytes(stream);
			_objStream.position = 0;
			return parse();
		}
		
		private function parse():FileObj3D
		{
			_obj3D = new FileObj3D();
			var line:String = "";
			var codes:Array = null;
			var type:String = "";
			var group:FileObj3DVertexIndexGroup = null;
			while(_objStream && _objStream.bytesAvailable > 0)
			{
				try
				{
					line = readLine(_objStream);
					trace(line);
					codes = line.split(" ");
					type = codes.shift();
					trace("type[" + type + "]");
					if(codes[0] == "")
					{
						codes.shift();
					}
					switch(type)
					{
						case "#":
							break;
						case "v":
							parseVertex(codes);
							break;
						case "vt":
							parseVertexUV(codes);
							break;
						case "vn":
							//法线解析
							parseNormals(codes);
							break;
						case "g":
							group = new FileObj3DVertexIndexGroup(codes[0]);
							break;
						case "f":
							//面解析
							parseIndex(codes,group);
							break;
					}
				}
				catch(err:Error)
				{}
			}
			
			return _obj3D;
		}
		
		/**
		 * 顶点解析
		 * 
		 * @param pos	顶点坐标
		 * v
		 **/
		private function parseVertex(pos:Array):void
		{
			while(pos.length > 0)
			{
				_obj3D.addVertex(pos.shift());
			}
		}
		
		/**
		 * 顶点纹理UV解析
		 * 
		 * @param pos	纹理坐标
		 * vt
		 **/
		private function parseVertexUV(pos:Array):void
		{
			if(pos.length > 2)
			{
				//齐次坐标定义
				_obj3D.addVertexUV(Number(pos[2]) > 0 ? Number(pos[0]) / Number(pos[2]):Number(pos[0]));
				_obj3D.addVertexUV(Number(pos[2]) > 0 ? Number(pos[1]) / Number(pos[2]):Number(pos[1]));
			}
			else
			{
				while(pos.length > 0)
				{
					_obj3D.addVertexUV(pos.shift());
				}
			}
		}
		
		/**
		 * 
		 * 法线解析
		 * 
		 * @param pos	法线坐标
		 * 
		 **/
		private function  parseNormals(pos:Array):void
		{
			while(pos.length > 0)
			{
				_obj3D.addNormals(pos.shift());
			}
		}
		
		/**
		 * 顶点索引解析
		 * 
		 * f
		 * 
		 **/
		private function parseIndex(codes:Array,group:FileObj3DVertexIndexGroup = null):void
		{
			var code:String = "";
			var subCodes:Array = null;
			while(codes.length)
			{
				var idx:FileObj3DVertexIndex = new FileObj3DVertexIndex();
				code = Tools.trim(codes.shift());
				if(code.indexOf("/") >= 0)
				{
					subCodes = code.split("/");
					idx.vertexIdx = int(subCodes[0]);
					idx.uvIdx = int(subCodes[1]);
					if(subCodes.length > 2)
					{
						idx.normalsIdx = int(subCodes[2]);
					}
				}
				else
				{
					idx.vertexIdx = int(code);
				}
				if(group)
				{
					_obj3D.addVertexIndexGroup(group);
				}
				_obj3D.addVertexIndex(idx);
			}
		}
		
		private var _streamPos:int = 0;
		private var _length:int = 0;
		/**
		 * 
		 * 从文件流读取一行，以换行为结尾
		 **/
		private function readLine(stream:ByteArray):String
		{
			_streamPos = stream.position;
			while(stream.readByte() != ENTER){};
			if(stream.position == stream.length)
			{
				return Tools.trim(stream.readUTFBytes(stream.length - _streamPos));
			}
			_length = stream.position - _streamPos + 1;
			if(_length > 0)
			{
				stream.position = _streamPos;
				return Tools.trim(stream.readUTFBytes(_length));
			}
			return "";
		}
	}
}