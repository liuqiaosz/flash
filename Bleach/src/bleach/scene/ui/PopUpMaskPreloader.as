package bleach.scene.ui
{
	import bleach.message.BleachMessage;
	
	import flash.display.Shape;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import pixel.core.PixelLauncher;
	import pixel.core.PixelNode;
	import pixel.core.PixelScreen;
	import pixel.message.PixelMessage;
	
	import pixel.ui.control.IUIControl;
	import pixel.ui.control.UIContainer;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.UIImage;
	import pixel.ui.control.UILabel;
	import pixel.ui.control.vo.UIControlMod;
	import pixel.ui.control.vo.UIMod;
	import flash.utils.getTimer;

	public class PopUpMaskPreloader  extends PixelNode
	{
		//背景遮罩
		private var _mask:Shape = null;
		private var _screen:PixelScreen = null;
		private var _desc:String = "";
		private var _textDesc:UILabel = null;
		private var _loading:UIImage = null;
		private var _panel:UIContainer = null;
		
		public function PopUpMaskPreloader()
		{
			_screen = PixelLauncher.launcher.screen;
			_mask = new Shape();
			_mask.graphics.beginFill(0x000000,0.7);
			_mask.graphics.drawRect(0,0,_screen.screenWidth,_screen.screenHeight);
			_mask.graphics.endFill();
			addChild(_mask);
			
			var preloadData:Object = getDefinitionByName("ui.common");
			if(preloadData)
			{
				var mod:UIMod = UIControlFactory.instance.decode(new preloadData() as ByteArray) as UIMod;
				var controlMod:UIControlMod = mod.findControlById("PreloadPanel");
				if(controlMod)
				{
					_panel = controlMod.control as UIContainer;
					_panel.x = _panel.y = 0;
					_textDesc = _panel.GetChildById("TextDesc",true) as UILabel;
					_loading = _panel.GetChildById("Loading",true) as UIImage;
				}
			}

			addChild(_panel);
			_panel.x = (_screen.screenWidth - _panel.width ) * .5;
			_panel.y = (_screen.screenHeight - _panel.height) * .5;
		}
		
		public function updateDesc(value:String):void
		{
			_desc = value;
			//_preload.desc = value;
			_maxChar = _desc.length;
		}
		
		private var _maxChar:int = 0;
		private var _charIdx:int = 0;
		private var _last:Number = getTimer();
		override public function update():void
		{
			super.update();
			
			var current:Number = getTimer();
			if(current - _last >=80)
			{
				_charIdx++;
				if(_charIdx > _maxChar)
				{
					_charIdx = 0;
					_textDesc.text = "";
					return;
				}
				_textDesc.text = _desc.substr(0,_charIdx);
				_last = current;
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			_textDesc = null;
			_loading = null;
			_panel.dispose();
			_panel = null;
		}
	}
}

//import flash.display.DisplayObject;
//import flash.display.Sprite;
//import flash.events.Event;
//import flash.utils.ByteArray;
//import flash.utils.getDefinitionByName;
//
//import pixel.ui.control.IUIControl;
//import pixel.ui.control.UIContainer;
//import pixel.ui.control.UIControlFactory;
//import pixel.ui.control.UIImage;
//import pixel.ui.control.UILabel;
//import pixel.ui.control.vo.UIControlMod;
//import pixel.ui.control.vo.UIMod;
//
///**
// * 加载弹出界面
// * 
// **/
//class PreloadWindow extends Sprite
//{
//	private var _textDesc:UILabel = null;
//	private var _loading:UIImage = null;
//	private var _panel:UIContainer = null;
//	public function PreloadWindow()
//	{
//		var preloadData:Object = getDefinitionByName("ui.common");
//		if(preloadData)
//		{
//			var mod:UIMod = UIControlFactory.instance.decode(new preloadData() as ByteArray) as UIMod;
//			var controlMod:UIControlMod = mod.findControlById("PreloadPanel");
//			if(controlMod)
//			{
//				_panel = controlMod.control as UIContainer;
//				_panel.x = _panel.y = 0;
//				addChild(_panel as DisplayObject);
//				
//				_textDesc = _panel.GetChildById("TextDesc",true) as UILabel;
//				_loading = _panel.GetChildById("Loading",true) as UIImage;
//			}
//		}
//
//		addEventListener(Event.REMOVED_FROM_STAGE,onRemove);
//		addEventListener(Event.ADDED_TO_STAGE,onAdded);
//	}
//	
//	private function onRemove(event:Event):void
//	{
//		_loading.stopGifPlay();
//	}
//	private function onAdded(event:Event):void
//	{
//		_loading.playGif();
//	}
//	
//	override public function get width():Number
//	{
//		return _panel.width;
//	}
//	override public function get height():Number
//	{
//		return _panel.height;
//	}
//	
//	public function set desc(value:String):void
//	{
//		if(_textDesc)
//		{
//			_textDesc.text = value;
//		}
//	}
//}
