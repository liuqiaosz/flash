package bleach.scene
{
	import bleach.message.BleachNetMessage;
	import bleach.module.message.MsgConstants;
	import bleach.module.message.MsgGameCenter;
	import bleach.module.message.MsgIdConstants;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIContainer;
	import pixel.ui.control.UIControl;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.vo.UIMod;
	
	/**
	 * 游戏大厅场景
	 * 
	 **/
	public class RoomSquareScene extends GenericScene
	{
		
		
		public function RoomSquareScene()
		{
			super();
		}
		
		private var _room:UIControl = null;
		override public function initializer():void
		{
			var uiDefine:Object = getDefinitionByName("ui.roomsquare");
			if(uiDefine)
			{
				var mod:UIMod = UIControlFactory.instance.decode(new uiDefine() as ByteArray);
				_room = mod.controls.pop().control;
				_room.x = _room.y = 0;
				addChild(_room);
				addNetListener(MsgIdConstants.MSG_GAMECENTER_RESP,onRoomListInitializer);
				
				trace("发送大厅消息");
				var msg:MsgGameCenter = new MsgGameCenter();
				sendNetMessage(msg);
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			removeNetListener(MsgIdConstants.MSG_GAMECENTER_RESP,onRoomListInitializer);
		}
		
		private function onRoomListInitializer(msg:BleachNetMessage):void
		{
			trace("!!!");
		}
	}
}