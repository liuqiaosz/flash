package game.sdk.core
{
	public class PopUpManager
	{
		private static var _Instance:IPopUp = null;
		public function PopUpManager()
		{
		}
		
		public static function get Instance():IPopUp
		{
			if(null == _Instance)
			{
				_Instance = new PopUpManagerImpl();
			}
			
			return _Instance;
		}
	}
}
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.EventDispatcher;

import game.sdk.core.Game;
import game.sdk.core.IPopUp;

class PopUpManagerImpl extends EventDispatcher implements IPopUp
{
	protected var _Stack:Vector.<Sprite> = null;
	private var _Stage:Stage = null;
	private var _Canvas:PopUpLayer = null;
	private var _Current:Sprite = null;
	public function PopUpManagerImpl()
	{
		super();
		_Stage = Game.GameApp.stage;
		_Stack = new Vector.<Sprite>();
		_Canvas = new PopUpLayer();
		_Canvas.addEventListener(PopUpEvent.POPUP_CLOSE,ModelPopUpClos);
		_Stage.addChild(_Canvas);
	}
	
	protected function ModelPopUpClos(event:PopUpEvent):void
	{
		if(_Current)
		{
			RemovePopUp(_Current);
			_Current = null;
		}
	}
	
	public function PopUp(Obj:Sprite,Model:Boolean = false,Center:Boolean = false):void
	{
		if(Model)
		{
			_Canvas.MaskShow();
			_Current = Obj;
		}
		if(Center)
		{
			Obj.x = _Stage.stageWidth - Obj.width;
			Obj.y = _Stage.stageHeight - Obj.height;
		}
		if(_Stack.indexOf(Obj) < 0)
		{
			_Stack.push(Obj);
			_Canvas.addChild(Obj);
		}
	}
	
	public function RemovePopUp(Obj:Sprite = null):void
	{
		var Idx:uint = _Stack.indexOf(Obj);
		if(Obj && Idx >= 0)
		{
			_Canvas.removeChild(Obj);
			_Stack.splice(Idx,1);
			if(_Current == Obj)
			{
				_Canvas.MaskHide();
				_Current = null;
			}
		}
	}
}

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

class PopUpLayer extends Sprite
{
	protected var _Mask:Sprite = null;
	//protected var _CurrentPop:Sprite = null;
	public function PopUpLayer()
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE,OnAdded);
	}
	
	protected function OnAdded(event:Event):void
	{
		removeEventListener(Event.ADDED_TO_STAGE,OnAdded);
		_Mask = new Sprite();
		_Mask.graphics.clear();
		_Mask.graphics.beginFill(0x000000,0.5);
		_Mask.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
		_Mask.addEventListener(MouseEvent.CLICK,MaskClick);
	}
	
	protected function MaskClick(event:MouseEvent):void
	{
		event.stopPropagation();
		dispatchEvent(new PopUpEvent(PopUpEvent.POPUP_CLOSE));
	}
	
	public function MaskShow():void
	{
		addChild(_Mask);
	}
	public function MaskHide():void
	{
		//_Mask.visible = false;
		removeChild(_Mask);
	}
}

class PopUpItem
{
	public var Model:Boolean = false;
	public var Item:DisplayObject = null;
	public var Mask:Sprite = null;
}

class PopUpEvent extends Event
{
	public static const POPUP_CLOSE:String = "PopUpClose";
	public function PopUpEvent(Type:String)
	{
		super(Type);
	}
}