package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	

	public class powerUpsRed extends powerUps
	{
		
		
		public function powerUpsRed()
		{
		}
		
		override public function configObj():void
		{
			model = new MC_redPower;
		}
	}
}