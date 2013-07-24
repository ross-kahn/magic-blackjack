package mbj.powerups {
	
	import mbj.Player;
	import mbj.Dealer;
	import flash.events.MouseEvent;
	import mbj.Card;
	
	public class PowerHit extends Powerup{

		public function PowerHit(probability:Number = .5) {
			// constructor code
			super(probability);
			addEventListener(MouseEvent.CLICK, userActivate);
		}
		
		public function userActivate(e:MouseEvent):void{
			activate(game.human);
		}
		
		// Generates 3 random cards, and chooses the best one for the player (may still bust)
		override public function activate(player:Player){
			var cVec:Vector.<Card> = getThreeCards();
			trace(player + " has used Power Hit. 3 Card values:");
			var bestCardIndex:int = 0;
			var bestScore:int = 0;
			var curCard:Card;
			var newScore:int;
			for(var i:int=0; i < 3; i++){
				curCard = cVec[i];
				trace(curCard.toString());
				newScore = player.Cardstack.calcPoints() + curCard.PointVal;
				if((newScore <= 21) && (newScore >= bestScore)){
					bestCardIndex = i;
					bestScore = newScore;
				}
			}
			trace("Best card: " + cVec[bestCardIndex].toString());
			game.getDealer().dealMagicCard(player, cVec[bestCardIndex]);
			player.usePowerup(Powerup.POWER_HIT);
		}
		
		private function getThreeCards():Vector.<Card>{
			var cVec:Vector.<Card> = new Vector.<Card>();
			
			for(var i:int=0; i<3; i++){
				var c:Card = new Card(getRando(), Card.MAGIC, true);
				c.makeNonAce();
				cVec.push(c);
			}
			return cVec;
		}
		
		// Generates a random number, used to pick from a card value 1-11. While loop inserted to
		// fix infrequent error where the random number calculation returns -1
		private function getRando():int{
			var rando:int = Math.round(Math.random()*13);
			while(rando < 0){
				rando = Math.round(Math.random()*13);
			}
			//trace("Random card: " + rando);
			return rando;
		}

	}
	
}
