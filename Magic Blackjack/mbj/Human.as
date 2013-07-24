package mbj {
	import mbj.powerups.PowerupBox;
	
	public class Human extends Player{

		public function Human(agame:Game, powerupBox:PowerupBox) {
			// constructor code
			super(agame, powerupBox);
		}
		
		public function bet(amount:int):void{
			game.addToPot(amount);
			money -= amount;
		}
		
		

	}
	
}
