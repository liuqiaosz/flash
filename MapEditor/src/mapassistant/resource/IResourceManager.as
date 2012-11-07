package mapassistant.resource
{
	import flash.events.IEventDispatcher;

	public interface IResourceManager extends IEventDispatcher
	{
		function Load(LibNav:String):void;
		function get SourceVec():Vector.<Resource>;
		function FindResourceBySimpleName(SimpleName:String):Resource;
	}
}