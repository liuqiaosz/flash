package mapassistant.error
{
	public class DBError extends Error
	{
		public function DBError(Message:String = "",Id:int = 0)
		{
			super(Message,Id);
		}
	}
}