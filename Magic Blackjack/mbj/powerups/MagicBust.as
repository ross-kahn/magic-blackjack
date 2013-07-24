package mbj.powerups {

	import mbj.Player;
	import mbj.Card;
	import flash.events.MouseEvent;

	public class MagicBust extends Powerup{

		private var modRange = 4; 	// modRange-1 = The highest number you can raise another player's point count by

		public function MagicBust(probability:Number = .2) {
			super(probability);
			// constructor code
			addEventListener(MouseEvent.CLICK, userActivate);
		}
		
		private function userActivate(e:MouseEvent){
			activate(game.human);
		}
		
		// Finds random value from 1-3. Creates a 'magic' card, then deals it to the opponent player
		override public function activate(player:Player){
			var modValue:int = 0;
			while(modValue <= 0){
				modValue = (Math.random()*52)%modRange;
			}
			var mCard:Card = new Card(modValue, Card.MAGIC, true);
			if(modValue == 1){
				mCard.makeNonAce();
			}
			game.getDealer().dealMagicCard(game.getOpponentPlayer(player), mCard);
			player.usePowerup(Powerup.MAGIC_RAISE);
		}
		
		public function showHelpMessage(e:MouseEvent):void{
			
		}
		
		public function hideHelpMessage(e:MouseEvent):void{
			
		}

	}
	
}
