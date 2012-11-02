package editor.model.asset
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.controls.Alert;
	import mx.utils.StringUtil;
	
	import utility.ISerializable;
	import utility.Tools;

	/**
	 * 资产库模型
	 * 
	 * 对应的资产模型数据后缀为ass
	 * 
	 * 数据结构为
	 * 
	 * 1	Short	资产库版本
	 * 20	Byte	名称
	 * 32	Byte	资产库ID
	 * 1	Short	资产库包含资源数量
	 * 
	 * 1	Short	资源类型	0:图片
	 * 32	Byte	资源ID
	 * 1	Short 	图片宽度
	 * 1	Short	图片高度
	 * 1	Short	资源长度
	 * x	Byte	资源数据
	 * 
	 **/
	public class AssetLibrary implements IAssetLibrary
	{
		private var _Name:String = "";
		public function set Name(Value:String):void
		{
			_Name = Value;
		}
		public function get Name():String
		{
			return _Name;
		}
		private var _Version:uint = 0;
		/**
		 * 资产模型版本
		 **/
		public function get Version():uint
		{
			return _Version;
		}
		public function set Version(Value:uint):void
		{
			_Version = Value;
		}
		private var _Id:String = "";
		/**
		 * 资产模型ID
		 **/
		public function get Id():String
		{
			return _Id;
		}
		public function set Id(Value:String):void
		{
			_Id = Value;
		}
		
		private var _Total:uint = 0;
		/**
		 * 资源总数
		 **/
		public function get Total():uint
		{
			return _Total;
		}
		
		private var _Assets:Dictionary = new Dictionary();
		private var _AssetArray:Array = [];
		
		public function AssetLibrary()
		{
		}
		
		public function get AssetList():Array
		{
			return _AssetArray;
		}
		
		public function get Type():uint
		{
			return AssetLibraryType.ASSL;
		}
		
		public function FindAssetById(Id:String):Asset
		{
			if(_Assets.hasOwnProperty(Id))
			{
				return _Assets[Id];
			}
			return null;
		}
		
		/**
		 * 添加一个图片资产
		 **/
		public function AddBitmapFromByteArray(Pixels:ByteArray,ImgWidth:uint,ImgHeight:uint):Asset
		{
			var AssetId:String = Tools.MD5Encode(Pixels);
			if(_Assets.hasOwnProperty(AssetId))
			{
				Alert.show("添加的图片在库中已存在，不允许重复添加!","操作禁止");
				return null;
			}
			
			var Item:AssetBitmap = new AssetBitmap();
			Item.Id = AssetId;
			Item.Data = Pixels;
			Item.ImageWidth = ImgWidth;
			Item.ImageHeight = ImgHeight;
			
			AddAsset(Item);
//			_Assets[Item.Id] = Item;
//			_AssetArray.push(Item);
//			_Total++;
			return Item;
		}
		
		/**
		 * 删除一个资产
		 **/
		public function DeleteAsset(Item:Asset):void
		{
			if(_Assets.hasOwnProperty(Item.Id) && _AssetArray.indexOf(Item) >= 0)
			{
				delete _Assets[Item.Id];
				_AssetArray.splice(_AssetArray.indexOf(Item),1);
				_Total--;
			}
		}
		
		/**
		 * 添加一个图片资产
		 **/
		public function AddBitmap(Image:Bitmap):Asset
		{
			var Pixels:ByteArray = Image.bitmapData.getPixels(Image.bitmapData.rect);
			Pixels.position = 0;
			return AddBitmapFromByteArray(Pixels,Image.bitmapData.width,Image.bitmapData.height);
		}
		
		/**
		 * 资产库编码
		 **/
		public function Encode():ByteArray
		{
			var EncodeByte:ByteArray = new ByteArray();
			EncodeByte.writeShort(_Version);
			var LibName:String = Tools.FillChar(_Name," ",20);
			EncodeByte.writeUTFBytes(LibName);
			EncodeByte.writeUTFBytes(_Id);
			EncodeByte.writeShort(_Total);
			
			var Key:* = "";
			var Asset:ISerializable = null;
			var AssetByte:ByteArray = null;
			for(Key in _Assets)
			{
				Asset = _Assets[Key] as ISerializable;
				AssetByte = Asset.Encode();
				EncodeByte.writeBytes(AssetByte,0,AssetByte.length);
			}
			EncodeByte.position = 0;
			return EncodeByte;
		}
		
		/**
		 * 从数据解码资产库
		 **/
		public function Decode(Data:ByteArray):void
		{
			_Version = Data.readShort();
			_Name = Data.readUTFBytes(20);
			_Name = StringUtil.trim(_Name);
			_Id = Data.readUTFBytes(32);
			_Total = Data.readShort();
			
			var AssetChild:Asset = null;
			var AssetId:String = "";
			var Type:uint = 0;
			var ByteLen:uint = 0;
			for(var Idx:uint=0; Idx<_Total; Idx++)
			{
				AssetId = Data.readUTFBytes(32);
				Type = Data.readShort();
				switch(Type)
				{
					case AssetType.BITMAP:
						//图形资产
						AssetChild = new AssetBitmap();
						break;
				}
				AssetChild.Id = AssetId;
				AssetChild.Type = Type;
				AssetChild.Decode(Data);
				
				AddAsset(AssetChild);
			}
		}
		
		protected function AddAsset(Item:Asset):void
		{
			_Assets[Item.Id] = Item;
			_AssetArray.push(Item);
			_Total++;
		}
	}
}