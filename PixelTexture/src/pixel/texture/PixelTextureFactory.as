package pixel.texture
{
	use namespace PixelTextureNS;
	
	public class PixelTextureFactory
	{
		private static var _instance:IPixelTextureFactory = null;
		
		public function PixelTextureFactory()
		{
		}
		
		public static function get instance():IPixelTextureFactory
		{
			if(!_instance)
			{
				_instance = new PixelTextureFactoryImpl();
			}
			return _instance;
		}
	}
}
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.ByteArray;

import pixel.texture.IPixelTextureFactory;
import pixel.texture.PixelTextureEncodeEmu;
import pixel.texture.PixelTextureNS;
import pixel.texture.event.PixelTextureEvent;
import pixel.texture.vo.PixelTexture;
import pixel.texture.vo.PixelTexturePackage;

use namespace PixelTextureNS;
class PixelTextureFactoryImpl extends EventDispatcher implements IPixelTextureFactory
{
	private var _loader:Loader = null;
	private var _queue:Vector.<PixelTexture> = null;
	private var _texture:PixelTexture = null;
	private var _loading:Boolean = false;
	public function PixelTextureFactoryImpl()
	{
		_loader = new Loader();
		_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
		_queue = new Vector.<PixelTexture>();
	}
	
	public function encode(texturePackage:PixelTexturePackage):ByteArray
	{
		var textures:Vector.<PixelTexture> = texturePackage.textures;
		var data:ByteArray = new ByteArray();
		
		data.writeByte(int(texturePackage.isAnim));
		if(texturePackage.isAnim)
		{
			data.writeShort(texturePackage.playGap);
		}
		data.writeShort(textures.length);
		var item:PixelTexture = null;
		var itemData:ByteArray = null;
		for(var idx:int = 0; idx<textures.length; idx++)
		{
			item = textures[idx];
			itemData = pixtelTextureEncode(item);
			data.writeInt(itemData.length);
			data.writeBytes(itemData);
		}
		return data;	
	}
	
	public function decode(data:ByteArray):PixelTexturePackage
	{
		var pack:PixelTexturePackage = new PixelTexturePackage();
		var isAnim:Boolean = Boolean(data.readByte());
		pack.isAnim = isAnim;
		if(pack.isAnim)
		{
			pack.playGap = data.readShort();
		}
		var count:int = data.readShort();
		var len:int = 0;
		var itemData:ByteArray = null;
		var item:PixelTexture = null;
		for(var idx:int = 0; idx<count; idx++)
		{
			len = data.readInt();
			itemData = new ByteArray();
			data.readBytes(itemData,0,len);
			item = pixelTextureDecode(itemData);
			
			pack.addTexture(item);
		}
		return pack;
	}
	
	private var _asyncLoader:Loader = null;
	private var _asyncQueue:Vector.<PixelTexture> = null;
	private var _asyncLoadIndex:int = 0;
	private var _asyncLoadTexture:PixelTexture = null;
	
	/**
	 * 同步解码纹理包
	 * 
	 **/
	public function asyncDecodeTexturePackage(pack:PixelTexturePackage):void
	{
		_asyncLoader = new Loader();
		_asyncLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,decodeComplete);
		_asyncQueue = pack.textures;
		if(pack.textures.length > 0)
		{
			asyncDecodeTexture(_asyncQueue[_asyncLoadIndex]);
		}
	}
	private function asyncDecodeTexture(texture:PixelTexture):void
	{
		_asyncLoadTexture = texture;
		_asyncLoader.loadBytes(texture.source);
	}
	
	private function decodeComplete(event:Event):void
	{
		var bitmap:BitmapData = Bitmap(_asyncLoader.content).bitmapData;
		var pixels:ByteArray = bitmap.getPixels(bitmap.rect);
		pixels.position = 0;
		_asyncLoadTexture.bitmap.setPixels(bitmap.rect,pixels);
		_asyncLoadIndex++;
		
		if(_asyncLoadIndex < _asyncQueue.length)
		{
			asyncDecodeTexture(_asyncQueue[_asyncLoadIndex]);
		}
		else
		{
			_asyncLoader.unload();
			_asyncLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,decodeComplete);
			_asyncLoader = null;
			var notify:PixelTextureEvent = new PixelTextureEvent(PixelTextureEvent.PACKAGE_DECODE_SUCCESS);
			dispatchEvent(notify);
		}
	}
	
	public function asyncLoadTexture(texture:PixelTexture):void
	{
		_queue.push(texture);
		if(!_loading)
		{
			loadTexture();
		}
	}
	
	private function loadTexture():void
	{
		if(_queue.length > 0)
		{
			_loading = true;
			_texture = _queue.shift();
			var source:ByteArray = _texture.source;
			if(source)
			{
				_loader.loadBytes(source);
			}
		}
	}
	
	private function loadComplete(event:Event):void
	{
		var bitmap:BitmapData = Bitmap(_loader.content).bitmapData;
		var pixels:ByteArray = bitmap.getPixels(bitmap.rect);
		pixels.position = 0;
		_texture.bitmap.setPixels(bitmap.rect,pixels);
		if(_queue.length > 0)
		{
			loadTexture();
		}
		else
		{
			_loading = false;
		}
	}
	
	private function pixtelTextureEncode(texture:PixelTexture):ByteArray
	{
		var data:ByteArray = new ByteArray();
		data.writeByte(texture.id.length);
		data.writeUTFBytes(texture.id);
		data.writeShort(texture.imageWidth);
		data.writeShort(texture.imageHeight);
		//data.writeByte(int(_compress));
		data.writeByte(int(texture.encoderEnabled));
		if(texture.encoderEnabled)
		{
			data.writeByte(texture.encoder);
			switch(texture.encoder)
			{
				case PixelTextureEncodeEmu.ENCODER_API:
					data.writeByte(texture.encodeType);
					data.writeByte(texture.encodeQuality);
					break;
				case PixelTextureEncodeEmu.ENCODER_PIXEL:
					data.writeByte(texture.pixelCompressOp);
					break;
			}
		}
		
		
//		data.writeByte(int(texture.customAnchor));
//		if(texture.customAnchor)
//		{
//			data.writeShort(texture.anchor.x);
//			data.writeShort(texture.anchor.y);
//		}
		
		//var pixels:ByteArray = texture.source ? texture.source:texture.bitmap.getPixels(texture.bitmap.rect);
		//			if(_compress)
		//			{
		//				pixels.compress(CompressionAlgorithm.LZMA);	
		//			}
		data.writeInt(texture.source.length);
		data.writeBytes(texture.source);
		return data;
	}
	
	private function pixelTextureDecode(data:ByteArray):PixelTexture
	{
		var texture:PixelTexture = new PixelTexture();
		var len:int = data.readByte();
		texture.id = data.readUTFBytes(len);
		texture.imageWidth = data.readShort();
		texture.imageHeight = data.readShort();
		//_compress = Boolean(data.readByte());
		
		texture.encoderEnabled = Boolean(data.readByte());
		if(texture.encoderEnabled)
		{
			texture.encoder = data.readByte();
			switch(texture.encoder)
			{
				case PixelTextureEncodeEmu.ENCODER_API:
					texture.encodeType = data.readByte();
					texture.encodeQuality = data.readByte();
					break;
				case PixelTextureEncodeEmu.ENCODER_PIXEL:
					texture.pixelCompressOp = data.readByte();
					break;
			}
		}
//		texture.customAnchor = Boolean(data.readByte());
//		if(texture.customAnchor)
//		{
//			texture.anchor.x = data.readShort();
//			texture.anchor.y = data.readShort();
//		}
		
		len = data.readInt();
		texture.source = new ByteArray();
		data.readBytes(texture.source,0,len);
		return texture;
	}
	
	public function dispose():void
	{
		_loader.close();
		_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComplete);
	}
}