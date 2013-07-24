package mbj.btn {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import mbj.Game;
	import mbj.Document;
	
	public class Stay extends SimpleButton {
		
		public function Stay() {
			// constructor code
			addEventListener(MouseEvent.CLICK, stay);
		}
		
		public function stay(e:MouseEvent):void{
			var game:Game = (parent as Document).getGame();
			game.getDealer().stay(game.human);
		}
	}
	
}
