package utility.swf.tag
{
	import utility.swf.ByteStream;

	public class DoABC extends GenericTag
	{
		public function DoABC(stream:ByteStream = null)
		{
			super(Tag.DOABC,stream);
		}
		
		private var _flag:int;
		private var _name:String = "";
		private var _code:String = "";
		override public function Decode(stream:ByteStream):void
		{
			_flag = stream.ReadUI32();
			_name = stream.FindString();
			var minor:int = stream.ReadUI16();
			var major:int = stream.ReadUI16();
			
			var contantPool:ConstantPool = new ConstantPool(stream);
		}
	}
}
import utility.swf.ByteStream;

class ConstantPool
{
	private var _intCount:uint = 0;
	private var _integer:Vector.<int> = new Vector.<int>();
	
	private var _uintCount:int = 0;
	private var _unit:Vector.<uint> = new Vector.<uint>();
	
	private var _doubleCount:int = 0;
	
	private var _strCount:int = 0;
	public function ConstantPool(stream:ByteStream)
	{
		_intCount = stream.ReadUI8();
		trace(_intCount.toString("2"));
		var idx:int = 0;
		for(idx; idx<_intCount; idx++)
		{
			_integer.push(stream.ReadI32());
		}
		
		_uintCount = stream.ReadUI8();
		for(idx = 0; idx<_uintCount; idx++)
		{
			_unit.push(stream.ReadI16());
		}
		
		_doubleCount = stream.ReadUI8();
		for(idx = 0; idx<_doubleCount; idx++)
		{
			//_unit.push(stream.ReadI32());
		}
		
		var cstr:Array = [];
		_strCount = stream.ReadUI8();
		for(idx = 0; idx<_strCount; idx++)
		{
			var len:int = stream.ReadUI8();
			if(len > 0)
			{
				var str:String = stream.ReadString(len);
				cstr.push(str);
				trace(idx+ "[" + len + "][" + str + "]");
			}
			//trace(stream.FindString());
		}
		trace("en");
		
		var nsCount:int = stream.ReadUI8();
		trace("NS [" + nsCount + "]");
		
		for(idx = 0; idx<nsCount; idx++)
		{
			var kind:int = stream.ReadUI8();
			var name:int = stream.ReadUI8();
			
			trace("Kind[" + kind + "]" + "Idx[" + name + "]Name[" + cstr[name] + "]");
		}
	}
}