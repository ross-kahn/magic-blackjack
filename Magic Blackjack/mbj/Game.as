package mbj {
	import flash.display.Sprite;
	import flash.text.TextField;
	import mbj.powerups.Powerup;
	import flashx.textLayout.events.DamageEvent;
	
	public class Game extends Sprite{

		public var human:Human;		
		public var computer:Computer;
		private var dealer:Dealer;
		public var humanCardstack:CardStack;
		public var compCardstack:CardStack;
		public var compScore_txt:TextField;
		public var humanScore_txt:TextField;
		private var potAmount:int;

		public function Game(){
			// constructor code
		}
		
		// Debugging function
		public function test():void{
			//trace("computer isActive?: " + computer.Is_Active.toString() + "; handPoints: " + computer.Cardstack.calcPoints());
			//trace("human isActive?: " + human.Is_Active.toString() +"; handPoints: " + human.Cardstack.calcPoints());
			//(parent as Document).user_pointsbar.addPoints();
		}
		
		// writes a message to the screen so the players can see
		public function writeMessage(m:String){
			trace(m);
			(parent as Document).message_txt.text = m;
		}
		
		// The game is over, either because one player ran out of money or because the other one got all the points
		public function gameOver(winner:Player){
			if(winner is Human){
				(parent as Document).gameOver(new GameOver("You Win!"));
			}else{
				(parent as Document).gameOver(new GameOver("You Lose!"));
			}
		}
		
		// turns off certain buttons so the player can't do something out of turn
		public function newHand():void{
			(parent as Document).enableHitStay(false);
			(parent as Document).enableDealerCards(false);
			(parent as Document).enablePowerups(false);
			(parent as Document).enableBetting(true);
			
		}
		
		// Updates the point bars of the players. Ends the game if necessary
		public function updatePointsBar(p:Player, section:int):void{
			if(p is Human){
				(parent as Document).user_pointsbar.goToPoints(section);
				if((parent as Document).user_pointsbar.Win){
					gameOver(p);
				}
			}else if(p is Computer){
				(parent as Document).computer_pointsbar.goToPoints(section);
				if((parent as Document).user_pointsbar.Win){
					gameOver(p);
				}
			}else{
				trace("Error in updatePointsBar, not valid player '" + p + "'.");
			}
			(parent as Document).user_pointsbar.points_txt.text = "Points: " + human.Points.toString();
			(parent as Document).computer_pointsbar.points_txt.text = "Points: " + computer.Points.toString();
		}
		
		// Sets up the game to be played
		public function begin():void{
			
			// Creates a human and computer player. Default values for initial money
			// is located in Player.as
			human = new Human(this, (parent as Document).user_powerupBox);
			computer = new Computer(this, (parent as Document).comp_powerupBox);
			
			newHand();
			humanCardstack = (parent as Document).human_stack;
			compCardstack = (parent as Document).comp_stack;
			compScore_txt = (parent as Document).compScore_txt;
			humanScore_txt = (parent as Document).userScore_txt;
			(parent as Document).comp_money.text = "comp money: " + computer.Money;
			(parent as Document).user_money.text = "player money: " + human.Money;
			dealer = new Dealer(this);
			Powerup.initAllPowerups(this);
			
			human.initCardStack(humanCardstack);
			computer.initCardStack(compCardstack);
		}
		
		public function getDealer():Dealer{
			return dealer;
		}

		public function updateScoreDisplay(hScore:int, cScore:int){
			humanScore_txt.text = hScore.toString();
			compScore_txt.text = cScore.toString();
		}

		// Basically does an exlusive OR on player's activity. If one player is done and
		// the other is not, the active player should loop until bust or stay. If both players
		// are active, the turns should switch, and if neither player is active calcPoints() should
		// catch it and end the hand
		public function opponentActive(currentPlayer:Player):Boolean{
			return getOpponentPlayer(currentPlayer).Is_Active;
		}
		
		public function getOpponentPlayer(curPlayer:Player):Player{
			if(curPlayer is Human){
				return computer;
			}else if(curPlayer is Computer){
				return human;
			}else{
				trace("Error in getOpponentPlayer in Game.as: '"+curPlayer+"'. Returning computer player as default");
				return computer;
			}
		}

		// returns true if play should proceed
		public function calcPoints():Boolean{
			//trace("Calculating points...");
			var hScore = human.Cardstack.calcPoints();
			var cScore = computer.Cardstack.calcPoints();
			updateScoreDisplay(hScore, cScore);
			
			if(hScore > 21){
				// bust human
				writeMessage("User bust: " + hScore);
				(parent as Document).showDisk(human, Document.BUST);
				human.setActive(false);
				computer.setActive(false);
				endHand(computer, false);
				return false;
			}else if(cScore > 21){
				// bust computer
				writeMessage("Computer bust: " + cScore);
				(parent as Document).showDisk(computer, Document.BUST);
				computer.setActive(false);
				human.setActive(false);
				endHand(human, false);
				return false;
			}else if(!computer.Is_Active && !human.Is_Active){
				if(cScore == hScore){
					// draw
					writeMessage("Draw: " + cScore);
					endHand(null, true);
				}else if(cScore > hScore){
					writeMessage("Computer wins: " + cScore);
					endHand(computer, false);
				}else if(hScore > cScore){
					writeMessage("User wins: " + hScore);
					endHand(human, false);
				}else{
					trace("Unknown event in calcPoints leading to no winner");
				}
				return false;
			}else if(!computer.Is_Active || !human.Is_Active){
				//trace("One player is finished, the other may proceed");
				return false;
			}else{
				return true;
			}
			
		}
		
		// Deals the initial cards to the players
		public function deal():void{
			computer.bet();
			(parent as Document).enableHitStay(true);
			(parent as Document).enableDealerCards(false);
			(parent as Document).enablePowerups(true);
			(parent as Document).comp_money.text = "comp money: " + computer.Money;
			(parent as Document).user_money.text = "player money: " + human.Money;
		}
		
		// Player wins a hand. Update all the displays and start a new hand
		public function playerWins(player:Player, isdraw:Boolean):void{
			writeMessage("");
			dealer.shuffle();	// resets cardstacks
			if(!isdraw){
				player.modifyMoney(potAmount);
				potAmount = 0;
				(parent as Document).pot_txt.text = "Pot: 0";
			}
			(parent as Document).comp_money.text = "comp money: " + computer.Money;
			(parent as Document).user_money.text = "player money: " + human.Money;
			(parent as Document).enableHitStay(false);
			(parent as Document).enableDealerCards(false);
			(parent as Document).enableBetting(true);
			(parent as Document).enablePowerups(false);
			updateScoreDisplay(0, 0);
			human.setActive(true);
			computer.setActive(true);
			(parent as Document).hideDisks();
			if(getOpponentPlayer(player).Money <= 0){
				gameOver(player);
			}
		}
		
		private function endHand(winner:Player, isdraw:Boolean):void{
			(parent as Document).enableHitStay(false);
			(parent as Document).enablePowerups(false);
			(parent as Document).ok_btn.assignWinner(winner, isdraw);
		}
		
		public function addToPot(amount:int){
			(parent as Document).enableDealerCards(true);
			(parent as Document).enableBetting(false);
			potAmount += amount;
			(parent as Document).pot_txt.text = "Pot: " + (potAmount).toString();
		}
		
		public function doublePot():void{
			addToPot(potAmount);
		}
		
		// Allows the human player to press buttons in order to play
		public function playHuman():void{
			trace("Human's turn...");
			calcPoints();
			// end computer turn
			(parent as Document).enablePowerups(true);
			if(human.Is_Active){
				// enable powerups
				(parent as Document).enableHitStay(true);
			}else{
				calcPoints();
				if(computer.Is_Active && human.Is_Active){
					playComputer();
				}
			}
		}
		
		// The AI takes over and does his powerups and hitting/staying automatically
		public function playComputer():void{
			trace("Computer's turn...");
			calcPoints();
			// end human turn
			// disable powerups
			(parent as Document).enableHitStay(false);
			(parent as Document).enablePowerups(false);
			if(computer.Is_Active){
				// use best available powerup
				computer.useBestPowerup();
				if(computer.Cardstack.calcPoints() >= 19){
					dealer.stay(computer);
				}else{
					dealer.hit(computer);
				}
			}else{
				calcPoints();
				if(computer.Is_Active && human.Is_Active){
					playHuman();
				}
			}
			// if active and conditions are right, use powerup and either hit or stay
			// move back to human
		}

	}
	
}
