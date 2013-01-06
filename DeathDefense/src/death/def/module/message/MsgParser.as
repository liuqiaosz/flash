package death.def.module.message
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	

	public class MsgParser extends EventDispatcher implements IMsgParser
	{
		public function MsgParser()
		{
			
		}
		
		public function parse(data:ByteArray):IMsg
		{
			var id:int = data.readUnsignedShort();
			var prototype:Object = MsgConstants.findMsgById(id);
			if(prototype)
			{
				var msg:IMsg = new prototype() as IMsg;
				msg.setMessage(data);
				return msg;
			}
			return msg;
		}
		
		/**
		 * 获取消息原型
		 **/
		public function getMsgPrototype(id:int):Object
		{
			return MsgConstants.findMsgById(id);
		}
	}
}