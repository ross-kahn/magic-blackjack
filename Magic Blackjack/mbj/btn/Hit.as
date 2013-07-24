package mbj.btn {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import mbj.Document;
	import mbj.Game;
	
	
	public class Hit extends SimpleButton {
		
		
		public function Hit() {
			// constructor code
			addEventListener(MouseEvent.CLICK, hit);
		}
		
		public function hit(e:MouseEvent):void{
			var game:Game = (parent as Document).getGame();
			game.getDealer().hit(game.human);
		}
	}
	
}
