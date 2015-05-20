package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	

	public class powerUpsBlue extends powerUps
	{
		
		
		public function powerUpsBlue()
		{
		}
		
		override public function configObj():void
		{
			model = new MC_bluePower;
		}
	}
}