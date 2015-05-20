package
{
	public class ladrilloRed extends ladrilloYellow
	{
		public function ladrilloRed()
		{
		}
		
		override public function configObject():void{
			model = new MC_BrickRed;
			hitsSuported = 1;
		}				
	}
}