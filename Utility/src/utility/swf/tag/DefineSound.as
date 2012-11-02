package utility.swf.tag
{
	import utility.swf.ByteStream;
	
	import flash.events.Event;
	import flash.media.Sound;
	
	import mx.effects.SoundEffect;
	import mx.effects.effectClasses.SoundEffectInstance;

	public class DefineSound extends GenericTag
	{
		private var _SoundFormat:int = 0;
		private var _SoundRate:int = 0;
		private var _SoundSize:int = 0;
		private var _SoundType:int = 0;
		private var _SoundSimpleCount:int = 0;
		private var _SoundData:ByteStream = null;
		
		public function DefineSound(Stream:ByteStream = null)
		{
			super(Tag.DEFINESOUND,Stream);
		}
		
		override public function Decode(Stream:ByteStream):void
		{
			_TagId = Stream.ReadUI16();
			_SoundFormat = Stream.ReadBits(4);
			_SoundRate = Stream.ReadBits(2);
			_SoundSize = Stream.ReadBits(1);
			_SoundType = Stream.ReadBits(1);
			_SoundSimpleCount = Stream.ReadUI32();
			_SoundData = Stream.ReadBytes(Stream.Available);
		}
	}
}