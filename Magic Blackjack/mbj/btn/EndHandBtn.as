package mbj.btn {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import mbj.Document;
	import mbj.Player;
	
	
	public class EndHandBtn extends SimpleButton {
		
		private var winner:Player;
		private var tie:Boolean;
		
		public function EndHandBtn() {
			// constructor code'
			addEventListener(MouseEvent.CLICK, endhand);
			visible = false;
		}
		
		// Basically allows the player to see what happened before the next hand happens.
		private function endhand(e:MouseEvent):void{
			(parent as Document).getGame().playerWins(winner,tie);
			visible = false;
		}
		
		// Receives the winner of the game
		public function assignWinner(player:Player, isdraw:Boolean){
			visible = true;
			winner = player;
			tie = isdraw;
		}
	}
	
}
