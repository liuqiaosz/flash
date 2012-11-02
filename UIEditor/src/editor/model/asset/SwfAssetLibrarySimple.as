package editor.model.asset
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	
	import utility.swf.Swf;
	import utility.swf.SwfFactory;
	import utility.swf.tag.BitJPEG2;
	import utility.swf.tag.BitLossless2;
	import utility.swf.tag.GenericBit;
	import utility.swf.tag.SymbolClass;
	import utility.swf.tag.Tag;
	
	public class SwfAssetLibrarySimple extends AssetLibrary
	{
		private var _Swf:Swf = null;
		private var Initialized:Boolean = false;
		
		public function SwfAssetLibrarySimple()
		{
		}
		
		override public function get AssetList():Array
		{
			if(!Initialized)
			{
				//_BitmapAssets = [];
				var Idx:int = 0;
				//获取所有图形TAG
				var BitmapTagList:Array = _Swf.FindTagByType(Tag);
				//var JPGTabList:Array = _Swf.FindTagByType(Tag.DEFINEJPEG2);
				BitmapTagList = BitmapTagList.concat(_Swf.FindTagByType(Tag.LOSSLESS));
				BitmapTagList = BitmapTagList.concat(_Swf.FindTagByType(Tag.DEFINEJPEG2));
				
				var SymbolTag:SymbolClass = _Swf.FindTagByType(Tag.SYMBOLCLASS)[0];
				
				//var BitmapTag:BitLossless2 = null;
				var BitmapTag:GenericBit = null;
				var SymbolName:String = "";
				var AssetImage:AssetBitmap = null;
				
				
				for each(BitmapTag in BitmapTagList)
				{
					//处理图形
					SymbolName = SymbolTag.FindSymbolClassById(BitmapTag.TagId);
					AssetImage = new AssetBitmap();
					AssetImage.Id = SymbolName;
					AssetImage.ImageWidth = BitmapTag.BitmapWidth;
					AssetImage.ImageHeight = BitmapTag.BitmapHeight;
					
					AssetImage.Image = BitmapTag.Source as Bitmap;
					//_BitmapAssets.push(AssetImage);
					this.AddAsset(AssetImage);
				}
				
				//				if(SymbolTag && BitmapTagList.length > 0)
				//				{
				//					for(Idx; Idx<BitmapTagList.length; Idx++)
				//					{
				//						//处理图形
				//						BitmapTag = BitmapTagList[Idx];
				//						SymbolName = SymbolTag.FindSymbolClassById(BitmapTag.TagId);
				//						AssetImage = new AssetBitmap();
				//						AssetImage.Id = SymbolName;
				//						AssetImage.ImageWidth = BitmapTag.BitmapWidth;
				//						AssetImage.ImageHeight = BitmapTag.BitmapHeight;
				//						
				//						AssetImage.Image = BitmapTag.Source as Bitmap;
				//						//_BitmapAssets.push(AssetImage);
				//						this.AddAsset(AssetImage);
				//					}
				//				}
				//				var JPG:BitJPEG2 = null;
				//				for each(JPG in JPGTabList)
				//				{
				//					SymbolName = SymbolTag.FindSymbolClassById(JPG.TagId);
				//					AssetImage = new AssetBitmap();
				//					AssetImage.Id = SymbolName;
				//					AssetImage.ImageWidth = JPG.BitmapWidth;
				//					AssetImage.ImageHeight = JPG.BitmapHeight;
				//					
				//					AssetImage.Image = JPG.Source as Bitmap;
				//					//_BitmapAssets.push(AssetImage);
				//					this.AddAsset(AssetImage);
				//				}
				Initialized = true;
			}
			return super.AssetList;
		}
		//		public function get BitmapAssets():Array
		//		{
		//			
		//		}
		private var _SoundAssets:Array = null;
		public function SwfAssetLibrary()
		{
		}
		
		override public function get Type():uint
		{
			return AssetLibraryType.SWF;
		}
		
		/**
		 * 资产库编码
		 **/
		override public function Encode():ByteArray
		{
			return null;
		}
		
		/**
		 * 从数据解码资产库
		 **/
		override public function Decode(Data:ByteArray):void
		{
			_Swf = SwfFactory.Instance.Decode(Data);
			//this.Version = _Swf.Header.Version;
		}
	}
}