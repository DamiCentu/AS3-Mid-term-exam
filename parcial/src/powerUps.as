package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	

	public class powerUps
	{
		public var model:MovieClip;
		public var speed:int = 3;
		public var spawneo:Boolean = false;
		
		
		public function powerUps()
		{
			Main.mainStage.addEventListener(Event.ENTER_FRAME,powerUpsThings);
		}
		
		public function spawn (posX:int, posY:int):void
		{
			configObj();
			model.x = posX;
			model.y = posY;
			Main.mainStage.addChild(model)
			spawneo = true;
		}
		public function configObj():void
		{
			model = new MC_yellowPower;
		}
	
		public function powerUpsThings(e:Event):void
		{
			if (spawneo)
			{
				model.y += speed;
			
				if(model.y >= Main.mainStage.height || Main.endGame)
				{
					destroy ();
				}
			}
		}
		public function destroy ():void
		{
			spawneo = false;
			Main.mainStage.removeChild(model)
			model = null;
		}
	}
}