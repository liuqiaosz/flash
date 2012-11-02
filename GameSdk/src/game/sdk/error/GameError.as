package game.sdk.error
{
	public class GameError extends Error
	{
		public static const ERROR_PARTITION_SIZE:String = "Area partition error. AreaWidth or AreaHeight invalid";
		public function GameError(Message:String = "",Id:uint = 0)
		{
			super(Message,Id);	
		}
	}
}