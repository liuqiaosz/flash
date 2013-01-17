package bleach.module.loader
{
//	import bleach.module.scene.GenericScene;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	
//	import pixel.utility.IDispose;

	public class MaskLoading extends Sprite
	{
		private static var _instance:MaskLoading = null;
		private var _mask:Mask = null;
		
		public function MaskLoading()
		{
			if(_instance)
			{
				throw new Error("Singlton");
			}
			var colorImgClass:Object = ApplicationDomain.currentDomain.getDefinition("image.loadColor");
			var whiteImgClass:Object = ApplicationDomain.currentDomain.getDefinition("image.loadWhite");
			
			var colorBitmap:BitmapData = new colorImgClass() as BitmapData;
			var whiteBitmap:BitmapData = new whiteImgClass() as BitmapData;
			
			_mask = new Mask(whiteBitmap,colorBitmap);
			//_mask.x = (stage.stageWidth - whiteBitmap.width) * 0.5;
			//_mask.y = (stage.stageHeight - whiteBitmap.height) * 0.5;
			addChild(_mask);
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		private function onAdded(event:Event):void
		{
			resizeUpdate();
		}
		private function onRemoved(event:Event):void
		{
			_mask.pause();
		}
		
		public function resizeUpdate():void
		{
			this.graphics.clear();
			this.graphics.beginFill(0x000000);
			this.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			this.graphics.endFill();
			_mask.x = (stage.stageWidth - _mask.width) * 0.5;
			_mask.y = (stage.stageHeight - _mask.height) * 0.5;
		}
		
//		override public function dispose():void
//		{
//			super.dispose();
//			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
//			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
//		}
		
		public static function get instance():MaskLoading
		{
			if(null == _instance)
			{
				_instance = new MaskLoading();
			}
			return _instance;
		}
		
		public function progressUpdate(total:Number,loaded:Number):void
		{
			_mask.progressUpdate(total,loaded);
			if(!_mask.running)
			{
				_mask.start();
			}
		}
	}
}

//import bleach.message.BleachLoadingMessage;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.filters.GlowFilter;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.utils.Timer;
//
//import pixel.core.PixelNode;
//import pixel.message.IPixelMessage;
//import pixel.message.PixelMessage;

class Mask extends Sprite
{
	private var _text:TextField = null;
	private var _image:Bitmap = null;
	private var _bitmap:BitmapData = null;
	private var _whiteMask:BitmapData = null;
	private var _colorMask:BitmapData = null;
	private var _dest:Point = new Point();
	private var _rect:Rectangle = new Rectangle(0,0,0,0);
	private var _format:TextFormat = null;
	//private var _loop:Timer = null;
	private var _running:Boolean = false;
	public function get running():Boolean
	{
		return _running;
	}
	public function Mask(whiteMask:BitmapData,colorMask:BitmapData)
	{
		_whiteMask = whiteMask;
		_colorMask = colorMask;
		
		if(!_whiteMask || !_colorMask)
		{
			throw new Error("Invalid mask");
		}
		
		_bitmap = new BitmapData(_colorMask.width,_colorMask.height);
		_bitmap.copyPixels(_whiteMask,_whiteMask.rect,_dest);
		_rect.width = _colorMask.width;
		_image = new Bitmap(_bitmap);
		addChild(_image);
		_text = new TextField();
		_text.border = true;
		_text.width = whiteMask.width;
		_text.y = _colorMask.height + 20;
		_format = new TextFormat();
		_format.color = 0xFFFFFF;
		_format.align = TextFormatAlign.CENTER;
		_text.setTextFormat(_format);
		addChild(_text);
//		_loop = new Timer(33);
//		_loop.addEventListener(TimerEvent.TIMER,maskFrameUpdate);
	}
	
	public function maskGlow(color:uint = 0xFF0000):void
	{
		var filter:GlowFilter = new GlowFilter(0xff0000,1,30,30);
		_image.filters = [filter];
	}
	
	public function start():void
	{
		//_loop.start();
	}
	
	public function pause():void
	{
		//_loop.stop();
		reset();
	}
	
//	private var _total:Number = 0;
//	private var _loaded:Number = 0;
//	private var _percent:Number = 0;
//	private var _target:Number = 0;
//	private function maskFrameUpdate(event:TimerEvent):void
//	{
//		
//		if(_percent < _target)
//		{
//			_percent += 0.02;
//			_rect.height = _colorMask.height * _percent;
//			if(_rect.height > _colorMask.height)
//			{
//				_rect.height = _colorMask.height;
//			}
//			_bitmap.copyPixels(_colorMask,_rect,_dest);
//			if(_rect.height >=_colorMask.height)
//			{
//				maskGlow();
//				dispatchMessage(new BleachLoadingMessage(BleachLoadingMessage.BLEACH_LOADING_END));
//			}
//		}
//	}
	
	public function reset():void
	{
		_bitmap.copyPixels(_whiteMask,_whiteMask.rect,_dest);
		_rect.height = 0;
//		_total = 0;
//		_loaded = 0;
//		_percent = 0;
		_image.filters = null;
	}
	
	/**
	 * 更新
	 **/
	public function progressUpdate(total:Number,loaded:Number):void
	{
//		_total = total;
//		_loaded = loaded;
//		_target = _loaded / total;
		var percent:Number = loaded / total;
		_rect.height = _colorMask.height * percent;
		if(_rect.height >= _colorMask.height)
		{
			_rect.height = _colorMask.height;
			this.maskGlow();
		}
		_bitmap.copyPixels(_colorMask,_rect,_dest);
	}
	
	public function textUpdate(value:String):void
	{
		_text.text = value;
		_text.setTextFormat(_format);
	}
}