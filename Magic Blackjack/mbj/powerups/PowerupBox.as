package mbj.powerups {
	import mbj.Player;
	import flash.display.MovieClip;
	
	
	// Super class for both the user's powerupbox and the computer's powerup box
	public class PowerupBox extends MovieClip{

		protected var pBoxes:Vector.<MovieClip>;
		
		public function PowerupBox() {
			// constructor code
			pBoxes = new Vector.<MovieClip>();
		}
		
		// Enable all the powerups that the player has active
		public function updatePowerupsDisplay(player:Player){
			for(var i:int=0; i<player.ActivePowerups.length; i++){
				if(player.ActivePowerups[i]){
					pBoxes[i].visible = true;
				}else{
					pBoxes[i].visible = false;
				}
			}
		}

	}
	
}
