package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;

	public class ladrillo
	{
		public var model:MovieClip;
		public var hitsSuported:int;
		public var hitsTaken:int = 0;
		
		public var originalColor:ColorTransform;
		public var effectColor:ColorTransform;
		
		public var timeToReturnOriginalColor:int = 50;
		public var currentTimeToReturnOriginalColor:int = 0;
		protected  var index:int;
		public var destruction:Boolean = false;
		public function ladrillo()
		{
		}
		
		public function spawn (i:int):void
		{
			index = i;
			configObject();
			Main.mainStage.addChild(model);
			model.scaleX = 1;
			model.scaleY = 1;	
			
			effectColor = new ColorTransform();
			effectColor.color = 0xFFFFFF;
			
			originalColor = model.transform.colorTransform;
		}
		
		public function configObject():void
		{
			model = new MC_brickBlue;
			hitsSuported = 3;
		}
		
		public function destroy(): void
		{
			Main.removeLadrilloFromArray(index);
			if(Main.mainStage.contains(model))
			{
				Main.mainStage.removeChild(model);
			}
		}
		public function hitTaken():void
		{
			model.transform.colorTransform = effectColor;
			hitsTaken ++;
			Main.mainStage.addEventListener(Event.ENTER_FRAME,updateTimeToChangeColorBrick);
		}
		
		public function updateTimeToChangeColorBrick(e:Event):void
		{
			currentTimeToReturnOriginalColor += 1000 / Main.mainStage.frameRate;
			if(currentTimeToReturnOriginalColor >= timeToReturnOriginalColor)
			{
				model.transform.colorTransform = originalColor;
				currentTimeToReturnOriginalColor = 0;
				Main.mainStage.removeEventListener(Event.ENTER_FRAME, updateTimeToChangeColorBrick);
				if (hitsTaken >= hitsSuported)
				{
					destruction = true;
					destroy();					
				}
			}
		}
				
	}
}