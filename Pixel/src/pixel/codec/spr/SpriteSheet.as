package pixel.codec.spr
{
	import flash.utils.ByteArray;

	/**
	 * 单个序列动画
	 **/
	public class SpriteSheet implements ISpriteSheet
	{
		private var _Id:String = "";
		//帧队列
		private var _Frames:Vector.<SpriteSheetFrame> = null;
		//
		private var _Delay:uint = 0;
		//
		private var _Index:uint = 0;
		
		public function set Id(Value:String):void
		{
			_Id = Value;
		}
		public function get Id():String
		{
			return _Id;
		}
		
		public function SpriteSheet()
		{
			_Frames = new Vector.<SpriteSheetFrame>();
		}
		
		public function get FrameCount():uint
		{
			return _Frames.length;
		}
		
		public function PushFrame(Frame:SpriteSheetFrame):void
		{
			_Frames.push(Frame);
		}
		public function PopFrame():SpriteSheetFrame
		{
			return _Frames.pop();
		}
		public function ShiftFrame():SpriteSheetFrame
		{
			return _Frames.shift();
		}
		
		public function set Position(Idx:uint):void
		{
			_Index = Idx;
			if(_Index >= _Frames.length)
			{
				_Index = _Frames.length - 1;
			}
		}
		
		public function get Frames():Vector.<SpriteSheetFrame>
		{
			return _Frames;
		}
		
		public function GetFrameByIndex(Idx:uint):SpriteSheetFrame
		{
			if(Idx < _Frames.length)
			{
				return _Frames[_Index];
			}
			return null;
		}
	
		public function get Position():uint
		{
			return _Index;
		}
		
		public function NextFrame():SpriteSheetFrame
		{
			_Index++;
			if(_Index >= _Frames.length)
			{
				_Index = 0;
			}
			return _Frames[_Index];
		}
		public function PrevFrame():SpriteSheetFrame
		{
			_Index--;
			if(_Index >= _Frames.length)
			{
				_Index = 0;
			}
			return _Frames[_Index];
		}
		public function get Delay():uint
		{
			return _Delay;
		}
		public function set Delay(Value:uint):void
		{
			_Delay = Value;
		}
		
		public function get IsLast():Boolean
		{
			if(_Index + 1 >= _Frames.length)
			{
				return true;
			}
			return false;
		}
		
		public function encode():ByteArray
		{
			var data:ByteArray = new ByteArray();
			data.writeByte(SpriteSheetMode.SHEET);
			data.writeByte(_Id.length);
			data.writeUTFBytes(_Id);

			data.writeByte(_Delay);
			data.writeByte(_Frames.length);
			var Frame:SpriteSheetFrame = null;
			var FrameData:ByteArray = null;
			for each(Frame in _Frames)
			{
				FrameData = Frame.encode();
				data.writeBytes(FrameData,0,FrameData.length);
				FrameData.clear();
				FrameData = null;
			}
			return data;
		}
		public function decode(data:ByteArray):void
		{
			var Len:uint = data.readByte();
			_Id = data.readUTFBytes(Len);
			data.readByte();
			
			_Delay = data.readByte();
			var Count:uint = data.readByte();
			var Frame:SpriteSheetFrame = null;
			for(var Idx:uint = 0; Idx<Count; Idx++)
			{
				Frame = new SpriteSheetFrame();
				Frame.decode(data);
				_Frames.push(Frame);
			}
		}
	}
}