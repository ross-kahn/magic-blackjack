package mbj.powerups {
	
	import mbj.Player;
	import mbj.Document;
	import flash.events.MouseEvent;
	import mbj.Card;
	
	public class MagicAce extends Powerup{

		public function MagicAce(probability:Number = .7) {
			// constructor code
			super(probability);
			addEventListener(MouseEvent.CLICK, userActivate);
		}
		
		private function userActivate(e:MouseEvent){
			activate(game.human);
		}
		
		// Creates a 'magic' ace card. Deals it to the player
		override public function activate(player:Player){
			var mCard:Card = new Card(1, Card.MAGIC, true);
			game.getDealer().dealMagicCard(player, mCard);
			player.usePowerup(Powerup.MAGIC_ACE);
		}
		

	}
	
}
