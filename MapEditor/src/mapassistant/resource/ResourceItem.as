package mapassistant.resource
{
	import utility.swf.tag.GenericTag;

	public class ResourceItem
	{
		public var Id:String = "";
		public var Source:Object = null;
		public var Type:uint = 0;
		public var Class:String = "";
		public var Owner:String = "";
		public var OwnerSwf:String = "";
		public var Tag:GenericTag = null;
		public function ResourceItem()
		{
		}
	}
}