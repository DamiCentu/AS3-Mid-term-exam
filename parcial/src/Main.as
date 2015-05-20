package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Keyboard;

	[SWF(width="600", height="800", frameRate="60", backgroundColor="0x000000")]
	public class Main extends Sprite
	{
		public var myBarra:barra;
		public static var myBola:bola;
		public var myLadrillo:ladrillo;
		public var myPowerUps:powerUps;
		public static var vectorLadrillos:Vector.<ladrillo> = new Vector.<ladrillo>();
		public static var random:int;
		
		public var isRightPressed:Boolean;
		public var isLeftPressed:Boolean;
		public var isBarPressed:Boolean;
		
		public var currentTimeToPowerUp:int = 0;
		public var timeToAnotherPowerUp:int = 7500;
		public var resetTimerTime:int = 12500;
		public var timerPower:Boolean = false;
		
		public var currentTimeRemainingPowerUp:int = 0;
		public var timeRemainingPowerUp:int = 5000;
		
		public static var texto:TextField = new TextField();
		public static var formato:TextFormat = new TextFormat();
		public static var endGame:Boolean = false;
		
		public static var ladrillosLeft:int;
		
		public static var mainStage:Stage;
		
		public function Main()
		{
			mainStage = stage;
			myBarra = new barra();
			
			myBarra.spawn(mainStage.stageWidth / 2, mainStage.stageHeight - 100)
			
			myBola = new bola();
			myBola.spawn (myBarra.model.x, myBarra.model.y - myBarra.model.height - 1)
				
			spawnBricks();
			
			myPowerUps = new powerUps ();
			
			mainStage.addEventListener(Event.ENTER_FRAME, Update)
			mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyDown)
			mainStage.addEventListener(KeyboardEvent.KEY_UP, evKeyUp)
		}
		
		public function spawnBricks():void
		{
			var indexY:int = 0;
			var indexX:int = 0;
			var counter:int = 0;
			
			for (var i:int = 0; i < 27; i++) 
			{
				myLadrillo = new ladrillo();
				vectorLadrillos.push(myLadrillo);
				myLadrillo.spawn(counter);
				if (i % 9 == 0)
				{
					indexY ++;
				}
					myLadrillo.model.y = 15 + myLadrillo.model.height * indexY;
					myLadrillo.model.x = myLadrillo.model.width * (i % 9) + 47;
					counter ++;
			} 
			
			for (var ib:int = 0; ib < 27; ib++) 
			{
				myLadrillo = new ladrilloYellow();
				vectorLadrillos.push(myLadrillo);
				myLadrillo.spawn(counter);
				if (ib % 9 == 0)
				{
					indexY ++;
				}
				myLadrillo.model.y = 15 + myLadrillo.model.height * indexY;
				myLadrillo.model.x = myLadrillo.model.width * (ib % 9)+ 47;
				counter ++;
			}
			
			for (var ic:int = 0; ic < 27; ic++) 
			{
				myLadrillo = new ladrilloRed();
				vectorLadrillos.push(myLadrillo);
				myLadrillo.spawn(counter);
				if (ic % 9 == 0)
				{
					indexY ++;
				}
				myLadrillo.model.y = 15 + myLadrillo.model.height * indexY;
				myLadrillo.model.x = myLadrillo.model.width * (ic % 9)+ 47;
				counter ++;
			}
			ladrillosLeft = counter;
		}
		
	
		public static function loose():void
		{
			formato.font = "Comic Sans MS";
			formato.size = 30;
			formato.color = 0xFFFFFF;
			formato.align = TextFormatAlign.CENTER;
			texto.width = 300;
			texto.x = mainStage.stageWidth / 2 - texto.width / 2;
			texto.y = mainStage.stageHeight / 2 - texto.height / 2;
			texto.text = "PERDISTE NIERI"
			texto.setTextFormat(formato)
			mainStage.addChild(texto);
				
			endGame = true;
		}
		public function Update (event:Event): void
		{
			if(!endGame)
			{
				colisionBolaBarra();
				colisionBolaLadrillo();
				colisionPowerUpsBarra();
				updateTimeToPowerUp ();
				lifeInStage();
				
				
				if(yellow2)
				{
					updateYellow();
				}
				else if (blue2)
				{
					updateBlue();
				}
				else if (pink2)
				{
					updatePink();
				}
				else if(ladrillosLeft <= 0)
				{
					win();
				}
				
				
				if(isRightPressed && myBarra.model.x < 600 - myBarra.model.width/2)
				{
					myBarra.move(1);
					if (myBola.speedX == 0 && myBola.speedY  == 0)
					{
						myBola.model.x = myBarra.model.x;
						myBola.model.y = myBarra.model.y - myBarra.model.height - 1;
					}
				}
				else if(isLeftPressed && myBarra.model.x > 0 + myBarra.model.width/2)
				{
					myBarra.move(-1);
					if (myBola.speedX == 0 && myBola.speedY  == 0)
					{
						myBola.model.x = myBarra.model.x;
						myBola.model.y = myBarra.model.y - myBarra.model.height - 1;
					}
				}
				else if (isBarPressed && myBola.speedY == 0 && myBola.speedX == 0)
				{
					myBola.speedY = -5;
					myBola.speedX = 5;
				}
				else if (myBola.model.y >= Main.mainStage.stageHeight)
				{
					myBarra.model.x = mainStage.stageWidth / 2;
					myBarra.model.y = mainStage.stageHeight - 100;
					myBola.model.x = myBarra.model.x;
					myBola.model.y = myBarra.model.y - myBarra.model.height - 1;
					myBola.speedY = 0;
					myBola.speedX = 0;
					myBarra.loseLife();
				}
			}
		}
		
		public function lifeInStage():void
		{
			formato.font = "Comic Sans MS";
			formato.size = 30;
			formato.color = 0xFFFFFF;
			formato.align = TextFormatAlign.CENTER;
			texto.width = 300;
			texto.x = -75;
			texto.y = mainStage.stageHeight - texto.height/2;
			texto.text = "Vidas: " + myBarra.lifes;
			texto.setTextFormat(formato)
			mainStage.addChild(texto);
		}
		
		public function win():void
		{
				formato.font = "Comic Sans MS";
				formato.size = 30;
				formato.color = 0xFFFFFF;
				formato.align = TextFormatAlign.CENTER;
				texto.width = 300;
				texto.x = mainStage.stageWidth / 2 - texto.width / 2;
				texto.y = mainStage.stageHeight / 2 - texto.height / 2;
				texto.text = "GANASTE NIERI"
				texto.setTextFormat(formato)
				mainStage.addChild(texto);
				
				endGame = true;
		}
		protected function evKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.RIGHT:
					isRightPressed = true;
					break;
				
				case Keyboard.LEFT:
					isLeftPressed = true;
					break;
				
				case Keyboard.SPACE:
					isBarPressed = true;
					break;
			}
		}
		
		public function evKeyUp(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.RIGHT:
					isRightPressed = false;
					break;
				
				case Keyboard.LEFT:
					isLeftPressed = false;
					break;
				
				case Keyboard.SPACE:
					isBarPressed = false;
					break;
			}
		}
		
		public function colisionBolaBarra():void
		{
			if (myBola.model.hitTestObject(myBarra.model))
			{
				myBola.speedY = myBola.speedY * myBola.reverseSpeed;
				
				if (myBola.model.x >= myBarra.model.x + 10)
				{
					if (myBola.speedX >= 0 || myBola.speedX <= 0)
					{
						myBola.speedX = 5;
					}
				}
				
				if (myBola.model.x <= myBarra.model.x - 10)
				{
					if (myBola.speedX >= 0 || myBola.speedX <= 0)
					{
						myBola.speedX = -5;
					}
				}
				
				if (myBola.model.x > myBarra.model.x - 10 && myBola.model.x < myBarra.model.x + 10)
				{
					myBola.speedX = 0;
				}
			}
		}
		
		public var yellow:Boolean = false;
		public var yellow2:Boolean = false;
		public var green:Boolean = false;
		public var blue:Boolean = false;
		public var blue2:Boolean = false;
		public var pink:Boolean = false;
		public var pink2:Boolean = false;
		public var red:Boolean = false;
		
		public function colisionBolaLadrillo():void
		{
			for each (var _ladrillo:ladrillo in vectorLadrillos)
			{
				if(_ladrillo != null && _ladrillo.model.hitTestObject(myBola.model))
				{
					if (myBola.model.x >= _ladrillo.model.x +_ladrillo.model.width / 2 || myBola.model.x <= _ladrillo.model.x -_ladrillo.model.width / 2)
					{
						myBola.speedX *= -1;
					}
				
					if ( myBola.model.y <= _ladrillo.model.y -_ladrillo.model.height / 2)
					{
						myBola.speedY *= -1;
					}
					
					else if (myBola.model.y  >= _ladrillo.model.y)
					{
						myBola.speedY *= -1;
					}
				
					_ladrillo.hitTaken();
												
					//power ups
					
					random = getRandom(0,20)
						
					if(timerPower == true)
					{
						if(random == 2)
						{
							myPowerUps = new powerUps;
							myPowerUps.spawn(_ladrillo.model.x - _ladrillo.model.width/2,_ladrillo.model.y - _ladrillo.model.height / 2);
							currentTimeToPowerUp = 0;
							yellow = true;
						}
						else if (random == 6)
						{
							myPowerUps = new powerUpsGreen;
							myPowerUps.spawn(_ladrillo.model.x - _ladrillo.model.width/2,_ladrillo.model.y - _ladrillo.model.height / 2);
							currentTimeToPowerUp = 0;
							green = true;
						}
						else if (random == 11)
						{
							myPowerUps = new powerUpsBlue;
							myPowerUps.spawn(_ladrillo.model.x - _ladrillo.model.width/2,_ladrillo.model.y - _ladrillo.model.height / 2);
							currentTimeToPowerUp = 0;
							blue = true;
						}
						else if (random == 15)
						{
							myPowerUps = new powerUpsPink;
							myPowerUps.spawn(_ladrillo.model.x - _ladrillo.model.width/2,_ladrillo.model.y - _ladrillo.model.height / 2);
							currentTimeToPowerUp = 0;
							pink = true;
						}
						else if (random == 19)
						{
							myPowerUps = new powerUpsRed;
							myPowerUps.spawn(_ladrillo.model.x - _ladrillo.model.width/2,_ladrillo.model.y - _ladrillo.model.height / 2);
							currentTimeToPowerUp = 0;
							red = true;
						}
						timerPower = false;
					}
				}
			}
		}
		
		public function updateTimeToPowerUp():void
		{
			currentTimeToPowerUp += 1000 / Main.mainStage.frameRate;
			if(timerPower == false)
			{
				if (currentTimeToPowerUp >= timeToAnotherPowerUp)
				{
					timerPower = true;
				}
			}
		}
		
		
		public static function removeLadrilloFromArray(index:int):void
		{
			//la posicion sigue estando pero vacia
			vectorLadrillos[index] = null;
			ladrillosLeft--;			
		}
		public function colisionPowerUpsBarra():void
		{
			if(myPowerUps.spawneo)
			{
				if (myPowerUps.model.hitTestObject(myBarra.model))
				{
					if (yellow)
					{
						yellow2 = true;
					}
					if (green)
					{
						myBola.model.x = myBarra.model.x;
						myBola.model.y = myBarra.model.y - myBarra.model.height - 1;
						myBola.speedX = 0;
						myBola.speedY = 0;
						green = false;
					}
					if (blue)
					{
						blue2 = true;
					}
					if(pink)
					{
						pink2 = true;
					}
					else if (red)
					{
						myBarra.lifes++;
						red = false;
					}
					myPowerUps.destroy();
				}
			}
		}
		
		public static function getRandom(min:int, max:int):int
		{
			return Math.random() * (max - min) + min;
		}
		
		public function updateBlue():void
		{
			currentTimeRemainingPowerUp += 1000 / Main.mainStage.frameRate;
			if (currentTimeRemainingPowerUp <= timeRemainingPowerUp)
			{
				myBarra.model.scaleX = 2;
			}
			else if (currentTimeRemainingPowerUp >= timeRemainingPowerUp)
			{
				myBarra.model.scaleX = 1.5;
				blue = false;
				blue2 = false;
				currentTimeRemainingPowerUp = 0;
			}
		}
		
		public function updateYellow():void
		{
			currentTimeRemainingPowerUp += 1000 / Main.mainStage.frameRate;
			if (currentTimeRemainingPowerUp <= timeRemainingPowerUp)
			{
				myBarra.model.scaleX = 1;
			}
			else if (currentTimeRemainingPowerUp >= timeRemainingPowerUp)
			{
				myBarra.model.scaleX = 1.5;
				yellow = false;
				yellow2 = false;
				currentTimeRemainingPowerUp = 0;
			}
		}
		public function updatePink():void
		{
			currentTimeRemainingPowerUp += 1000 / Main.mainStage.frameRate;
			if (currentTimeRemainingPowerUp <= timeRemainingPowerUp)
			{
				myBola.model.scaleX = 0.7;
				myBola.model.scaleY = 0.7;
			}
			else if (currentTimeRemainingPowerUp >= timeRemainingPowerUp)
			{
				myBola.model.scaleX = 0.5;
				myBola.model.scaleY = 0.5;
				pink = false;
				pink2 = false;
				currentTimeRemainingPowerUp = 0;
			}
		}
	}
}