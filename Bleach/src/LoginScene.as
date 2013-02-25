package 
{
	import bleach.message.BleachLoadingMessage;
	import bleach.message.BleachMessage;
	import bleach.message.BleachNetMessage;
	import bleach.message.BleachPopUpMessage;
	import bleach.module.protocol.IProtocol;
	import bleach.module.protocol.Protocol;
	import bleach.module.protocol.ProtocolCheckAccount;
	import bleach.module.protocol.ProtocolCheckAccountResp;
	import bleach.module.protocol.ProtocolLogin;
	import bleach.module.protocol.ProtocolLoginResp;
	import bleach.scene.ui.PopUpMaskPreloader;
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
	import bleach.scene.GenericScene;


	public class LoginScene extends GenericScene
	{
		public function LoginScene()
		{
			super();
		}
		private var cfg:ShareDisk = ShareObjectHelper.findShareDisk(Constants.CFG_LOCAL);
	 	override public function initializer():void
		{
			debug("初始化登陆场景");
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
			account.text = "lq";
			password.text = "123456";
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
			debug("登陆场景初始化完成");
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
			//锁屏并且显示内容
//			var msg:BleachPopUpMessage = new BleachPopUpMessage(BleachPopUpMessage.BLEACH_POPUP_SHOW);
//			msg.value = new PopUpMaskPreloader();
//			PopUpMaskPreloader(msg.value).updateDesc("登陆较验中，请稍后...11111111111111111111111");
//			dispatchMessage(msg);
//			return;
			
			//发送账户验证消息
			addNetListener(Protocol.SM_CheckAccount,accountCheckResponse);
			var checkAccount:ProtocolCheckAccount = new ProtocolCheckAccount();
			checkAccount.accName = account.text;
			checkAccount.accPwsd = password.text;
			sendNetMessage(checkAccount);
		}
		
		/**
		 * 账户检查回应
		 **/
		private function accountCheckResponse(protocol:ProtocolCheckAccountResp):void
		{
			removeNetListener(Protocol.SM_CheckAccount,accountCheckResponse);
			if(protocol.respCode == 0)
			{
				if(protocol.isNew)
				{
					//新用户，进入角色创建场景	
					var direct:BleachMessage = new BleachMessage(BleachMessage.BLEACH_WORLD_REDIRECT);
					direct.value = Constants.SCENE_CHOOSE;
					dispatchMessage(direct);
				}
				else
				{
					addNetListener(Protocol.SM_Login,onLoginResponse);
					//检查正确发起登陆
					debug("发起登陆");
					var msg:ProtocolLogin = new ProtocolLogin();
					msg.accName = account.text;
					msg.accPwsd = password.text; 
					sendNetMessage(msg);
				}
			}
		}
		
		/**
		 * 登陆返回
		 * 
		 **/
		private function onLoginResponse(message:IProtocol):void
		{
			removeNetListener(Protocol.SM_Login,onLoginResponse);
			var msg:ProtocolLoginResp = message as ProtocolLoginResp;
			if(msg.respCode == 0)
			{
				debug("登陆成功,进入战斗大厅");
				//登陆成功，跳转场景
				var direct:BleachMessage = new BleachMessage(BleachMessage.BLEACH_WORLD_REDIRECT);
				direct.value = Constants.SCENE_WORLD;
				dispatchMessage(direct);
			}
			else
			{
				//登陆失败，弹出提示框
				debug("登陆失败,错误码[" + msg.respCode + "] 错误信息[" + getErrorDescByCode(msg.respCode) + "]");
			}
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
		
		override public function dispose():void
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