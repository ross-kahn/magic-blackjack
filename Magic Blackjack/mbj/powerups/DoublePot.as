package mbj.powerups {

	import mbj.Player;
	import flash.events.MouseEvent;

	public class DoublePot extends Powerup{

		public function DoublePot(probability:Number = .9) {
			// constructor code
			super(probability);
			addEventListener(MouseEvent.CLICK, userActivate);
		}
		
		private function userActivate(e:MouseEvent){
			activate(game.human);
		}
		
		override public function activate(player:Player){
			game.doublePot();
			player.usePowerup(Powerup.DOUBLE_POT);
		}

	}
	
}
