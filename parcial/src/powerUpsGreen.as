package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	

	public class powerUpsGreen extends powerUps
	{
		
		
		public function powerUpsGreen()
		{
		}
		
		override public function configObj():void
		{
			model = new MC_greenPower;
		}
	}
}