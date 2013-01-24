package bleach.scene
{
	import bleach.message.BleachLoadingMessage;
	import bleach.message.BleachMessage;
	import bleach.message.BleachNetMessage;
	import bleach.module.message.IMsg;
	import bleach.module.message.MsgIdConstants;
	import bleach.module.message.MsgLogin;
	import bleach.module.message.MsgLoginResp;
	import bleach.utils.Constants;
	
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
	import pixel.ui.control.UICheckBox;
	import pixel.ui.control.UIContainer;
	import pixel.ui.control.UIControl;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.UIPanel;
	import pixel.ui.control.UITextInput;
	import pixel.ui.control.asset.PixelAssetManager;
	import pixel.ui.control.event.DownloadEvent;
	import pixel.ui.control.event.UIControlEvent;
	import pixel.ui.control.vo.UIMod;
	import pixel.utility.ShareDisk;
	import pixel.utility.ShareObjectHelper;


	public class LoginScene extends GenericScene
	{
		public function LoginScene()
		{
			super();
		}
		private var cfg:ShareDisk = ShareObjectHelper.findShareDisk(Constants.CFG_LOCAL);
	 	override public function initializer():void
		{
			//var cfg:ShareDisk = ShareObjectHelper.findShareDisk(Constants.CFG_LOCAL);
			var saveAccount:Boolean = false;
			if(cfg.containKey(Constants.CFG_KEY_SAVELOGINNAME))
			{
				saveAccount = cfg.getValue(Constants.CFG_KEY_SAVELOGINNAME) as Boolean;
			}
			
			var cls:Object = getDefinitionByName("ui.login");
			var data:ByteArray = new cls() as ByteArray;
			var mod:UIMod = UIControlFactory.instance.decode(data,false);
			login = mod.controls.pop().control;
			addChild(login);
			
			
			submit = login.GetChildById("Submit",true) as UIButton;
			account = login.GetChildById("accName",true) as UITextInput;
			password = login.GetChildById("accPwd",true) as UITextInput;
			checkbox = login.GetChildById("saveAccount",true) as UICheckBox;
			checkbox.selected = saveAccount;
			
			checkbox.addEventListener(UIControlEvent.CHANGE,loginNameSaveChange);
			if(saveAccount)
			{
				//从本地获取保存的账号
				account.text = cfg.getValue(Constants.CFG_KEY_LOGINNAME) as String;
			}
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
		private var checkbox:UICheckBox = null;
		
		/**
		 * 登陆提交
		 **/
		private function loginSubmit(event:MouseEvent):void
		{
//			addNetListener(MsgIdConstants.MSG_LOGIN_RESP,onLoginResponse);
//			//发送登陆消息
//			var msg:MsgLogin = new MsgLogin();
//			var login:BleachNetMessage = new BleachNetMessage(BleachNetMessage.BLEACH_NET_SENDMESSAGE);
//			login.value = msg;
//			dispatchMessage(login);
			var direct:BleachMessage = new BleachMessage(BleachMessage.BLEACH_WORLD_REDIRECT);
			direct.value = "ChooseRoleScene";
			dispatchMessage(direct);
		}
		
		private function loginNameSaveChange(event:UIControlEvent):void
		{
			cfg.addValue(Constants.CFG_KEY_SAVELOGINNAME,checkbox.selected);
			var acc:String = "";
			if(checkbox.selected)
			{
				acc = account.text;
			}
			cfg.addValue(Constants.CFG_KEY_LOGINNAME,acc);
		}
		
		/**
		 * 登陆报文返回回调
		 * 
		 **/
		private function onLoginResponse(message:IMsg):void
		{
			removeNetListener(MsgIdConstants.MSG_LOGIN_RESP,onLoginResponse);
			var msg:MsgLoginResp = message as MsgLoginResp;
			if(msg.respCode == 0)
			{
				//登陆成功，跳转场景
			}
			else
			{
				//登陆失败，弹出提示框
			}
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
			cfg.close();
			cfg = null;
			checkbox = null;
		}
	}
}