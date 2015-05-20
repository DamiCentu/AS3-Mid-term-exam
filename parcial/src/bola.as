package
{
	import flash.events.Event;

	public class bola
	{
		public var speedX:int;
		public var speedY:int;
		public var reverseSpeed:int = -1;
		public var model:MC_bola;
		public var scaleModel:Number = 0.5; 
		
		public function bola()
		{
			Main.mainStage.addEventListener(Event.ENTER_FRAME, move)
		}
		
		public function spawn(posX:int, posY:int):void
		{
			model = new MC_bola
			Main.mainStage.addChild(model);
			model.x = posX;
			model.y = posY;
			model.scaleX= scaleModel;
			model.scaleY = scaleModel;
		}
		
		public function destroy():void
		{
			Main.mainStage.removeChild(model);
			model = null;
		}
		public function move (event:Event):void
		{
			if (!Main.endGame)
			{
				model.x += speedX;
				model.y += speedY;
				
				if (model.y <= 0)
				{
					speedY = speedY * reverseSpeed;
				}
				else if (model.x >= Main.mainStage.stageWidth || model.x <= 0)
				{
					speedX = speedX * reverseSpeed;
				}
			}
		}
	}
}