package mbj {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class GameOver extends MovieClip {
		
		
		public function GameOver(m:String) {
			// constructor code
			trace("GAME OVER!");
			msg_txt.text = m;
		}
		
		public function playagain(e:MouseEvent){
			(parent as Document).startGame(e);
		}
	}
	
}
