package mbj {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	// Parent class of the whole game. Responsible for overarching functions like display and timeline management
	public class Document extends MovieClip{

		private var game:Game;
		public static const BUST:int = 0;
		public static const STAY:int = 1;
		public static const devMode:Boolean = false;
		public var game_started = false;
		private var tutorial:Tutorial;
		private var gameoverScreen:GameOver;
		
		public function get Tutorial_main():Tutorial{ return tutorial;}

		public function Document(){
			// constructor code
			tutorial = new Tutorial(this);
		}
		
		public function startGame(e:MouseEvent){
			trace("Start game");
			gotoAndPlay("main");
			game_started = true;
			game = new Game();
			addChild(game);
			game.begin();
			if(gameoverScreen){
				gameoverScreen.visible = false;
			}
			hideDisks();
		}
		
		
		
		public function getGame():Game{
			return game;
		}
		
		public function gameOver(screen:GameOver){
			gameoverScreen = screen;
			addChild(screen);
		}
		
		public function enableHitStay(enable:Boolean){
			hit_btn.visible = enable;
			stay_btn.visible = enable;
		}
		
		public function enableDealerCards(enable:Boolean){
			deck_btn.visible = enable;
		}
		
		public function enableBetting(enable:Boolean){
			bet_50.visible = enable;
			bet_100.visible = enable;
			bet_500.visible = enable;
		}
		
		public function enablePowerups(enable:Boolean){
			user_powerupBox.visible = enable;
		}
		
		public function hideDisks():void{
			user_stay.visible = false;
			user_bust.visible = false;
			comp_stay.visible = false;
			comp_bust.visible = false;
		}
		
		// Shows either a bust or stay box
		public function showDisk(player:Player, message_index:int){
			if(player is Human){
				if(message_index == BUST){
					user_bust.visible = true;
				}else if(message_index == STAY){
					user_stay.visible = true;
				}
			}else{
				if(message_index == BUST){
					comp_bust.visible = true;
				}else if(message_index == STAY){
					comp_stay.visible = true;
				}
			}
		}
		
		public function showHelpBox(m:String){
			trace(m);
		}

	}
	
}
