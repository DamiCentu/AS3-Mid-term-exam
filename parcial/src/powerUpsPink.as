package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	

	public class powerUpsPink extends powerUps
	{
		
		
		public function powerUpsPink()
		{
		}
		
		override public function configObj():void
		{
			model = new MC_pinkPower;
		}
	}
}