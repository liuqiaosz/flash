package editor.model
{
	import corecom.control.Container;
	import corecom.control.UIControl;
	
	import editor.ui.ComponentProfile;
	
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * 组件模型数据类
	 **/
	public class ComponentModel extends ComponentProfile
	{
		public var ModelFile:File = null;
		private var _ModelByte:ByteArray = null;
		public var _Control:UIControl = null;
		public var Children:Array = [];
		public var Symbol:Dictionary = new Dictionary();
		
		public function set Control(Value:UIControl):void
		{
			_Control = Value;
//			if(_Control is corecom.control.Container)
//			{
//				Children = corecom.control.Container(_Control).Children;
//			}
		}
		public function get ModelByte():ByteArray
		{
			return _ModelByte;
		}
		public function set ModelByte(Value:ByteArray):void
		{
			_ModelByte = Value;
		}
		
		public function get Control():UIControl
		{
			return _Control;
		}
		
		public function ComponentModel()
		{
		}
		
		public function get CreateDate():Number
		{
			if(ModelFile)
			{
				return ModelFile.creationDate.time;
			}
			return 0;
		}
	}
}