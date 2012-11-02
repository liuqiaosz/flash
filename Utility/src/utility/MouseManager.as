package utility
{
	import flash.display.Bitmap;

	public class MouseManager
	{	
		private static var _Instance:IMouse = null;
		public static function get Instance():IMouse
		{
			if(null == _Instance)
			{
				_Instance = new MouseImpl();
			}
			return _Instance;
		}
	}
}
import flash.display.BitmapData;
import flash.ui.Mouse;
import flash.ui.MouseCursorData;

import utility.IMouse;

class MouseImpl implements IMouse
{
	private var _DefaultMouseName:String = flash.ui.Mouse.cursor;
	private var _CurrentMouseName:String = flash.ui.Mouse.cursor;
	private var _RegistedCursor:Vector.<String> = new Vector.<String>();	//已注册的鼠标
	public function Register(Name:String,Images:Array,Show:Boolean = false,FrameRate:int=100):void
	{
		var Data:MouseCursorData = new MouseCursorData();
		Data.frameRate = FrameRate;
		Data.data = new Vector.<BitmapData>();
		for(var Idx:int=0; Idx<Images.length; Idx++)
		{
			Data.data.push(Images[Idx]);
		}
		flash.ui.Mouse.registerCursor(Name,Data);
		_RegistedCursor.push(Name);
		if(Show)
		{
			flash.ui.Mouse.cursor = Name;
			_CurrentMouseName = Name;
		}
	}
	
	public function ShowCursor(Name:String):void
	{
		if(_RegistedCursor.indexOf(Name) < 0)
		{
			throw new Error("No register cursor");
		}
		
		flash.ui.Mouse.cursor = _CurrentMouseName = Name;
	}
	
	public function Default():void
	{
		flash.ui.Mouse.cursor = _CurrentMouseName = _DefaultMouseName;
	}
}