package mbj.btn {
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import mbj.Document;
	import mbj.GameOver;
	
	public class Play_Btn extends SimpleButton{

		public function Play_Btn() {
			// constructor code
			addEventListener(MouseEvent.CLICK, doPlay);
		}
		
		// If the button is the one on the first screen, start the game. If it's the one on the gameover screen, reset
		public function doPlay(e:MouseEvent){
			if(parent is GameOver){
				(parent as GameOver).playagain(e);
			}else{
				(parent as Document).startGame(e);
			}
		}

	}
	
}
