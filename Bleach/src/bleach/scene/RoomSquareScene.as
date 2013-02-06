package bleach.scene
{
	import bleach.message.BleachNetMessage;
	import bleach.module.protocol.Protocol;
	import bleach.module.protocol.ProtocolConstants;
	import bleach.module.protocol.ProtocolEnterGameCenter;
	
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
				addNetListener(Protocol.SM_EnterGameCenter,onRoomListInitializer);
				
				trace("发送大厅消息");
				var msg:ProtocolEnterGameCenter = new ProtocolEnterGameCenter();
				sendNetMessage(msg);
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			removeNetListener(Protocol.SM_EnterGameCenter,onRoomListInitializer);
		}
		
		private function onRoomListInitializer(msg:BleachNetMessage):void
		{
			trace("!!!");
		}
	}
}