package pixel.ui.control.style
{
	public class UIStyleFactory
	{
		public function UIStyleFactory()
		{
		}
	}
}
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.utils.ByteArray;

import pixel.ui.control.style.IUIStyleFactory;
import pixel.ui.control.vo.UIStyleMod;

class UIStyleFactoryImpl extends EventDispatcher implements IUIStyleFactory
{
	public function findStyleById(id:String):UIStyleMod
	{
		return null;
	}
	
	public function encode(styles:Vector.<UIStyleMod>):ByteArray
	{
		return null;	
	}
	
	public function decode(data:ByteArray):Vector.<UIStyleMod>
	{
		return null;
	}
	
}