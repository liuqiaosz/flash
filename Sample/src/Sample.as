package
{

	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import corecom.control.Combobox;
	import corecom.control.ComboboxItem;
	import corecom.control.Container;
	import corecom.control.HorizontalScroller;
	import corecom.control.LayoutConstant;
	import corecom.control.UIButton;
	import corecom.control.UIControl;
	import corecom.control.UIControlFactory;
	import corecom.control.UIImage;
	import corecom.control.UILabel;
	import corecom.control.UIPanel;
	import corecom.control.UIProgress;
	import corecom.control.UISlider;
	import corecom.control.UITextInput;
	import corecom.control.UIWindow;
	import corecom.control.VerticalScroller;
	import corecom.control.asset.ControlAssetManager;
	import corecom.control.effect.Effect;
	import corecom.control.effect.EffectGlowFilter;
	import corecom.control.effect.EffectTransform;
	import corecom.control.event.DownloadEvent;
	import corecom.control.event.EditModeEvent;
	import corecom.control.event.ScrollerEvent;
	
	import editor.uitility.ui.ActiveFrame;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.engine.ContentElement;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.GroupElement;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextLine;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import game.sdk.error.GameError;
	import game.sdk.event.GameEvent;
	import game.sdk.map.layer.DiamondLayer;
	import game.sdk.map.layer.GenericLayer;
	import game.sdk.spr.SpriteManager;
	import game.sdk.spr.SpriteSheet;
	
	import mx.graphics.codec.PNGEncoder;
	
	import ui.*;
	
	import utility.BitmapTools;
	import utility.ColorCode;
	import utility.RGBA;
	import utility.Tools;
	import utility.bitmap.png.PNGDecoder;

	[SWF(width="1024",height="600")]
	public class Sample extends Sprite
	{
		private var _Loader:Loader = null;
		private var _Img:Bitmap = null;
		
		private var offset:int = 14;
		private var last:UIControl = null;
		
		[Embed(source="D:\\0_0.png")]
		private var Cls:Class;
		public function Sample()
		{
//			var size:int = 30;
//			var a:DiamondLayer = new DiamondLayer(1,1,size);
//			addChild(a);
//			
//			addEventListener(GameEvent.RENDER_OVER,function(event:GameEvent):void{
//				
//				a.x = (stage.stageWidth - a.width) / 2 + 1 * size;
//				a.y = (stage.stageHeight - a.height) / 2;
//			});
			//this.stage.color = ColorCode.ColorARGB(0,255,0,0); 
//			var loader:Loader = new Loader();	
//			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
//				var obj:Class = loader.contentLoaderInfo.applicationDomain.getDefinition("ChargeMove") as Class;
//				
//				var b:BitmapData = new obj() as BitmapData;
//				stage.addChild(new Bitmap(b));
//			});
//			loader.load(new URLRequest("D:\\bgskin.swf"));
			
//			var a:SimpleButton = new SimpleButton();
//			a.Text = "test";
//			//var a:Bitmap = new Cls() as Bitmap;
//			addChild(a);
//			a.x = 0;
//			a.y = 0;
//			var eff:EffectTransform = new EffectTransform(a);
//			eff.Duration = 0.5;
//			eff.Repeat = -1;
//			eff.Yoyo = true;
//			var filter:EffectGlowFilter = new EffectGlowFilter();
//			filter.Alpha = 0.8;
//			filter.BlurX = 30;
//			filter.BlurY = 30;
//			filter.Color = 0xFF0000;
//			//eff.Rotate(360);
//			eff.Filter = filter;
//
//			eff.Play();
			//TweenLite.to(a, 1, {rotation:360});
			//stage.color = ColorCode.ALICEBLUE;
			stage.addEventListener(KeyboardEvent.KEY_DOWN,function(event:KeyboardEvent):void{
				ControlAssetManager.Instance.PushQueue("D:\\Git Library\\UIEditor\\bin\\Output\\AssetLibrary\\UI.swf");
//				ControlAssetManager.Instance.addEventListener(DownloadEvent.DOWNLOAD_SUCCESS,function(event:DownloadEvent):void{
//					
//					
//					
//				});
				ControlAssetManager.Instance.addEventListener(DownloadEvent.DOWNLOAD_SINGLETASK_SUCCESS,function(event:DownloadEvent):void{
					var Loader:URLLoader = new URLLoader();
					
					Loader.dataFormat = URLLoaderDataFormat.BINARY;
					Loader.addEventListener(Event.COMPLETE,function(event:Event):void{
						var star:int = flash.utils.getTimer();	
						var Data:ByteArray = Loader.data as ByteArray;
						
						var Panel:UIControl = UIControlFactory.Instance.Decode(Data).pop();
						stage.addChild(Panel);
					});
					Loader.load(new URLRequest("D:\\Git Library\\Project\\Death\\UI Model\\SmallFix2.mod"));
					
				});
				
			});
//			
			
//			ControlAssetManager.Instance.addEventListener(DownloadEvent.DOWNLOAD_SUCCESS,function(event:DownloadEvent):void{
//				
//				var Obj:Bitmap = ControlAssetManager.Instance.FindAssetById("ChargeMove") as Bitmap;
//				stage.addChild(Obj);
//				trace(Obj);
//			});
//			ControlAssetManager.Instance.Download(["D:\\Git Library\\Project\\Death\\UI Model\\UI256.swf"]);

			
//			var a:Bitmap = new Cls() as Bitmap;
//			a.bitmapData.lock();
//			var t:BitmapData = new BitmapData(a.width,a.height);
//			for(var i:int = 0; i<a.height; i++)
//			{
//				for(var j:int = 0; j<a.width; j++)
//				{
//					var c:uint = a.bitmapData.getPixel32(j,i);
//					trace(c.toString("2"));
//					c = ColorCode.Pixel8888To565(c);
//					trace("565 : " + c.toString("2"));
//					t.setPixel32(j,i,c);
//				}
//			}
//			a.bitmapData.unlock();
//			
//			var code:PNGEncoder = new PNGEncoder();
//			var pixels:ByteArray = code.encode(t);
//			
//			SaveDataToDisk(pixels,"D:\\565.png");
//			var b:Bitmap = new Cls() as Bitmap;
//			addChild(b);
//			b.y = 100;
//			addChild(a);
//				
//			var color:uint = 0xFFEECC;
//			
//			stage.color = color;
//		
//			var v:int = 0x80;
			//trace(v.toString("2"));
			
			//ARGB8888To565();
			ARGB888To4444();
		}
		
		private function ARGB8888To565():void
		{
			var c:uint = 0xC2A1B2C3;
			
			var value:uint = ColorCode.Pixel8888To565(c);
			trace(value.toString("2"));
		}
		
		
		private function ARGB888To4444():void
		{
			var c:uint = 0xC2A1B2C3;
			
			var tol:uint = ColorCode.Pixel8888To4444(c).Pixel;
			trace(tol.toString("2"));
		}
		
		private function cutplus():void
		{
			var Dir:File = new File("D:\\PNG");
			var Files:Array = Dir.getDirectoryListing();
			var Image:File = null;
			
			var loader:Loader = new Loader();
			var index:int = 0;
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				var total:BitmapData = Bitmap(loader.content).bitmapData;
				total = BitmapTools.CutAlpha(total);
				var encoder:PNGEncoder = new PNGEncoder();
				var data:ByteArray = encoder.encode(total);
				SaveDataToDisk(data,"D:\\PNG\\Fix\\" + index + ".png");
				index++;
				
				if(Files.length > 0)
				{
					Image = Files.pop();
					loader.load(new URLRequest(Image.nativePath));
				}
			});
			Image = Files.pop();
			loader.load(new URLRequest(Image.nativePath));
		}
		
		private function fte():void
		{
			var content:Sprite = new Sprite();
			content.graphics.beginFill(0xFF0000,0.5);
			content.graphics.drawRect(0,0,100,200);
			content.graphics.endFill();
			
			addChild(content);
			
			var v:Vector.<ContentElement> = new Vector.<ContentElement>();
			
			var format:ElementFormat = new ElementFormat();
			format.fontSize = 14;
			
			var element:TextElement = new TextElement("a",format);
			v.push(element);
			
			//			element = new TextElement("b",format);
			//			v.push(element);
			//			element = new TextElement("c",format);
			//			v.push(element);
			//			element = new TextElement("d",format);
			//			v.push(element);
			
			var g:GroupElement = new GroupElement(v);
			
			var block:TextBlock = new TextBlock();
			block.content = g;
			
			var line:TextLine = block.createTextLine(null,50);
			var offsetX:int = line.width;
			line.y = offset;
			content.addChild(line);
			
			line = block.createTextLine (null);
			line.x = offsetX;
			trace(line.width + "");
			addChild(line);
			
			
			//			line.y = offset;
			//			offset += line.height + 10;
			//			line = block.createTextLine(null, 100 - offsetX);
			//			addChild(line);
			//			line.y = offset;
			//			offset += line.height + 10;
			//			line = block.createTextLine(null, 100 - offsetX);
			//			addChild(line);
			//			line.y = offset;
			//			offset += line.height + 10;
			//			line = block.createTextLine(null, 100 - offsetX);
		}
		
		private function label():void
		{
			var l:UILabel = new UILabel("测试测试测试测试测试测试",null);
			l.FontSize = 18;
			addChild(l);
		}
		
		private function scroll():void
		{
			var a:UIPanel = new UIPanel();
			a.width = 300;
			a.height = 200;
			a.Layout = LayoutConstant.HORIZONTAL;
			a.Gap = 10;
			var b:UIButton = new UIButton();
			b.Text = "1";
			a.addChild(b);
			b = new UIButton();
			b.Text = "2";
			a.addChild(b);
			b = new UIButton();
			b.Text = "3";
			a.addChild(b);
			b = new UIButton();
			b.Text = "4";
			a.addChild(b);
			b = new UIButton();
			b.Text = "5";
			a.addChild(b);
			b = new UIButton();
			b.Text = "6";
			a.addChild(b);
			b = new UIButton();
			b.Text = "7";
			a.addChild(b);
			addChild(a);
			
			var scroll:HorizontalScroller = new HorizontalScroller();
			
			scroll.BackgroundColor = 0x5d5d5d;
			scroll.height = 20;
			a.OrignalAddChild(scroll);
			
			
			a.x = 200;
			a.y = 200;
		}
		
		private function combbox():void
		{
			var box:Combobox = new Combobox();
			box.x = 200;
			box.y = 400;
			box.ItemFocusColor = 0x00FF00;
			var item:Vector.<ComboboxItem> = new Vector.<ComboboxItem>();
			
			item.push(new ComboboxItem("AAA","AAA"));
			item.push(new ComboboxItem("BBB","AAA"));
			
			box.Items = item;
			addChild(box);
			stage.addEventListener(MouseEvent.CLICK,function(event:Event):void{
			});
		}
		
		private function deleteAlpha():void
		{
			var loader:Loader = new Loader();
			var w:int = 105;
			var h:int = 150;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				var total:BitmapData = Bitmap(loader.content).bitmapData;
				total = BitmapTools.CutAlpha(total);
				var encoder:PNGEncoder = new PNGEncoder();
				var data:ByteArray = encoder.encode(total);
				SaveDataToDisk(data,"D:\\ltfix.png");
				
			});
			loader.load(new URLRequest("D:\\lt.png"));
		}
		
		private function cut():void
		{
			var loader:Loader = new Loader();
			var w:int = 105;
			var h:int = 150;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				var total:BitmapData = Bitmap(loader.content).bitmapData;
				
				var r:int = total.height / h;
				var c:int = total.width / w;
				var rect:Rectangle = new Rectangle();
				rect.width = w;
				rect.height = h;
				var encoder:PNGEncoder = new PNGEncoder();
				for(var col:int = 0; col < c; col++)
				{
					for(var row:int = 0; row < r; row++)
					{
						var img:BitmapData = new BitmapData(w,h);
						rect.x = col * w;
						rect.y = row * h;
						img.copyPixels(total,rect,new Point());
						
						var data:ByteArray = encoder.encode(img);
						
						SaveDataToDisk(data,"D:\\old\\" + col + "_" + row + ".png");
					}
				}
			
			});
			loader.load(new URLRequest("D:\\old.png"));
		}
		
		private function cut2():void
		{
			var loader:Loader = new Loader();
			var w:int = 105;
			var h:int = 150;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
				var total:BitmapData = Bitmap(loader.content).bitmapData;
				var encoder:PNGEncoder = new PNGEncoder();
				var img:BitmapData = BitmapTools.CutAlpha(total);
				var data:ByteArray = encoder.encode(img);
				
				SaveDataToDisk(data,"D:\\0_0.png");
			});
			loader.load(new URLRequest("D:\\K\\skill1\\0_0.png"));
		}
		
		public static function SaveDataToDisk(Data:ByteArray,Nav:String):void
		{
			var DiskFile:File = new File(Nav);
			
			try
			{
				var Writer:FileStream = new FileStream();
				Writer.open(DiskFile,FileMode.WRITE);
				Writer.writeBytes(Data,0,Data.length);
			}
			catch(Err:Error)
			{
				trace("Write file error : " + Err.message);
			}
			finally
			{
				if(Writer)
				{
					Writer.close();
					Writer = null;
				}
			}
		}
	}
}