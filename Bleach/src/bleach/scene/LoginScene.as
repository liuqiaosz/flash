package bleach.scene
{
	import bleach.message.BleachLoadingMessage;
	import bleach.message.BleachMessage;
	import bleach.message.BleachNetMessage;
	import bleach.module.message.IMsg;
	import bleach.module.message.MsgIdConstants;
	import bleach.module.message.MsgLogin;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import pixel.message.PixelMessageBus;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.UIPanel;
	import pixel.ui.control.UITextInput;
	import pixel.ui.control.asset.PixelAssetManager;
	import pixel.ui.control.event.DownloadEvent;
	import pixel.ui.control.vo.UIMod;


	public class LoginScene extends GenericScene
	{
		public function LoginScene()
		{
			super();
		}
		
	 	override public function initializer():void
		{
			var cls:Object = getDefinitionByName("ui.login");
			var data:ByteArray = new cls() as ByteArray;
			var mod:UIMod = UIControlFactory.instance.decode(data,false);
			login = mod.controls.pop().control;
			addChild(login);
			
			var ids:Vector.<String> = login.ChildrenIds;
			submit = login.GetChildById("Submit",true) as UIButton;
			account = login.GetChildById("accName",true) as UITextInput;
			password = login.GetChildById("accPwd",true) as UITextInput;
			
			if(submit)
			{
				submit.addEventListener(MouseEvent.CLICK,loginSubmit);
			}
			//s.addEventListener(MouseEvent.CLICK,loginSubmit);
		}
		
		private var login:UIPanel = null;
		private var submit:UIButton = null;
		private var account:UITextInput = null;
		private var password:UITextInput = null;
		
		/**
		 * 登陆提交
		 **/
		private function loginSubmit(event:MouseEvent):void
		{
//			var msg:BleachMessage = new BleachMessage(BleachMessage.BLEACH_WORLD_REDIRECT);
//			msg.value = "WorldScene";
//			msg.deallocOld = true;
//			dispatchMessage(msg);
			//监听登陆消息响应
//			addMessageListener(BleachNetMessage.BLEACH_NET_RECVMESSAGE,onLoginResponse);
			
			addNetListener(MsgIdConstants.MSG_LOGIN_RESP,onLoginResponse);
			//发送登陆消息
			var msg:MsgLogin = new MsgLogin();
			msg.accName = "user1";
			msg.accPwsd = "1";
			var login:BleachNetMessage = new BleachNetMessage(BleachNetMessage.BLEACH_NET_SENDMESSAGE);
			login.value = msg;
			dispatchMessage(login);
		}
		
		/**
		 * 登陆报文返回回调
		 * 
		 **/
		private function onLoginResponse(message:IMsg):void
		{
			removeNetListener(MsgIdConstants.MSG_LOGIN_RESP,onLoginResponse);
			
		}
		
		override public function dealloc():void
		{
			submit.removeEventListener(MouseEvent.CLICK,loginSubmit);
			removeChild(login);
			login.dispose();
			login = null;
			submit = null;
			account = null;
			password = null;
		}
	}
}