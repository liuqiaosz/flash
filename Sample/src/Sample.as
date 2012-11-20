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
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.registerClassAlias;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Worker;
	import flash.utils.ByteArray;
	
	import pixel.assets.PixelAssetTask;
	import pixel.assets.PixelAssetsManager;
	import pixel.assets.event.PixelAssetEvent;
	import pixel.core.PixelConfig;
	import pixel.core.PixelLauncher;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UIProgress;
	import pixel.worker.core.PixelWorker;
	import pixel.worker.core.PixelWorkerHelper;
	import pixel.worker.core.ShareMemory;
	import pixel.worker.event.PixelWorkerEvent;
	import pixel.worker.message.PixelWorkerLoaderMessageResponse;
	import pixel.worker.message.PixelWorkerMessage;
	import pixel.worker.message.PixelWorkerMessageRequest;
	import pixel.worker.message.PixelWorkerMessageResponse;
	
	import utility.System;
	import utility.Tools;
	import utility.loader.Loader;
	import utility.swf.Swf;
	import utility.swf.SwfFactory;

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
		[Embed(source="../bin-debug/TestWorker.swf",mimeType="application/octet-stream")]
		private var workerClass:Class;
		
		[Embed(source="../bin-debug/ModuleC.swf",mimeType="application/octet-stream")]
		private var C:Class;
		public function Sample()
		{
			//var a:Date = new Date();
			//workerTest();
			PixelAssetsManager.instance.changeHandler(WorkerAssetDownloader);
			
			PixelAssetsManager.instance.loader.addEventListener(PixelAssetEvent.ASSET_COMPLETE,function(event:PixelAssetEvent):void{
				
				trace("complete");
			});
			stage.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
				var task:PixelAssetTask = new PixelAssetTask("ui","http://175.10.1.144:9200/payplateform/UI.swf");
				PixelAssetsManager.instance.loader.pushTaskToQueue(task);
			});
			
			readswf();
		}
		
		private function readswf():void
		{
			var data:ByteArray = new C() as ByteArray;
			var swf:Swf = SwfFactory.Instance.Decode(data);
			
		}

		private function workerTest():void
		{
			PixelWorkerHelper.instance.createWorkerByURL("TestWorker.swf");
			PixelWorkerHelper.instance.addEventListener(PixelWorkerEvent.WORKER_COMPLETE,function(event:PixelWorkerEvent):void{
				var work:PixelWorker = event.message as PixelWorker;
				work.addEventListener(PixelWorkerEvent.MESSAGE_AVAILABLE,function(event:PixelWorkerEvent):void{
					var msg:PixelWorkerLoaderMessageResponse = event.message as PixelWorkerLoaderMessageResponse;
					
					if(msg.shareMemory)
					{
						var memory:ByteArray = work.getShareProperty(ShareMemory.SHARE_BYTEARRAY) as ByteArray;
						var a:flash.display.Loader = new flash.display.Loader();
						var ctx:LoaderContext = new LoaderContext();
						ctx.applicationDomain = ApplicationDomain.currentDomain;
						ctx.allowCodeImport = true;
						a.loadBytes(memory,ctx);
						a.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
							var vec:Vector.<String> = a.contentLoaderInfo.applicationDomain.getQualifiedDefinitionNames();
							trace(vec.length + "");
						});
					}
				});
				work.start();
				
				stage.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
					var req:PixelWorkerMessageRequest = new PixelWorkerMessageRequest(PixelWorkerMessage.LOAD_SWF);
					req.message = "http://175.10.1.144:9200/payplateform/UI.swf";
					work.sendMessage(req);
				});
			});
		}
	}
}