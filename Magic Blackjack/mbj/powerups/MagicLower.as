package mbj.powerups {

	import mbj.Player;
	import flash.events.MouseEvent;
	import mbj.Card;
	import mbj.Dealer;
	
	public class MagicLower extends Powerup{

		private var modRange = 4; 	// modRange-1 = The highest number you can lower another player's point count by

		public function MagicLower(probability:Number = .4) {
			super(probability);
			// constructor code
			addEventListener(MouseEvent.CLICK, userActivate);
		}
		
		private function userActivate(e:MouseEvent){
			activate(game.human);
		}
		
		
		// finds random number 1-3. Creates a 'magic' card with the negative of that value, then deals it to the opponent player
		override public function activate(player:Player){
			var modValue:int = 0;
			while(modValue <= 0){
				modValue = (Math.random()*52)%modRange;
			}
			var mCard:Card = new Card(0-modValue, Card.MAGIC, true);
			game.getDealer().dealMagicCard(game.getOpponentPlayer(player), mCard);
			player.usePowerup(Powerup.MAGIC_LOWER);
		}
		
		public function showHelpMessage(e:MouseEvent):void{
			
		}
		
		public function hideHelpMessage(e:MouseEvent):void{
			
		}

	}
	
}
