package mbj {
	import mbj.powerups.Powerup;
	import mbj.powerups.PowerupBox;
	
	// One of the most important classes in the game, besides Game, Document, and Dealer. Provides almost all functionality
	// relating to players, including receiving cards, using powerups, modifying money and point scores, and more
	public class Player{

		public static const pointInterval:int = 300;		// How many points the player needs for the poitns bar to go up
		public static const powerupInterval = 5;			// How many 'sections' between unlocking powerups
		protected var points:int;
		protected var money:int;
		public var game:Game;
		
		protected var availablePowerups:int;				// Highest unlocked powerup
		protected var activePowerups:Array;					// Received and unused powerups
		protected var cardstack:CardStack;					
		protected var is_active:Boolean;	// true if the player has NOT busted or stayed yet
		protected var pBox:PowerupBox;
		
		public function get Is_Active():Boolean{ return is_active;}
		public function get Cardstack():CardStack{return cardstack;}
		public function get Money():int {return money;}
		public function get Points():int {return points;}
		public function get ActivePowerups():Array { return activePowerups;}
		public function get AvailablePowerups():int { return availablePowerups;}

		// iPoints = initial points
		// iMoney = initial money
		public function Player(agame:Game, powerupBox:PowerupBox, iPoints:int = 0, iMoney:int = 2000){
			// constructor code
			game = agame;
			
			// If devMode, start out with all the powerups
			if(Document.devMode){
				activePowerups = new Array(true, true, true, true, true);
			}else{
				activePowerups = new Array(false, false, false, false, false);
			}
			availablePowerups = 0;
			points = iPoints;
			money = iMoney;
			is_active = true;
			pBox = powerupBox;
			pBox.updatePowerupsDisplay(this);
		}
		
		public function initCardStack(cs:CardStack):void{
			cardstack = cs;
		}
		
		// Adds a card to the cardstack. Also determines if a powerup is gained from this card
		public function getCard(c:Card):void{
			cardstack.addCard(c);
			
			trace(this + " available powerups: " + availablePowerups);
			// Player potentially receives a powerup
			if(availablePowerups > 0){
				// choose random powerup
				var pUp:int = -1;
				while(pUp < 0){
					pUp = Math.floor(Math.random()*availablePowerups);
					trace(this + " pUp = " + pUp + "; has a chance to receive a " + Powerup.allPowerups[pUp]);
				}
				var chosen:Powerup = Powerup.allPowerups[pUp];
				var diceRoll:Number = Math.random();	// random decimal between 0-1
				trace("Probability of " + chosen + ": " + chosen.Probability.toString() +"; diceRoll: " + diceRoll.toString());
				if(diceRoll <= chosen.Probability){
					activePowerups[pUp] = true;
				}else{
					// User did not pass the dice roll to obtain this powerup and recieves nothing
				}
			}
			pBox.updatePowerupsDisplay(this);
		}
		
		public function usePowerup(index:int){
			if(!Document.devMode){
				activePowerups[index] = false;
			}
			pBox.updatePowerupsDisplay(this);
			trace(this + " powerup used: " + Powerup.allPowerups[index]);
		}
		
		public function modifyMoney(moneyMod:int):void{
			money += moneyMod;
			if(moneyMod > 0){
				addPoints(moneyMod)
			}
		}
		
		// Adds points to the points bar. Also determines if a new powerup is unlocked
		private function addPoints(pointMod:int):void{
			points += pointMod;
			var pointsBarSection:int = Math.floor(points / Player.pointInterval);
			trace(this + " points: " + points + "; PointsBarSection: " + pointsBarSection);
			game.updatePointsBar(this, pointsBarSection);
			
			if(Document.devMode){
				availablePowerups = Powerup.allPowerups.length;
			}else{
				if(Math.floor(pointsBarSection / powerupInterval) > availablePowerups){
					availablePowerups = Math.floor(pointsBarSection / powerupInterval);
					trace(this + " POWERUP UNLOCKED: " + Powerup.allPowerups[availablePowerups-1]);
					if(this is Human){
						game.writeMessage("Human unlocked a powerup!");
					}else{
						game.writeMessage("Computer unlocked a powerup!");
					}
				}else{
					availablePowerups = Math.floor(pointsBarSection / powerupInterval);
				}
			}
			trace(this + "AVAILABLE POWERUPS: " + availablePowerups);

			pBox.updatePowerupsDisplay(this);
		}

		public function setActive(active:Boolean):void{
			is_active = active;
		}
	}
	
}
