package editor.ui
{
	import corecom.control.UIControl;
	
	import editor.event.NotifyEvent;
	import editor.model.asset.Asset;
	import editor.model.asset.AssetBitmap;
	import editor.utils.Globals;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	import spark.components.VGroup;

	public class AdvancePropertyGroup extends VGroup
	{
		public function AdvancePropertyGroup()
		{
		}
		
		[Bindable]
		protected var _ControlWidth:int = 0;
		[Bindable]
		protected var _ControlHeight:int = 0;
		
		public function set ControlWidth(Value:int):void
		{
			_ControlWidth = Value;
			if(_CurrentControl)
			{
				_CurrentControl.width = Value;
			}
		}
		
		
		public function set ControlHeight(Value:int):void
		{
			_ControlHeight = Value;
			if(_CurrentControl)
			{
				_CurrentControl.height = Value;
			}
		}
		
		private var _CurrentControl:UIControl = null;
		public function set Control(Value:UIControl):void
		{
			_CurrentControl = Value;
			ControlWidth = Value.width;
			ControlHeight = Value.height;
			Initialized();
		}
		
		public function get Control():UIControl
		{
			return _CurrentControl;
		}
		
		/**
		 * 初始化数据
		 **/
		protected function Initialized():void
		{
			
		}
		
		protected function BrowserImage(event:MouseEvent):void
		{
			var Notify:NotifyEvent = new NotifyEvent(NotifyEvent.CHANGEIMAGE);
			Notify.Params.push(OnImageSelectedNotify);
			dispatchEvent(Notify);
		}
		
		protected function OnImageSelectedNotify(LibraryId:String,AssetId:String):void
		{
			var AssetItem:Asset = Globals.FindAssetById(LibraryId,AssetId);
			if(null != AssetItem && AssetItem is AssetBitmap)
			{
				ImageSelected(AssetBitmap(AssetItem).Image,AssetId);
				//_CurrentControl.Style.BackgroundImage = AssetBitmap(AssetItem).Image;
				//_CurrentControl.Style.BackgroundImageId = AssetId;
				//_CurrentControl.Update();
				//BackgroundImg.text = AssetItem.Id;
			}
		}
		
		protected function ImageSelected(Image:Bitmap,ImageId:String):void
		{
			
		}
	}
}