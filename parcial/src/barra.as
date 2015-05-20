package
{
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	public class barra
	{
		public var lifes:int = 3;
		public var speed:int = 5;
		public var model:MC_barra;
		
		public var originalColor:ColorTransform;
		public var effectColor:ColorTransform;
		
		public var timeToReturnOriginalColor:int = 50;
		public var currentTimeToReturnOriginalColor:int = 0;
			
		public function barra()
		{
		}
		
		public function spawn (posX:int, posY:int):void
		{
			model = new MC_barra;
			Main.mainStage.addChild(model);
			model.x = posX;
			model.y = posY;
			model.scaleX = 1.5;
		
			effectColor = new ColorTransform();
			effectColor.color = 0xFFFFFF;
			
			originalColor = model.transform.colorTransform;
		}
		
		public function move (direction:int):void
		{
			model.x += speed*direction;
		}
		
		
		public function loseLife():void
		{
			model.transform.colorTransform = effectColor;
			Main.mainStage.addEventListener(Event.ENTER_FRAME, updateTimeToChangeColor);
			lifes--;
			if(lifes <= 0)
			{
				Main.loose();
			}
		}
	
		public function updateTimeToChangeColor(event:Event):void
		{
			currentTimeToReturnOriginalColor += 1000 / Main.mainStage.frameRate;
			if(currentTimeToReturnOriginalColor >= timeToReturnOriginalColor)
			{
				model.transform.colorTransform = originalColor;
				currentTimeToReturnOriginalColor = 0;
				Main.mainStage.removeEventListener(Event.ENTER_FRAME, updateTimeToChangeColor);
			}
		}
	}
}