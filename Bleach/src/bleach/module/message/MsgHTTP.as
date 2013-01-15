package bleach.module.message
{
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	

	public class MsgHTTP extends MsgGeneric implements IMsg
	{
		private var _vars:Dictionary = null;
		public function MsgHTTP(id:int = 0,charset:String = Charset.UTF8)
		{
			super(id,charset);
			_vars = new Dictionary();
		}
		
		override public function getMessage():Object
		{
			var field:MsgField = null;
			var vec:Vector.<String> = new Vector.<String>();
			for each(field in _fields)
			{
				vec.push(field.key + "=" + field.value);
			}
			return vec.join("&");
		}
		
		override public function setMessage(data:Object):void
		{
			var value:String = data as String;
			var values:Array = value.split("&");
			var idx:int = 0;
			for each(value in values)
			{
				idx = value.indexOf("=");
				_vars[value.substring(0,idx)] = value.substr(idx+1);
				//addField(new PixelNetMessageField(value.substring(0,idx),value.substr(idx+1)));
			}
		}
		
		public function getParameter(name:String):String
		{
			if(name in _vars)
			{
				return _vars[name];
			}
			return "";
		}
	}
}