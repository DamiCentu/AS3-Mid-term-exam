package
{
	public class ladrilloYellow extends ladrillo
	{
		public function ladrilloYellow()
		{
		}
		
		override public function configObject():void
		{
			model = new MC_BrickYellow;
			hitsSuported = 2;
		}				
	}
}