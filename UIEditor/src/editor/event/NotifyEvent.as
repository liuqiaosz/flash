package editor.event
{
	import flash.events.Event;

	public class NotifyEvent extends Event
	{
		public static const WINDOW_CLOSE:String = "WindowClose";
		public static const WINDOW_ENTER:String = "WindowEnter";
		public static const COMPONENT_DRAG_START:String = "ComponentDragStart";
		public static const COMPONENT_DRAG_END:String = "ComponentDragEnd";
		public static const COMPONENT_SELECTED:String = "ComponentSelected";
		public static const COMPONENT_CHOICE:String = "ComponentChoice";
		
		public static const PREFERENCE_DELASSETPATH:String = "DeleteAssetPath";
		public static const ASSETLIBCREATED:String = "AssetLibraryCreated";
		public static const DELETEASSET:String = "DeleteAsset";
		public static const IMPORTSWF:String = "ImportSwf";
		public static const CHANGEIMAGE:String = "OnChangeImage";
		public static const SELECTASSET:String = "SelectAsset";
		public static const SELECTEDASSET:String = "SelectedAsset";	//确认选中的资源
		
		public static const CHANGESTYLE_TABBAR:String = "ChangeStyleTabBar";
		public static const UPDATECONSTRUCT:String = "UpdateConstruct";
		public static const SHELLSELECTED:String = "ShellSelected";
		
		public static const COMBOBOX_NEWITEM:String = "NewComboboxItem";
		
		public static const STYLE_SELECTED:String = "StyleSelected";
		public static const STYLE_SAVED:String = "StyleSaved";
		private var _Message:String = "";
		public function set Message(Value:String):void
		{
			_Message = Value;
		}
		public function get Message():String
		{
			return _Message;
		}
		
		private var _Params:Array = [];
		public function get Params():Array
		{
			return _Params;
		}
		public function NotifyEvent(Type:String,Bubbles:Boolean = true)
		{
			super(Type,Bubbles);
		}
	}
}