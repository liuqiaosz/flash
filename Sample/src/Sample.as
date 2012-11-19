package
{

//	import com.greensock.plugins.GlowFilterPlugin;
//	import com.greensock.plugins.TweenPlugin;
//	
//	import flash.crypto.generateRandomBytes;
//	import flash.display.Bitmap;
//	import flash.display.BitmapData;
//	import flash.display.BlendMode;
//	import flash.display.DisplayObject;
//	import flash.display.GradientType;
//	import flash.display.Graphics;
//	import flash.display.Loader;
//	import flash.display.Shape;
//	import flash.display.SpreadMethod;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import pixel.core.PixelConfig;
	import pixel.core.PixelLauncher;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIProgress;
	
	import utility.Tools;

//	import flash.display.StageAlign;
//	import flash.display.StageScaleMode;
//	import flash.events.Event;
//	import flash.events.KeyboardEvent;
//	import flash.events.MouseEvent;
//	import flash.filesystem.File;
//	import flash.filesystem.FileMode;
//	import flash.filesystem.FileStream;
//	import flash.geom.Matrix;
//	import flash.geom.Point;
//	import flash.geom.Rectangle;
//	import flash.net.URLLoader;
//	import flash.net.URLLoaderDataFormat;
//	import flash.net.URLRequest;
//	import flash.system.ApplicationDomain;
//	import flash.system.LoaderContext;
//	import flash.system.MessageChannel;
//	import flash.system.Security;
//	import flash.system.SecurityDomain;
//	import flash.system.Worker;
//	import flash.system.WorkerDomain;
//	import flash.text.TextField;
//	import flash.text.TextFieldType;
//	import flash.text.engine.ContentElement;
//	import flash.text.engine.ElementFormat;
//	import flash.text.engine.GroupElement;
//	import flash.text.engine.TextBlock;
//	import flash.text.engine.TextElement;
//	import flash.text.engine.TextLine;
//	import flash.ui.Keyboard;
//	import flash.utils.ByteArray;
//	import flash.utils.CompressionAlgorithm;
//	import flash.utils.Dictionary;
//	import flash.utils.getTimer;
//	
//	import editor.uitility.ui.ActiveFrame;
//	
//	import game.sdk.error.GameError;
//	import game.sdk.event.GameEvent;
//	import game.sdk.map.layer.DiamondLayer;
//	import game.sdk.map.layer.GenericLayer;
//	import game.sdk.map.terrain.TerrainData;
//	import game.sdk.spr.SpriteManager;
//	import game.sdk.spr.SpriteSheet;
//	
//	import pixel.core.PixelLauncher;
//	import pixel.ui.control.IUIControl;
//	import pixel.ui.control.UIButton;
//	import pixel.worker.core.PixelWorker;
//	import pixel.worker.core.PixelWorkerGeneric;
//	import pixel.worker.core.PixelWorkerHelper;
//	import pixel.worker.event.PixelWorkerEvent;
//	
//	import utility.BitmapTools;
//	import utility.ColorCode;
//	import utility.RGBA;
//	import utility.Tools;
//	import utility.bitmap.png.PNGDecoder;
//	import utility.bitmap.tga.TGADecoder;


	public class Sample extends Sprite
	{
		//[Embed(source="Worker.swf",mimeType="application/octet-stream")]
		//private var SWF:Class;
//		[Embed(source="D:\\0_0.png")]
//		private var Cls:Class;
		public function Sample()
		{
			trace("sample");
//			var curr:Vector.<String> = ApplicationDomain.currentDomain.getQualifiedDefinitionNames();
//			for each(var str:String in curr)
//			{
//				trace(str);
//			}
			//moduleTest();

		}
//		
//		private function moduleTest():void
//		{
//			var curr:Vector.<String> = ApplicationDomain.currentDomain.getQualifiedDefinitionNames();
//			for each(var n:String in curr)
//			{
//				trace(n);
//			}
//			trace("-------------End-----------");
//			var loader:Loader = new Loader();
//			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
//				
//				curr = ApplicationDomain.currentDomain.getQualifiedDefinitionNames();
//				for each(var n:String in curr)
//				{
//					trace(n);
//				}
//				trace("-------------End-----------");
////				var childLoade:Loader = new Loader();
////				var childctx:LoaderContext = new LoaderContext();
////				childLoade.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
////					
////					//stage.addChild(childLoade.content);
////					curr = ApplicationDomain.currentDomain.getQualifiedDefinitionNames();
////					for each(var n:String in curr)
////					{
////						trace(n);
////					}
////				
////				});
////				childLoade.load(new URLRequest("ModuleA.swf"),childctx);
//				
//			});
//
//			var ctx:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
//			ctx.applicationDomain = ApplicationDomain.currentDomain;
//			loader.load(new URLRequest("ModuleA.swf"),ctx);
//		}
//		
//		private function workerTest():void
//		{
//			PixelWorkerHelper.instance.createWorkerByURL("Worker.swf");
//			PixelWorkerHelper.instance.addEventListener(PixelWorkerEvent.WORKER_COMPLETE,function(event:PixelWorkerEvent):void{
//				var work:PixelWorker = event.message as PixelWorker;
//				work.addEventListener(PixelWorkerEvent.MESSAGE_AVAILABLE,function(event:PixelWorkerEvent):void{
//					var msg:int = event.message as int;
//					trace(msg + "");
//				});
//				work.start();
//				
//				stage.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
//					work.sendMessage(99);
//				});
//			});
//		}
	}
}