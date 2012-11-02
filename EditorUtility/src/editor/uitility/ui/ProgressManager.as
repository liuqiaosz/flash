package editor.uitility.ui
{
	public class ProgressManager
	{
		private static var _Instance:IProgress = null;
		public function ProgressManager()
		{
		}
		
		public static function get Instance():IProgress
		{
			if(null == _Instance)
			{
				_Instance = new Progress();
			}
			return _Instance;
		}
	}
}

import editor.uitility.ui.IProgress;

import flash.display.DisplayObject;
import flash.events.Event;

import mx.controls.ProgressBar;
import mx.controls.ProgressBarMode;
import mx.core.FlexGlobals;
import mx.managers.PopUpManager;
import mx.managers.SystemManager;

class Progress implements IProgress
{
	private var Bar:ProgressBar = null;
	public function Progress()
	{
		Bar = new ProgressBar();
		Bar.mode = ProgressBarMode.MANUAL;
	}
	
	public function Show():void
	{
		Clearup();
		PopUpManager.addPopUp(Bar,FlexGlobals.topLevelApplication as DisplayObject,true);
		PopUpManager.centerPopUp(Bar);
	}
	
	public function Hide():void
	{
		PopUpManager.removePopUp(Bar);
	}
	
	private function Clearup():void
	{
		Bar.setProgress(0,100);
	}
	
	public function Update(Value:int,MaxValue:int):void
	{
		Bar.setProgress(Value,MaxValue);
	}
	
	public function set Label(Value:String):void
	{
		Bar.label = Value;
	}
}