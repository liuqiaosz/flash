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
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.GraphicsTrianglePath;
	import flash.display.JPEGXREncoderOptions;
	import flash.display.Loader;
	import flash.display.PNGEncoderOptions;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3D;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.SharedObject;
	import flash.net.Socket;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.registerClassAlias;
	import flash.system.ApplicationDomain;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.System;
	import flash.system.Worker;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.utils.Proxy;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	
	import pixel.assets.PixelAssetTask;
	import pixel.assets.PixelAssetsManager;
	import pixel.assets.event.PixelAssetEvent;
	import pixel.core.PixelConfig;
	import pixel.core.PixelLauncher;
	import pixel.error.PixelNetError;
	import pixel.particle.PixelParticleEmitterPropertie;
	import pixel.texture.PixelTextureFactory;
	import pixel.texture.event.PixelTextureEvent;
	import pixel.texture.vo.PixelTexture;
	import pixel.texture.vo.PixelTexturePackage;
	import pixel.ui.control.ComboboxItem;
	import pixel.ui.control.HorizontalScroller;
	import pixel.ui.control.IUIControl;
	import pixel.ui.control.LayoutConstant;
	import pixel.ui.control.UIButton;
	import pixel.ui.control.UICheckBox;
	import pixel.ui.control.UICombobox;
	import pixel.ui.control.UIControl;
	import pixel.ui.control.UIControlFactory;
	import pixel.ui.control.UIImage;
	import pixel.ui.control.UIPanel;
	import pixel.ui.control.UIProgress;
	import pixel.ui.control.UITextInput;
	import pixel.ui.control.UIVerticalPanel;
	import pixel.ui.control.UIVerticalScroller;
	import pixel.ui.control.asset.PixelAssetManager;
	import pixel.ui.control.event.DownloadEvent;
	import pixel.ui.control.style.VerticalScrollerStyle;
	import pixel.ui.control.vo.UIControlMod;
	import pixel.ui.control.vo.UIMod;
	import pixel.utility.BitmapTools;
	import pixel.utility.ColorCode;
	import pixel.utility.RGBA;
	import pixel.utility.ShareDisk;
	import pixel.utility.ShareObjectHelper;
	import pixel.utility.Stat;
	import pixel.utility.System;
	import pixel.utility.Tools;
	import pixel.utility.bitmap.gif.GIFDecoder;
	import pixel.utility.bitmap.gif.GIFFrame;
	import pixel.utility.data.QuadNode;
	import pixel.utility.data.QuadTree;
	import pixel.utility.loader.Loader;
	import pixel.utility.swf.Swf;
	import pixel.utility.swf.SwfFactory;
	
	import ui.aa;
	
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
	
	[SWF(width="1280",height="600",frameRate="30",backgroundColor="0xFFFFFF")]
	public class Sample extends Sprite
	{
		[Embed(source="arrow_down.png")]
		private var ARROW_DOWN:Class;
		[Embed(source="arrow_up.png")]
		private var ARROW_UP:Class;
		
		[Embed(source="scrollup.png")]
		private var SCROLLERARROW_UP:Class;
		[Embed(source="scrolldown.png")]
		private var SCROLLERARROW_DOWN:Class;
		
		[Embed(source="scrollhandler.png")]
		private var SCROLLER_HANDLER:Class;
		
		[Embed(source="map2.jpg")]
		private var IMG:Class;
		
		[Embed(source="map1.jpg")]
		private var MAP:Class;
	
		[Embed(source="monkey.gif",mimeType="application/octet-stream")]
		private var GIF:Class;
		
		[Embed(source="xr",mimeType="application/octet-stream")]
		private var XR:Class;
		
		[Embed(source="effect.tpk",mimeType="application/octet-stream")]
		private var TPK:Class;
		
		[Embed(source="1111.mod",mimeType="application/octet-stream")]
		private var PRO:Class;
		
		private var sid:String = "";
		private var center:Point = new Point();
		private var angle:int
		private var startAngle:int
		public function Sample()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			//rotateTest();
			//pngTo4444();
			//progress();
			center.x = stage.stageWidth / 2;
			center.y = stage.stageHeight / 2;
//			var s:Stat = new Stat();
//			s.x = stage.stageWidth - s.width;
//			addChild(s);
			
//			var check:UICheckBox = new UICheckBox();
//			addChild(check);
			
//			PixelAssetManager.instance.download("login.swf");
//			PixelAssetManager.instance.addEventListener(DownloadEvent.DOWNLOAD_SUCCESS,function(event:Event):void{
//			
//				var loader:URLLoader = new URLLoader();
//				loader.dataFormat = URLLoaderDataFormat.BINARY;
//				loader.addEventListener(Event.COMPLETE,function(event:Event):void{
//					
//					var mod:UIMod = UIControlFactory.instance.decode(loader.data);
//					addChild(mod.controls.pop().control);
//				});
//				
//				loader.load(new URLRequest("login.mod"));
//			});
			
//			var s3d:Stage3D = stage.stage3Ds[0];
//			s3d.addEventListener(Event.CONTEXT3D_CREATE,function(event:Event):void{
//				s3d.context3D.configureBackBuffer(1280,600,0);
//			
//			});
//			s3d.requestContext3D();
//			scrollTest();
			var data:ByteArray = new PRO() as ByteArray;
			var m:UIMod = UIControlFactory.instance.decode(data);
			var cs:Vector.<UIControlMod> = m.controls;
			var pro:UIProgress = null;
			for each(var c:UIControlMod in cs)
			{
				if(c.control is UIProgress)
				{
					pro = c.control as UIProgress;
					addChild(pro);
					pro.x = 100;
					pro.y = 100;
				}
			}
			var v:int = 0
			stage.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
				v+=10;
				pro.UpdateProgress(v,100);
			});
		}
		
		private function scrollTest():void
		{
			var panel:UIVerticalPanel = new UIVerticalPanel();
			panel.initializer();
			panel.width = 200;
			panel.height = 300;
			panel.Gap = 10;
			addChild(panel);
			
			stage.addEventListener(MouseEvent.RIGHT_CLICK,function(event:MouseEvent):void{
				
				var btn:UIButton = new UIButton();
				btn.width = 100;
				btn.height = 50;
				btn.initializer();
				panel.addChild(btn);
			
			});
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,function(event:Event):void{
			
				
				panel.scroller.width = 20;
			});
			panel.scroller.BackgroundColor = 0x000000;
			panel.scroller.BackgroundAlpha = 0.3;
			//panel.scroller.scrollHandler.backgroundImageForAllState = new SCROLLER_HANDLER() as Bitmap;
			//panel.scroller.scrollHandler.scale9GridForAllState(10,10,10,10);
			//panel.scroller.scrollHandler.BorderThinkness = 0;
		}
		
		private function showcase():void
		{
			var mp:Bitmap = new MAP() as Bitmap;
			var flow:ShowcaseFlow = new ShowcaseFlow(1280,400,mp.width,mp.height);

			flow.x = 0;
			flow.y = 100;
			
			var prev:UIButton = new UIButton();
			prev.Text = "prev";
			
			addChild(prev);
			
			var next:UIButton = new UIButton();
			next.Text = "Next";
			
			addChild(next);
			
			prev.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
				flow.scrollLeft();
			});
			
			next.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
				flow.scrollRight();
			});
			next.x = 150;
			
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,function(event:KeyboardEvent):void{
				
				var item:WorldFlowItem = new WorldFlowItem(mp.width,mp.height);
				item.image = mp;
				flow.addChild(item);
			});
			
			addChild(flow);
		}
		
		[Embed(source="LoadingColor.png")]
		private var Color:Class;
		
		[Embed(source="LoadingBlack.png")]
		private var Black:Class;
		
		private function loading():void
		{
			var percent:Number = 0;
			var color:BitmapData = Bitmap(new Color()).bitmapData;
			var black:BitmapData = Bitmap(new Black()).bitmapData;
			var img:BitmapData = new BitmapData(color.width,color.height);
			img.copyPixels(black,black.rect,new Point());
			var image:Bitmap = new Bitmap(img);
			addChild(image);
			var up:Boolean = true;
			var targetH:int = 0;
			var targeP:Number = 0;
			stage.addEventListener(Event.ENTER_FRAME,function(event:Event):void{
				
				if(up)
				{
					if(targeP < percent)
					{
						targeP += 0.01;
					}
					
					var h:int = color.height * targeP;
					var rect:Rectangle = new Rectangle(0,0,color.width,h);
					img.copyPixels(color,rect,new Point());
					
					if(h >= color.height)
					{
						up = false;
						TweenMax.to(image, 1, {glowFilter:{color:0xFF0000, alpha:1, blurX:30, blurY:30}});
					}
				}
			});
			
			stage.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
			
				percent += 1;
			});
		}
		
		private function netTest():void
		{
//			var conn:PixelNetSocket = new PixelNetSocket();
//			conn.connect("168.33.211.244",8091);
//
//			conn.addEventListener(PixelNetEvent.NET_EVENT_CONNECTFAILURE,function(event:PixelNetEvent):void{
//			
//				trace("error");
//			});
			
//			conn.addEventListener(PixelNetEvent.NET_EVENT_CONNECTED,function(event:PixelNetEvent):void{
//				var m:Message = new Message();
//				
//				conn.sendMessage(m);
//			});
//			stage.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
//				
//				var m:Message = new Message();
//				
//				conn.sendMessage(m);
//			
//			});
			
			//conn.close();
			
		}
		
		private function tweenTest():void
		{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0xFF0000);
			sp.graphics.drawCircle(0,0,20);
			sp.graphics.endFill();
			
			addChild(sp);
			
			TweenLite.to(sp,5,{
				"x" : stage.stageWidth,
				"y" : stage.stageHeight,
				onComplete : function():void{
					trace("success");
				}
			});
		}
		
		private function modTest():void
		{
			var loader:URLLoader = new URLLoader();
			
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE,function(event:Event):void{
				
				var mod:UIMod = UIControlFactory.instance.decode(loader.data as ByteArray);
				var control:UIControlMod = mod.controls.pop();
				var ctl:UIPanel = control.control as UIPanel;
				ctl.x = ctl.y = 0;
				var txt:UITextInput = ctl.GetChildById("LoginPwd",true) as UITextInput;
				txt.isPassword(true);
				addChild(ctl);
			});
			
			loader.load(new URLRequest("D:\\Developer\\flash\\Project\\Death\\UI Model\\登陆界面\\denglu.mod"));
			var iput:UITextInput = new UITextInput();
			//iput.type = TextFieldType.INPUT;
			iput.width = 100;
			iput.height = 30;
			iput.Input = true;
			
			var obj:SharedObject = SharedObject.getLocal("account");
			trace(obj.data.acc);
		}
		
		private function enterFramefunc(e:Event):void
		{
			angle>360?angle=0:''
			graphics.clear();
			graphics.beginFill(0xff0000,.6);
			drawSector(this.graphics,150,150,50,angle,270);
			drawSector(this.graphics,150,150,100,angle,270);
			
			
			graphics.beginFill(0x0000ff,.6);
			//drawSector(this.graphics,450,150,50,angle,startAngle)
			startAngle++;
			angle++;
		}
		
		/**
		 * 绘制扇形 
		 * @param graphics 绘图对象
		 * @param x 圆心x轴
		 * @param y 圆心vy轴
		 * @param radius 半径
		 * @param size 绘制的扇形大小（角度制，0<=size<=360)
		 * @param startRotation 开始的角度(角度制，默认为270度即12点方向)
		 * 
		 */                
		private static function drawSector(graphics:Graphics,x:int,y:int,radius:int,size:Number,startRotation:Number=270):void
		{
			if(size<=0) return;
			if(size > 360) size = 360;
			
			var n:int=8;
			size = Math.PI/180 * size;
			var angleN:Number = size/n;
			//绘制二次贝塞尔曲线的外切半径
			var tangentRadius:Number = radius/Math.cos(angleN/2);
			//转换为弧度
			var angle:Number=startRotation* Math.PI / 180;
			
			var cx:Number;
			var cy:Number;
			var ax:Number;
			var ay:Number;
			
			//开始角度再圆上的位置
			var startX:Number = x + Math.cos(angle) * radius;
			var startY:Number = y + Math.sin(angle) * radius;

			graphics.moveTo(startX, startY);
			//graphics.lineTo(startX, startY);
			for (var i:Number = 0; i < n; i++) {
				
				//绘制2次贝塞尔曲线，
				angle += angleN;
				//求出开始点与将要绘制点的角平分线与将要绘制点的交点
				cx = x + Math.cos(angle-(angleN/2))*(tangentRadius);
				cy = y + Math.sin(angle-(angleN/2))*(tangentRadius);
				//僬侥绘制点在圆上的位置
				ax = x + Math.cos(angle) * radius;
				ay = y + Math.sin(angle) * radius;
				
				graphics.curveTo(cx, cy, ax, ay);
			}
			graphics.lineTo(x, y);
			
		}
		
		
		private function textureTest():void
		{
			var data:ByteArray = new TPK() as ByteArray;
			var t:Number = new Date().time;
			var pack:PixelTexturePackage = PixelTextureFactory.instance.decode(data);
			PixelTextureFactory.instance.addEventListener(PixelTextureEvent.PACKAGE_DECODE_SUCCESS,function(event:Event):void{
				var textures:Vector.<PixelTexture> = pack.textures;
				stage.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
					timer.start();
				});
				var show:Bitmap = new Bitmap();
				addChild(show);
				
				var idx:int = 0;
				var timer:Timer = new Timer(100,0);
				timer.addEventListener(TimerEvent.TIMER,function(event:TimerEvent):void{
					
					if(idx >= textures.length)
					{
						idx = 0;
					}
					show.bitmapData = textures[idx].bitmap;
					idx++;
				});
			});
			PixelTextureFactory.instance.asyncDecodeTexturePackage(pack);
		}
		
		private function pixelTest():void
		{
			var p:uint = 0xFFFE34D9;
			trace(p.toString(2));
			p = ColorCode.ARGB8888ToARGB4444(p);
			trace(p.toString(2));
		}
		
		private function progress():void
		{
			var pro:UIProgress = new UIProgress();
			addChild(pro);
			pro.x = 10;
			pro.y = 10;
			pro.width = 150;
			pro.height = 20;
			var i:int = 0;
			stage.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void
			{
				i += 10;
				pro.UpdateProgress(i,100);
			});
			
			stage.addEventListener(MouseEvent.RIGHT_CLICK,function(event:MouseEvent):void{
				
				pro.rotation = 90;
			});
		}
		
		
		
		[Embed(source="map_terrain.png")]
		private var MAPT:Class;
		
		public function pngTo4444():void
		{
			var png:Bitmap = new MAPT() as Bitmap;
			
			var bmp:BitmapData = png.bitmapData;
			
			var bmp4:BitmapData = new BitmapData(bmp.width,bmp.height);
			
			for(var i:int = 0; i<bmp4.height; i++)
			{
				for(var j:int = 0; j<bmp4.width; j++)
				{
					var pixel:uint = bmp.getPixel32(j,i);
					pixel = ColorCode.RGB8888ToRGB4444(pixel).Pixel;
					bmp4.setPixel32(j,i,pixel);
				}
			}
			var op:PNGEncoderOptions = new PNGEncoderOptions();
			var data:ByteArray = BitmapTools.BitmapEncodeToPNG(bmp4);
			
			var writer:FileStream = new FileStream();
			writer.open(new File("D:\\map_terrain.png"),FileMode.WRITE);
			writer.writeBytes(data,0,data.length);
			writer.close();
		}
		
		private function combotest():void
		{
			var comb:UICombobox = new UICombobox();
			comb.initializer();
			//comb.width = 100;
			//comb.height = 30;
			var item:ComboboxItem = new ComboboxItem("111","1111");
			var vec:Vector.<ComboboxItem> = new Vector.<ComboboxItem>();
			vec.push(item);
			item = new ComboboxItem("222","222");
			vec.push(item);
			item = new ComboboxItem("333","222",0xFF0000,15,true);
			vec.push(item);
			item = new ComboboxItem("444","222");
			vec.push(item);
			item = new ComboboxItem("555","222",0x00FF00);
			vec.push(item);
			item = new ComboboxItem("666","222");
			vec.push(item);
			item = new ComboboxItem("777","222");
			vec.push(item);
			item = new ComboboxItem("888","222");
			vec.push(item);
			item = new ComboboxItem("999","222");
			
			comb.items = vec;
			comb.x = 100;
			comb.y = 300;
			
			addChild(comb);
		}
		
		
		
		private function angleGetTest():void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE,function(event:MouseEvent):void{
				
				var angle:Number = Math.atan2(event.stageY - center.y,event.stageX - center.x);
				
				trace((angle * 180 / Math.PI));
			});
		}
		
		private var fun:Function = function(n:String):void{
			trace(this);
			Ctx(this).sid = n;
			//this.sid = n;
		};
		
		private function proxyTest():void
		{
			var a:Ctx = new Ctx();
			var b:Ctx = new Ctx();
			fun.call(b,["aaaa"]);
			trace(b.sid);
		}
		
		
		private function curveTest():void
		{
			var draw:Graphics = this.graphics;
			draw.clear();
			draw.lineStyle(1,0,1,false,"normal",CapsStyle.ROUND);
			draw.drawRoundRect(100,100,100,100,8,8);
		}
		
		private var queue:Vector.<Particle> = new Vector.<Particle>();
		private var ball:Particle; 
		private var radiusX:Number = 150; 
		private var radiusY:Number = 100;
		private var vr:Number = .1;
		private function rotateTest():void
		{
			var ball:Particle = new Particle();
			addChild(ball);
			
			ball.x = stage.stageWidth / 2; 
			ball.y = stage.stageHeight / 2;
			
			var ballang:Number = 0;
			
			stage.addEventListener(Event.ENTER_FRAME,function(event:Event):void{
				ball.x = stage.stageWidth / 2 + Math.cos(angle) * radiusX ; 
				ball.y = stage.stageHeight / 2 + Math.sin(angle) * radiusY; 
				angle += vr;
				//				var ang:Number = Math.cos(angle);
				//				ball.x = stage.stageHeight / 2 + ang * 100; 
				//				angle += .3;
				//				ball.y -= 3;
			});
		}
		
		private function waveTest():void
		{
			//			var ball:Particle = new Particle();
			//			addChild(ball);
			//			var ball2:Particle = new Particle();
			//			addChild(ball2);
			//			
			//			ball.x = stage.stageWidth / 2; 
			//			ball.y = stage.stageHeight / 2;
			//			
			//			ball2.x = ball.x;
			//			ball2.y = ball.y;
			//			
			//			var ang:Number = 0;
			//			var v:Number = 1;
			//			var v2:Number = -1;
			
			//			stage.addEventListener(Event.ENTER_FRAME,function(event:Event):void{
			//				var ang:Number = Math.cos(angle);
			//				ball.x = stage.stageHeight / 2 + ang * v * 100;
			//				ball2.x = stage.stageHeight / 2 + ang * v2 * 100;
			//				angle += .3;
			//				ball.y -= 1;
			//				ball2.y -= 1;
			//			});
			
			var ang:Number = 0;
			var v:Number = 1;
			
			//			for(var i:int = 0; i< 20; i++)
			//			{
			//				ball = new Particle();
			//				ball.x = stage.stageWidth / 2; 
			//				ball.y = stage.stageHeight / 2;
			//				queue.push(ball);
			//				addChild(ball);
			//			}
			stage.addEventListener(Event.ENTER_FRAME,function(event:Event):void{
				//var ang:Number = Math.cos(angle);
				for each(var node:Particle in queue)
				{
					var nm:int = Math.random() * 100;
					v *= nm > 50 ? -1:1;
					ang = Math.cos(node.angle);
					node.x = stage.stageHeight / 2 + ang * v * 100;
					node.y -= Math.random() * 5;
					//v *= -1;
					node.angle += 0.2;
				}
				
				angle += .3;
			});
			
			stage.addEventListener(MouseEvent.RIGHT_CLICK,function(event:Event):void{
				
				for(var idx:int = 0; idx< 10; idx++)
				{
					ball = new Particle();
					ball.x = stage.stageWidth / 2; 
					ball.y = stage.stageHeight / 2;
					queue.push(ball);
					addChild(ball);
				}
				
			});
		}
		
		[Embed(source="e1.png")]
		private var E1:Class;
		private function emitter():void
		{
			var img:Bitmap = new E1() as Bitmap;
			
			//addChild(s);
			var propertie:PixelParticleEmitterPropertie = new PixelParticleEmitterPropertie();
			propertie.attenuation = 0.1;
			propertie.health = 100;
			propertie.maxmizeParticle = 1;
			propertie.particleCount = 1;
			propertie.poolable = true;
			propertie.size = 2;
			propertie.color = 0x000000;
			//propertie.texture = img.bitmapData;
			//propertie.type = 1;
			//propertie.randomAttenuation = true;
			//propertie.randomAttenuationScope = [2,3];
			//propertie.allowGradientColor = true;
			//propertie.gradientColor = [0x000000,0xFF0000];
			//propertie.randomColor = true;
			//propertie.randomAlpha = true;
			propertie.velocityX = 250;
			propertie.velocityY = 80;
			propertie.gravity = 0.5;
			//propertie.randomX = true;
			//propertie.randomXScope = [-200,100];
		
			propertie.size = 5;
			//propertie.randomRedian = true;
			//propertie.randomRedianSceop = [260,290];
			//propertie.randomSize = true;
			//propertie.randomSizeScope = [2,5];
			propertie.accelerationX = -0.1;
			propertie.accelerationY = 0.1;
			propertie.radianAttenuation = 0.1;
			//propertie.emitterLazy = 300;
			
			var emitter:Emitter = new Emitter(propertie);
			emitter.x = center.x;
			emitter.y = center.y;
			addChild(emitter);
			stage.addEventListener(Event.ENTER_FRAME,function(event:Event):void{
				emitter.update();
				//emitter.rotation += 2;
			});
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN,function(event:MouseEvent):void{
				
				stage.addEventListener(MouseEvent.MOUSE_MOVE,drag);
				stage.addEventListener(MouseEvent.MOUSE_UP,drop);
			});
			
			var drag:Function = function(event:MouseEvent):void{
				emitter.x = event.stageX;
				emitter.y = event.stageY;
			};
			var drop:Function = function(event:MouseEvent):void{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE,drag);
				stage.removeEventListener(MouseEvent.MOUSE_UP,drop);
			};
		}
		
		
		private function rotateE():void
		{
			//			var ball:Particle = new Particle();
			var pos:Point = new Point(stage.stageWidth / 2,stage.stageHeight / 2);
			//ball.x = pos.x;
			//ball.y = pos.y;
			var angle:Number = 0;
			var radiusX:int = 100;
			var radiusY:int = 50;
			var blur:BlurFilter = new BlurFilter(5,5,1);
			//stage.addChild(ball);
			var canvas:BitmapData = new BitmapData(stage.stageWidth,stage.stageHeight);
			var image:Bitmap = new Bitmap(canvas);
			//addChild(image);
			
			var mask:BitmapData = new BitmapData(stage.stageWidth,stage.stageHeight,true,0x00FFFFFF);
			var m:Bitmap = new Bitmap(mask);
			//addChild(m);
			var tran:ColorTransform = new ColorTransform(1,1,1,0.9);
			var mtx:Matrix = new Matrix();

			var batch:Vector.<Particle> = new Vector.<Particle>();
			var radiusXseek:int = 1;
			var radiusYseek:int = 1;
			var seek:Number = 1;
			stage.addEventListener(Event.ENTER_FRAME,function(event:Event):void{
				var t:int = flash.utils.getTimer();
				var node:Particle = null;
				
				//				if(batch.length < queue.length)
				//				{
				//					while(true)
				//					{
				//						node = queue.shift();
				//						t = flash.utils.getTimer();
				//						node.x = pos.x + Math.cos(node.angle) * radiusX;
				//						node.y = pos.y + Math.sin(node.angle) * radiusY;
				//						trace("math[" + (flash.utils.getTimer() - t) + "]");
				//						mtx.tx = node.x;
				//						mtx.ty = node.y;
				//						t = flash.utils.getTimer();
				//						//canvas.applyFilter(canvas,canvas.rect,new Point(),blur);
				//						canvas.colorTransform(canvas.rect,tran);
				//						trace("transform[" + (flash.utils.getTimer() - t) + "]");
				//						t = flash.utils.getTimer();
				//						canvas.draw(node,mtx);
				//						trace("draw[" + (flash.utils.getTimer() - t) + "]");
				//						node.angle += 0.1;
				//						seek++;
				//						batch.push(node);
				//						if(seek >= 100)
				//						{
				//							seek = 0;
				//							return;
				//						}
				//					}
				//					
				//					
				//				}
				//				else
				//				{
				//					queue = batch;
				//					batch = new Vector.<Particle>();
				//				}
				
				
				for each(node in queue)
				{
					node.x = pos.x + Math.cos(node.angle) * (radiusX);
					node.y = pos.y + Math.sin(node.angle) * (radiusY);
					radiusXseek += seek;
					radiusYseek += seek;
					pos.y-= 3;
					
					//mtx.tx = node.x;
					//mtx.ty = node.y;

					//canvas.applyFilter(canvas,canvas.rect,new Point(),blur);
					//canvas.colorTransform(canvas.rect,tran);

					node.angle += 0.4;
					
				}
				
				//trace(queue.length + "");
			});
			
			stage.addEventListener(MouseEvent.RIGHT_CLICK,function(event:Event):void{
				
				for(var i:int = 0; i< 1; i++)
				{
					ball = new Particle(int(Math.random() * 10));
					ball.angle = Math.random() * 100;
					queue.push(ball);
					stage.addChild(ball);
				}
				
			});
		}
		
		[Embed(source="img.png")]
		private var Img:Class;
		private function bitmap555():void
		{
			var img:Bitmap = new Img() as Bitmap;
			var orgin:BitmapData = img.bitmapData;
			var small:BitmapData = new BitmapData(img.width,img.height);
			//var fff:BitmapData = new BitmapData(img.width,img.height);
			for(var i:int=0; i<img.height; i++)
			{
				for(var j:int=0; j<img.width; j++)
				{
					var pixel:uint = orgin.getPixel(j,i);
					//pixel = ColorCode.RGB888ToRGB565(pixel);
					//var fix:uint = ColorCode.RGB565ToRGB888(pixel,false).Pixel;
					//pixel = ColorCode.RGB565ToRGB888(pixel,false).Pixel;
					
					//pixel = ColorCode.RGB4444ToRGB8888(,false).Pixel;
					var rgba:RGBA = ColorCode.RGB8888ToRGB4444(pixel);
					small.setPixel(j,i,rgba.Pixel);
					//fff.setPixel(j,i,fix);
				}
			}
			
			var image:Bitmap = new Bitmap(small);
			addChild(image);
			
			img.x = img.width;
			addChild(img);
			
			
			var a:PNGEncoderOptions = new PNGEncoderOptions();
			
			var data:ByteArray = small.encode(small.rect,a);
			
			var writer:FileStream = new FileStream();
			var file:File = new File("D:\\4444.png");
			writer.open(file,FileMode.WRITE);
			writer.writeBytes(data,0,data.length);
			writer.close();
		}
		
		private function readswf():void
		{
			//var data:ByteArray = new C() as ByteArray;
			//var swf:Swf = SwfFactory.Instance.Decode(data);
			
		}
		
//		private function workerTest():void
//		{
//			
//			PixelWorkerHelper.instance.createWorkerByURL("TestWorker.swf");
//			PixelWorkerHelper.instance.addEventListener(PixelWorkerEvent.WORKER_COMPLETE,function(event:PixelWorkerEvent):void{
//				var work:PixelWorker = event.message as PixelWorker;
//				work.addEventListener(PixelWorkerEvent.MESSAGE_AVAILABLE,function(event:PixelWorkerEvent):void{
//					var msg:PixelWorkerLoaderMessageResponse = event.message as PixelWorkerLoaderMessageResponse;
//					
//					if(msg.shareMemory)
//					{
//						var memory:ByteArray = work.getShareProperty(ShareMemory.SHARE_BYTEARRAY) as ByteArray;
//						var a:flash.display.Loader = new flash.display.Loader();
//						var ctx:LoaderContext = new LoaderContext();
//						ctx.applicationDomain = ApplicationDomain.currentDomain;
//						ctx.allowCodeImport = true;
//						a.loadBytes(memory,ctx);
//						a.contentLoaderInfo.addEventListener(Event.COMPLETE,function(event:Event):void{
//							var vec:Vector.<String> = a.contentLoaderInfo.applicationDomain.getQualifiedDefinitionNames();
//							trace(vec.length + "");
//						});
//					}
//				});
//				work.start();
//				
//				stage.addEventListener(MouseEvent.CLICK,function(event:MouseEvent):void{
//					var req:PixelWorkerMessageRequest = new PixelWorkerMessageRequest(PixelWorkerMessage.LOAD_SWF);
//					req.message = "http://175.10.1.144:9200/payplateform/UI.swf";
//					work.sendMessage(req);
//				});
//			});
//		}
	}
}

import flash.display.Bitmap;

import pixel.ui.control.LayoutConstant;
import pixel.ui.control.UIContainer;
import pixel.ui.control.UIImage;
import pixel.utility.BitmapTools;
import pixel.utility.Tools;

/**
 * Flow 节点UI定义
 **/
class WorldFlowItem extends UIContainer
{
	public function WorldFlowItem(itemWidth:Number = 0,itemHeight:Number = 0)
	{
		super();
		//this.LeftBottomCorner = this.LeftTopCorner = this.RightBottomCorner = this.RightTopCorner = 5;
		this.Layout = LayoutConstant.VERTICAL;
		this.Gap = this.padding = 5;
		this.BorderThinkness = 0;
		if(itemWidth > 0)
		{
			width = itemWidth;
		}
		if(itemHeight > 0)
		{
			height = itemHeight;
		}
		
		_image = new UIImage();
		addChild(_image);
	}
	
	public function set image(value:Bitmap):void
	{
		_image.image = value;
	}
	
	private var _image:UIImage = null;
	//private var _infoBar:InfoBar = null;
	
	/**
	 * 初始化
	 * 
	 **/
	override public function initializer():void
	{
		super.initializer();
		
		//_infoBar = new InfoBar();
		//addChild(_infoBar);
	}
}

import com.greensock.TweenMax;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Rectangle;

import pixel.ui.control.LayoutConstant;
import pixel.ui.control.UIContainer;
import pixel.ui.control.UIPanel;

class ShowcaseFlow extends Sprite
{
	private var _content:UIContainer = null;
	
	public function set padding(value:int):void
	{
		_content.x = _content.y = value;
	}
	
	private var _nodeW:int = 0;
	private var _nodeH:int = 0;
	private var _nodeGap:int = 0;

	public function ShowcaseFlow(sizeW:int,sizeH:int,nodeW:int,nodeH:int)
	{
		super();
		_content = new UIContainer();
		_content.Layout = LayoutConstant.HORIZONTAL;
		super.addChild(_content);
		_scrollWidth = sizeW;
		_scrollHeight = sizeH;
		_nodeW = nodeW;
		_nodeH = nodeH;
		_content.Gap = _nodeGap = (sizeW - (nodeW + (nodeW / 3 * 2))) * 0.5;
		_currentX = _content.x = int(_nodeGap + nodeW / 3);
		updateScrollRect();
	}
	private var _scrollSeek:int = 0;
	private var _nodeCount:int = 0;
	override public function addChild(child:DisplayObject):DisplayObject
	{
		_content.addChild(child);
		_nodeCount++;
		return child;
	}
	
	private var _scrollWidth:Number = 0;
	private var _scrollHeight:Number = 0;
	override public function set width(value:Number):void
	{
		super.width = value;
		_scrollWidth = value;
		updateScrollRect();
	}
	
	override public function set height(value:Number):void
	{
		super.height = value;
		_scrollHeight = value;
		updateScrollRect();
	}
	private var _duration:Number = 1;
	private function updateScrollRect():void
	{
		this.scrollRect = new Rectangle(0,0,_scrollWidth,_scrollHeight);
	}
	
	/**
	 * 向左滑动
	 **/
	public function scrollLeft():void
	{
		if(_scrollSeek + 1 < _nodeCount)
		{
			_currentX = _currentX - (_nodeW + _nodeGap);
			TweenMax.to(_content,_duration,{x : _currentX});
			_scrollSeek++;
		}
		
	}
	
	private var _currentX:Number = 0;
	/**
	 * 向右滑动
	 **/
	public function scrollRight():void
	{
		if(_scrollSeek > 0)
		{
			_currentX = _currentX + (_nodeW + _nodeGap);
			TweenMax.to(_content,_duration,{x : _currentX});
			_scrollSeek--;
		}
	}
	
	public function scrollTop(offset:Number):void
	{
		var target:Number = _content.y - offset;
		TweenMax.to(_content,_duration,{y : target});
	}
	
	public function scrollBottom(offset:Number):void
	{
		var target:Number = _content.y + offset;
		TweenMax.to(_content,_duration,{y : target});
	}
}

class Ctx
{
	public var sid:String = "";
}

import flash.display.Sprite;
import flash.filters.BlurFilter;
import flash.filters.GlowFilter;
import flash.geom.Point;

class Particle extends Sprite
{
	public var angle:Number = 0;
	public var health:Number = 100;
	public var velocityX:int = 5;
	public var velocityY:int = 5;
	public function Particle(radius:Number = 2)
	{
		this.graphics.beginFill(Math.random() * 0xFFFFFF);
		this.graphics.drawCircle(0,0,radius);
		this.graphics.endFill();
		
		var glow:GlowFilter = new GlowFilter(0x00FF00,0.5);
		var blur:BlurFilter = new BlurFilter(5,5,1);
		this.filters = [blur];
	}
}