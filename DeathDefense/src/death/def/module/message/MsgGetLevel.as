package death.def.module.message
{
	import death.def.module.message.vo.MSGLevel;
	
	import flash.utils.ByteArray;
	
	
	/**
	 * 消息-获取当前世界的所有场景
	 * 
	 **/
	public class MsgGetLevel extends MsgGeneric implements IMsg
	{
		private var _levelCount:int = 0;
		private var _levels:Vector.<MSGLevel> = null;
		public function MsgGetLevel()
		{
			super(MsgIdConstants.MSG_GETLEVEL);
			_levels = new Vector.<MSGLevel>();
		}
		
//		override public function decode(data:ByteArray):void
//		{
//			_levelCount = data.readByte();
//		}
//		
//		override public function encode():ByteArray
//		{
//			var data:ByteArray = new ByteArray();
//			data.writeByte(_levelCount);
//		}
	}
}