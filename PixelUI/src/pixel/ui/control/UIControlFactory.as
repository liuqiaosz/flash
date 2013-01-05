package pixel.ui.control
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import pixel.ui.control.vo.UIMod;

	public class UIControlFactory extends EventDispatcher
	{
		private static var _instance:IUIControlFactory = null;
		public function UIControlFactory()
		{
			if(!_instance)
			{
				throw new Error("Singlton");
			}
		}

		public static function get instance():IUIControlFactory
		{
			if(_instance == null)
			{
				_instance = new UIControlFactoryImpl();
			}
			return _instance;
		}
	}
}

import flash.events.EventDispatcher;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import pixel.ui.control.IUIControl;
import pixel.ui.control.IUIControlFactory;
import pixel.ui.control.UIButton;
import pixel.ui.control.UIControl;
import pixel.ui.control.UIPanel;
import pixel.ui.control.UISlider;
import pixel.ui.control.asset.IPixelAssetManager;
import pixel.ui.control.style.IVisualStyle;
import pixel.ui.control.style.UIStyleFactory;
import pixel.ui.control.style.UIStyleLinkEmu;
import pixel.ui.control.style.UIStyleManager;
import pixel.ui.control.utility.Utils;
import pixel.ui.control.vo.UIControlMod;
import pixel.ui.control.vo.UIMod;
import pixel.ui.control.vo.UIStyleMod;
import pixel.ui.core.PixelUINS;

use namespace PixelUINS;
class UIControlFactoryImpl extends EventDispatcher implements IUIControlFactory
{
//	public function Encode(Control:IUIControl):ByteArray
//	{
//		return null;
//	}
	
	//MOD缓存
	private var _cache:Vector.<UIMod> = new Vector.<UIMod>();
	//ID -> UIControl映射缓存
	private var _cacheControls:Dictionary = new Dictionary();
	
	private var _cacheIds:Vector.<String> = new Vector.<String>();
	public function encode(mod:UIMod):ByteArray
	{
		var controls:Vector.<UIControlMod> = mod.controls;
		var styles:Vector.<UIStyleMod> = mod.styles;
		var data:ByteArray = new ByteArray();
		
		//写入局部样式数据
		data.writeBytes(UIStyleFactory.instance.encode(styles));
		
		//写入组件数据
		data.writeShort(controls.length);
		var idx:int = 0;
		var child:ByteArray = null;
		var controlData:ByteArray = new ByteArray();
		var idData:ByteArray = new ByteArray();
		var mapData:ByteArray = new ByteArray();
		var control:UIControl = null;
		for(idx = 0; idx<controls.length; idx++)
		{
			control = controls[idx].control as UIControl;
			
			//组件ID写入
			idData.writeByte(control.Id.length);
			idData.writeUTFBytes(control.Id);
			
			//组件，样式映射关系写入
			if(control.styleLinked && control.styleLinkScope == UIStyleLinkEmu.SCOPE_INLINE)
			{
				var linkIdx:int = styles.indexOf(control.linkStyle);
				mapData.writeByte(idx);
				mapData.writeByte(linkIdx);
			}
			
			child = controls[idx].control.encode();
			controlData.writeInt(child.length);
			controlData.writeBytes(child);
		}
		
		data.writeBytes(idData);
		data.writeBytes(controlData);
		data.writeBytes(mapData);
		
		return data;
	}

	public function decode(data:ByteArray,cache:Boolean = true):UIMod
	{
		var Len:int = 0;
		var mod:UIMod = new UIMod();
		//var Vec:Vector.<IUIControl> = new Vector.<IUIControl>();
		var controls:Vector.<UIControlMod> = new Vector.<UIControlMod>();
		var styleMap:Dictionary = new Dictionary();
		var count:int = 0;
		//独立样式定义
		var prototype:Class = null;
		var child:ByteArray = null;
		
		//局部样式解析
		var styles:Vector.<UIStyleMod> = UIStyleFactory.instance.decode(data);
		for each(var style:UIStyleMod in styles)
		{
			styleMap[style.id] = style;
		}
		
		//组件数量解析
		count = data.readShort();
		//组件ID列表
		var idx:int = 0;
		var ids:Vector.<String> = new Vector.<String>();
		for(idx; idx<count; idx++)
		{
			Len = data.readByte();
			ids.push(data.readUTFBytes(Len));
		}
		
		var controlData:ByteArray = null;
		var controlMod:UIControlMod = null;
		for(idx = 0; idx<count; idx++)
		{
			controlData = new ByteArray();
			Len = data.readInt();
			data.readBytes(controlData,0,Len);
			controlMod = new UIControlMod();
			controlMod.source = controlData;
			controls.push(controlMod);
			//缓存
			if(cache)
			{
				_cacheControls[ids[idx]] = controlMod;
			}
		}
		
		if(cache)
		{
			_cacheIds = _cacheIds.concat(ids);
		}
		
		var controlIdx:int = 0;
		var styleIdx:int = 0;
		while(data.bytesAvailable > 0)
		{
			controlIdx = data.readByte();
			styleIdx = data.readByte();
			controls[controlIdx].linkStyle = styles[styleIdx];
		}
		mod = new UIMod(controls,styles);
		if(cache)
		{
			_cache.push(mod);
		}
		return mod;
	}
	
	public function get controlIds():Vector.<String>
	{
		return _cacheIds;
	}
	
	public function findControlById(id:String):UIControlMod
	{
		if(id in _cacheControls)
		{
			return _cacheControls[id];
		}
		return null;
	}
}