package pixel.worker.core
{
	import flash.system.Worker;
	import flash.utils.ByteArray;

	use namespace PixelWorkerNs;
	
	public class ShareMemory
	{
		public static const SHAREMEMORY:String = "ShareMemory";
		public static const SHARE_BYTEARRAY:String = "ShareByteArray";
		
		private static var _instance:ShareMemory = null;
		
		private var _memory:Array = [];
		private var _byteArrayMemory:ByteArray = new ByteArray();
		public function ShareMemory()
		{
			if(_instance)
			{
				throw new Error("Cannot instance");
			}
			Worker.current.setSharedProperty(SHAREMEMORY,_memory);
			Worker.current.setSharedProperty(SHARE_BYTEARRAY,_byteArrayMemory);
		}
		
		PixelWorkerNs static function initializer():void
		{
			_instance = new ShareMemory();
		}
		
		public static function setByteArrayMemory(value:ByteArray):void
		{
			if(_instance)
			{
				_instance.setByteArrayMemory(value);
			}
		}
		
		public static function setMemoryProperty(value:Object):int
		{
			if(_instance)
			{
				return _instance.setProperty(value);
			}
			return -1;
		}
		public static function getMemoryProperty(idx:int):Object
		{
			if(_instance)
			{
				return _instance.getProperty(idx);
			}
			return null;
		}
		
		public function setProperty(value:Object):int
		{
			_memory.push(value);
			return _memory.indexOf(value);
		}
		
		public function getProperty(idx:int):Object
		{
			if(_memory.length > idx)
			{
				return _memory[idx];
			}
			return null;
		}
		public function setByteArrayMemory(value:ByteArray):void
		{
			_byteArrayMemory.clear();
			_byteArrayMemory.shareable = true;
			_byteArrayMemory.writeBytes(value,0,value.length);
			Worker.current.setSharedProperty(SHARE_BYTEARRAY,_byteArrayMemory);
			trace(_byteArrayMemory.length + "");
		}
		public function getByteArrayMemory():ByteArray
		{
			var value:ByteArray = new ByteArray();
			value.writeBytes(_byteArrayMemory,0,_byteArrayMemory.length);
			return value;
		}
	}
}