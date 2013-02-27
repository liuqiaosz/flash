package 
{
	import bleach.message.BleachMessage;
	import bleach.protocol.Protocol;
	import bleach.protocol.ProtocolCreatePlayer;
	import bleach.protocol.ProtocolCreatePlayerResp;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextInteractionMode;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import pixel.core.PixelSprite;
	import pixel.core.PixelSpriteSheet;
	import pixel.message.PixelMessage;
	import pixel.texture.PixelTextureFactory;
	import pixel.texture.event.PixelTextureEvent;
	import pixel.texture.vo.PixelTexturePackage;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIContainer;
	import pixel.ui.control.UIControl;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.UITextInput;
	import pixel.ui.control.vo.UIMod;
	import bleach.scene.GenericScene;

	public class ChooseRoleScene extends GenericScene
	{
		public function ChooseRoleScene()
		{
			super();
		}
		
		private var role:PixelSprite = null;
		private var role01:UIButton = null;
		private var role02:UIButton = null;
		private var role03:UIButton = null;
		private var role04:UIButton = null;
		private var rolePower:PixelSpriteSheet = null;
		private var enter:UIButton = null;
		private var playerName:UITextInput = null;
		private var ui:UIControl = null;
		override public function initializer():void
		{
			var effect:Object = getDefinitionByName("effect.rolepower");
			if(effect)
			{
				//chooserole001
				var effectData:ByteArray = new effect() as ByteArray;
				var pack:PixelTexturePackage = PixelTextureFactory.instance.decode(effectData);
				PixelTextureFactory.instance.addEventListener(PixelTextureEvent.PACKAGE_DECODE_SUCCESS,function(event:Event):void{
					rolePower = new PixelSpriteSheet(pack);
					pack.playGap = 100;
					addChild(rolePower);
				});
				PixelTextureFactory.instance.asyncDecodeTexturePackage(pack);
			}
			role = new PixelSprite();
			
			var cls:Object = getDefinitionByName("ui.chooserole");
			var data:ByteArray = new cls() as ByteArray;
			var mod:UIMod = UIControlFactory.instance.decode(data,false);
			ui = mod.controls.pop().control;
			ui.x = 0;
			ui.y = 0;
			addChild(ui);
			
			role01 = UIContainer(ui).GetChildById("chooserole001",true) as UIButton;
			enter = UIContainer(ui).GetChildById("chooserole016",true) as UIButton;
			playerName = UIContainer(ui).GetChildById("textinput",true) as UITextInput;
			playerName.text = "Hero Monster";
			enter.addEventListener(MouseEvent.CLICK,createPlayer);
//			role01.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
////				var a:Object = getDefinitionByName("choose_role013");
////				if(a)
////				{
////					role.image = new a() as BitmapData;
////				}
//				var msg:BleachMessage = new BleachMessage(BleachMessage.BLEACH_POPWINDOW_MODEL);
//				msg.value = "loginScene"; 
//				dispatchMessage(msg);
//			});
			//role01.addEventListener(MouseEvent.CLICK,createPlayer);
			//addChild(role);
		}
		
		private function createPlayer(event:MouseEvent):void
		{
			var msg:ProtocolCreatePlayer = new ProtocolCreatePlayer();
			//msg.playerName = "Hero Monster";
			msg.playerName = playerName.text;
			msg.templateId = 0;
			sendNetMessage(msg);
			addNetListener(Protocol.SM_CreatePlayer,createResponse);
		}
		
		private function createResponse(msg:ProtocolCreatePlayerResp):void
		{
			if(msg.respCode == 0)
			{
				debug("创建角色成功");
				var direct:BleachMessage = new BleachMessage(BleachMessage.BLEACH_WORLD_REDIRECT);
				direct.value = "WorldScene";
				dispatchMessage(direct);
			}
			else
			{
				debug("创建失败[" + this.getErrorDescByCode(msg.respCode) + "]");
			}
			
		}
		
		override protected function sceneUpdate():void
		{
			if(rolePower)
			{
				var w:int = rolePower.frame.bitmap.width;
				var h:int = rolePower.frame.bitmap.height;
				role.x = rolePower.x = (1000 - w) /2;
				role.y = rolePower.y = (600 - h) /2 + 100;
				//rolePower.update();
			}
		}
		
		override public function dispose():void
		{
			ui.dispose();
			ui = null;
		}
	}
}