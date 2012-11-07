package mapassistant.resource
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.dns.AAAARecord;
	
	import mapassistant.event.EventConstant;
	import mapassistant.util.Common;
	import mapassistant.util.Tools;
	
	import mx.resources.ResourceManagerImpl;

	/**
	 * 
	 * 资源加载管理类
	 * 
	 * 单例
	 * 
	 **/
	public class ResourceManager
	{
		private static var _Instance:IResourceManager = null;
		public var OnInitializeComplete:Function = null;
		public var OnInitializeError:Function = null;
		public function ResourceManager()
		{
			throw new Error("Invalid operation");
		}
		
		public static function InitializeLibrary(LibraryNav:String = ""):void
		{
			var Nav:String = LibraryNav;
			if("" == Nav || null == Nav)
			{
				Nav = Common.RESOURCE;
			}
			
			Instance.Load(Nav);
		}
		
		public static function get Instance():IResourceManager
		{
			if(!_Instance)
			{
				_Instance = new ResourceManagerImpl();
			}
			return _Instance;
		}
	}
}

import editor.uitility.ui.ProgressManager;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.getTimer;
import flash.xml.XMLDocument;

import mapassistant.event.EventConstant;
import mapassistant.resource.IResourceManager;
import mapassistant.resource.Resource;
import mapassistant.resource.ResourceItem;
import mapassistant.resource.ResourceMode;
import mapassistant.util.Tools;

import mx.events.SWFBridgeEvent;

import utility.swf.ByteStream;
import utility.swf.Swf;
import utility.swf.SwfBitmap;
import utility.swf.event.SWFEvent;
import utility.swf.tag.GenericTag;
import utility.swf.tag.SymbolClass;
import utility.swf.tag.Tag;

class ResourceManagerImpl extends EventDispatcher implements IResourceManager
{
	//当前加载队列
	//private var Queue:Vector.<File> = null;
	private var NodeArray:Vector.<Resource> = null;
	//private var CurrentNode:ResourceNode = null;
	private var ResourceDirectNav:String = "";
	
	private var TotalCount:int = 0;
	private var CurrentIndex:int = 0;
	
	public function ResourceManagerImpl()
	{
		//Queue = new Vector.<File>();
	}
	
	/**
	 * 接口方法.返回已经加载的所有资源
	 * 
	 * 
	 **/
	public function get SourceVec():Vector.<Resource>
	{
		return NodeArray;
	}
	
	private var PercentByUnitSwf:int = 0;
	/**
	 * 接口方法.加载指定路径下的所有资源配置文件和资源SWF文件
	 * 
	 * @DirectNav: 资源目录路径
	 * 
	 **/
	public function Load(DirectNav:String):void
	{
		ResourceDirectNav = DirectNav;
		NodeArray = new Vector.<Resource>();
		//顶层节点
		//CurrentNode = new ResourceNode();
		//CurrentNode.NativePath = Nav;
		//CurrentNode.Direct = true;
		
		//顶层节点加入队列
		//NodeArray.push(CurrentNode);
		var ResourceDirect:File = new File(DirectNav);
		if(ResourceDirect.exists && ResourceDirect.isDirectory)
		{
			var ChildFiles:Array = ResourceDirect.getDirectoryListing();
			
			//根据文件总数计算每个文件占用的百分比
			for(var Idx:int=0; Idx<ChildFiles.length; Idx++)
			{
				//开始加载
				var Node:Resource = ReadFile(ChildFiles[Idx]);
				if(!Node)
				{
					trace("Parse error from [" + File(ChildFiles[Idx]).nativePath + "]");
					continue;
				}
				NodeArray.push(Node);
			}
			PercentByUnitSwf = 100 / NodeArray.length;
			//设置加载次数
			TotalCount = NodeArray.length;
			//dispatchEvent(new Event(EventConstant.RESCOMPLETE));
			//配置文件解析完毕.开始队列加载资源SWF
			ProgressManager.Instance.Show();
			StartSwfQueue();
		}
	}
	
	//当前队列正在加载的节点
	private var CurrentLoading:Resource = null;
	//读取次数
	private var LoadCount:int = 0;
	
	private var SwfLoader:Loader = null;
	
	private var PercentByUnitSource:Number = 0;
	
	private var TotalPercent:int = 0;
	
	private var CurrentAsyncWait:int = 0;
	
	private var CurrentPercent:int = 0;
	private function StartSwfQueue():void
	{
		//LoadCount--;
		if(CurrentIndex < NodeArray.length)
		{
			CurrentLoading = NodeArray[CurrentIndex];
			
			ProgressManager.Instance.Label = "当前加载资源文件 " + CurrentLoading.SwfFile;
			
			var PNGArray:Array = CurrentLoading.SWF.FindTagByType(Tag.LOSSLESS2);
			var JPGArray:Array = CurrentLoading.SWF.FindTagByType(Tag.DEFINEJPEG2);
			var SymbolArray:Array = CurrentLoading.SWF.FindTagByType(Tag.SYMBOLCLASS);
			var Symbol:SymbolClass = SymbolArray.length > 0?SymbolArray.pop():null;
			var TotalArray:Array = PNGArray.concat(JPGArray);
			var TotalCount:int = TotalArray.length;
			
			PercentByUnitSource = PercentByUnitSwf / TotalCount;
			CurrentAsyncWait = 0;
			for(var Idx:int=0; Idx<TotalCount;Idx++)
			{
				var SourceTag:GenericTag = TotalArray[Idx];
				if(Symbol)
				{
					var Class:String = Symbol.FindSymbolClassById(SourceTag.TagId);
					SourceTag.Id = Class;
				}
				if(SourceTag.Source)
				{
					CurrentLoading.AddSourceItem(SourceTag.Id,SourceTag.Source,SourceTag.Type,CurrentLoading.SimpleName);
					CurrentPercent += PercentByUnitSource;
					ProgressManager.Instance.Update(TotalPercent + CurrentPercent,100);
				}
				else
				{
					SourceTag.addEventListener(SWFEvent.ASYNCLOAD_COMPLETE,AsyncLoadComplete);
					CurrentAsyncWait++;
				}
			}
			
			//trace("等待加载[" + CurrentAsyncWait + "]");
			
			if(CurrentAsyncWait == 0)
			{
				CurrentIndex++;
				StartSwfQueue();
				TotalPercent += PercentByUnitSwf;
				ProgressManager.Instance.Update(TotalPercent,100);
			}
		}
		else
		{
			ProgressManager.Instance.Hide();
			dispatchEvent(new Event(EventConstant.RESCOMPLETE));
		}
		//SwfLoader.load(new URLRequest(CurrentLoading.SwfNavPath));
	}
	
	private function AsyncLoadComplete(event:SWFEvent):void
	{
		var SourceTag:GenericTag = event.target as GenericTag;
		CurrentLoading.AddSourceItem(SourceTag.Id,SourceTag.Source,SourceTag.Type,CurrentLoading.SimpleName);
		CurrentPercent += PercentByUnitSource;
		ProgressManager.Instance.Update(TotalPercent + CurrentPercent,100);
		CurrentAsyncWait--;
		if(CurrentAsyncWait == 0)
		{
			CurrentIndex++;
			StartSwfQueue();
			TotalPercent += CurrentPercent;
			ProgressManager.Instance.Update(TotalPercent,100);
		}
	}
	
	/**
	 * 
	 * SWF加载完成
	 * 
	 **/
	private function LoadSwfComplete(event:Event):void
	{
//		var Items:Vector.<ResourceItem> = CurrentLoading.ChildrenItem;
//		for(var Idx:int = 0; Idx<Items.length; Idx++)
//		{
//			//Items[Idx].Source = SwfLoader.contentLoaderInfo.applicationDomain.getDefinition(Items[Idx].Class) as Class;
//			Items[Idx].Owner = CurrentLoading.SimpleName;
//			Items[Idx].OwnerSwf = CurrentLoading.SwfFile;
//		}
		
		NodeArray.push(CurrentLoading);
		//检查计数器
		if(LoadCount > 0)
		{
			//继续加载剩余的资源
			StartSwfQueue();
		}
		else
		{
			//加载完毕.发出完成事件
			dispatchEvent(new Event(EventConstant.RESCOMPLETE));
		}
	}
	
	public function FindResourceBySimpleName(SimpleName:String):Resource
	{
		for(var Idx:int = 0; Idx<NodeArray.length; Idx++)
		{
			if(NodeArray[Idx].SimpleName == SimpleName)
			{
				return NodeArray[Idx];
			}
		}
		return null;
	}
	
	/**
	 * 
	 * SWF加载中
	 * 
	 **/
	private function LoadSwfProgress(event:ProgressEvent):void
	{
		
	}
	
	private function LoadSwfError(event:IOErrorEvent):void
	{
		
	}
	
	/**
	 * 
	 * 加载文件
	 * 
	 **/
	private function ReadFile(ResourceFile:File):Resource
	{
		//文件夹
//		if(ResourceFile.isDirectory)
//		{
//			var Files:Array = ResourceFile.getDirectoryListing();
//			for(var Idx:int=0; Idx<Files.length; Idx++)
//			{
//				ReadFile(Files[Idx]);
//			}
//		}
//		else
//		{
//			
//		}
		//配置
		if(ResourceFile.extension == "swf")
		{
			
			var Res:Resource = new Resource();
			Res.SwfNavPath = ResourceFile.nativePath;
			
			var Stream:FileStream = new FileStream();
			Stream.open(ResourceFile,FileMode.READ);
			var Bytes:ByteArray = new ByteArray();
			Stream.readBytes(Bytes,0,Stream.bytesAvailable);
			Bytes.position = 0;
			var SwfReader:Swf = new Swf(new ByteStream(Bytes));
			Res.SWF = SwfReader;
//			var BitmapVec:Vector.<SwfBitmap> = SwfReader.BitmapAssets;
//			
//			for(var Idx:int = 0; Idx<BitmapVec.length; Idx++)
//			{
//				var Img:SwfBitmap = BitmapVec[Idx];
//				var Item:ResourceItem = new ResourceItem();
//				Item.Class = Img.Id;
//				Item.Type = ResourceMode.BITMAP;
//				Item.Source = Img.Image;
//				Item.Tag = 
//				Res.AddNode(Item);
//				//Item.Type = ItemNode.attribute("Type")[0];
//				//Item.Class = ItemNode.attribute("Class")[0];
//			}
			return Res;
			//Stream.readUTFBytes(Stream.bytesAvailable)
		}
//		if(ResourceFile.extension == "xml")
//		{
//			try
//			{
//				var Stream:FileStream = new FileStream();
//				Stream.open(ResourceFile,FileMode.READ);
//				
//				var Document:XML = new XML(Stream.readUTFBytes(Stream.bytesAvailable));
//				var Attrs:XMLList = Document.attribute("File");
//				if(Attrs.length == 0)
//				{
//					trace("配置文件异常.跳过该文件加载");
//				}
//				//获取SWF资源文件路径
//				var SwfFile:String = Attrs[0];
//				if(null == SwfFile || "" == SwfFile)
//				{
//					trace("参数异常.跳过加载");
//					return null;
//				}
//				
//				var Res:Resource = new Resource();
//				Res.SwfNavPath = ResourceDirectNav + Tools.SystemSplitSymbol + SwfFile;
//				trace(Res.SwfNavPath);
//				trace(Res.SwfFile);
//				//Item节点解析
//				var ItemList:XMLList = Document.children();
//				for(var Idx:int=0; Idx<ItemList.length(); Idx++)
//				{
//					var ItemNode:XML = ItemList[Idx];
//					var Item:ResourceItem = new ResourceItem();
//					Item.Type = ItemNode.attribute("Type")[0];
//					Item.Class = ItemNode.attribute("Class")[0];
//					Res.AddNode(Item);
//				}
//				return Res;
//			}
//			catch(Err:Error)
//			{
//				trace("Error[" + Err.message + "]");
//				
//			}
//			//trace(Stream.readUTFBytes(Stream.bytesAvailable));
//		}
		return null;
	}
}