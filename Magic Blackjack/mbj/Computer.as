package mbj {
	import mbj.powerups.PowerupBox;
	import mbj.powerups.Powerup;
	import mbj.powerups.MagicBust;
	import mbj.powerups.MagicLower;
	import mbj.powerups.MagicAce;
	import mbj.powerups.PowerHit;
	import mbj.powerups.DoublePot;
	
	public class Computer extends Player{

		public function Computer(agame:Game, powerupBox:PowerupBox) {
			// constructor code
			super(agame, powerupBox);
		}
		
		// Bets a certain amount according to conditions
		public function bet():void{
			var amount:int = 0;
			if(money > 1000){
				amount = 500;
			}else if(money > 500){
				amount = 100;
			}else if(money > 100){
				amount = 50;
			}else if(amount > 50){
				amount = 25
			}else if(amount > 10){
				amount = 10;
			}else if(amount > 5){
				amount = 5;
			}else{
				amount = money;
			}
			
			game.addToPot(amount);
			money -= amount;
		}
		
		// Uses powerups based on certain conditions
		public function useBestPowerup(){
			// highest-lowest priority
			// power raise, power lower, power hit, power ace, double pot
			if(game.human.Cardstack.calcPoints() >= 20){
				if(activePowerups[Powerup.MAGIC_RAISE]){
					new MagicBust().activate(this);
					return;
				}else if(activePowerups[Powerup.MAGIC_LOWER]){
					new MagicLower().activate(this);
					return;
				}
			}
			if((this.cardstack.calcPoints() <= 10) && (this.cardstack.calcPoints() >= 8)){
				if(activePowerups[Powerup.MAGIC_ACE]){
					new MagicAce().activate(this);
					return
				}
			}
			if(this.cardstack.calcPoints() <= 16){
				if(activePowerups[Powerup.POWER_HIT]){
					new PowerHit().activate(this);
					return;
				}
			}
			if(activePowerups[Powerup.DOUBLE_POT]){
				new DoublePot().activate(this);
				return;
			}
		}

	}
	
}
