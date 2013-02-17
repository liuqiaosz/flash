package bleach.scene
{
	import bleach.message.BleachNetMessage;
	import bleach.module.protocol.IProtocol;
	import bleach.module.protocol.Protocol;
	import bleach.module.protocol.ProtocolConstants;
	import bleach.module.protocol.ProtocolCreateRoom;
	import bleach.module.protocol.ProtocolCreateRoomResp;
	import bleach.module.protocol.ProtocolEnterGameCenter;
	import bleach.module.protocol.ProtocolEnterGameCenterResp;
	import bleach.module.protocol.ProtocolGetRoomList;
	import bleach.module.protocol.ProtocolGetRoomListResp;
	import bleach.utils.Constants;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
	import pixel.ui.control.IUIContainer;
	import pixel.ui.control.IUIControl;
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
		private var _startGame:UIButton = null;
		//当前页码，总页码
		private var _currentPage:int = 1;
		private var _pageTotal:int = 0;
		
		//房间信息刷新间隔
		private var _refreshGap:Number = 10000;
		public function RoomSquareScene()
		{
			super();
		}
		
		private var _room:IUIContainer = null;
		override public function initializer():void
		{
			var uiDefine:Object = getDefinitionByName("ui.roomsquare");
			if(uiDefine)
			{
				var mod:UIMod = UIControlFactory.instance.decode(new uiDefine() as ByteArray);
				_room = mod.controls.pop().control;
				_room.x = _room.y = 0;
				addChild(_room as DisplayObject);
				
				//main014
				_startGame = _room.GetChildById("main014",true) as UIButton;
				_startGame.addEventListener(MouseEvent.CLICK,onOpenCreateRoomDialog);
				addNetListener(Protocol.SM_EnterGameCenter,onRoomListInitializer);
				var msg:ProtocolEnterGameCenter = new ProtocolEnterGameCenter();
				sendNetMessage(msg);
			}
		}
		
		/**
		 * 打开创建房间选项窗口
		 * 
		 **/
		private function onOpenCreateRoomDialog(event:MouseEvent):void
		{
			addNetListener(Protocol.SM_CreateRoom,onCreateRoomResponse);
			var msg:ProtocolCreateRoom = new ProtocolCreateRoom();
			msg.desc = "test";
			msg.map = 14;
			msg.playerNum = 4;
			msg.password = "123456";
			this.sendNetMessage(msg);
		}
		
		private function onCreateRoomResponse(protocol:ProtocolCreateRoomResp):void
		{
			this.removeNetListener(Protocol.SM_CreateRoom,onCreateRoomResponse);
			debug("room created");
		}
		
		/**
		 * 进入大厅消息返回
		 * 
		 **/
		private function onRoomListInitializer(msg:ProtocolEnterGameCenterResp):void
		{
			
		}
		
		private var _refreshing:Boolean = false;
		//上次刷新房间时间
		private var _lastRefresh:Number = 0;
		/**
		 * 
		 * 
		 **/
		override protected function sceneUpdate():void
		{
			//定时刷新房间
			if(!_refreshing)
			{
				var now:Number = getTimer();
				if(now - _lastRefresh >= _refreshGap)
				{
					debug("刷新房间");
//					addNetListener(Protocol.SM_GetRoomList,onRefreshRoomResponse);
//					//发送刷新协议
//					var protocol:ProtocolGetRoomList = new ProtocolGetRoomList();
//					protocol.page = _currentPage;
//					sendNetMessage(protocol);
//					_refreshing = true;
					_lastRefresh = now;
				}
			}
		}
		
		/**
		 * 房间刷新返回
		 * 
		 **/
		private function onRefreshRoomResponse(protocol:ProtocolGetRoomListResp):void
		{
			removeNetListener(Protocol.SM_GetRoomList,onRefreshRoomResponse);
			debug("刷新房间返回,返回码[" + protocol.respCode + "][" + protocol.totalPage + "]");
		}
		
		override public function dispose():void
		{
			super.dispose();
			removeNetListener(Protocol.SM_EnterGameCenter,onRoomListInitializer);
		}
	}
}