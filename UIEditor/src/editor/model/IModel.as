package editor.model
{
	import corecom.control.UIControl;
	
	import editor.ui.ComponentProfile;
	
	import flash.utils.ByteArray;

	public interface IModel
	{
		//function Encode(ControlShell:Shell,Children:Array,Component:ComponentProfile):ByteArray;
		function Encode(ControlShell:UIControl,Children:Array,Component:ComponentProfile):ByteArray;
		function Decode(Model:ByteArray):ComponentModel;
		//通过类名和包名查找组件模型
		function FindModelByFullName(Pack:String,ClassName:String):ComponentModel;
		//function get Model():ByteArray;
	}
}