package mbj.btn {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import mbj.Document;
	
	
	public class bet50 extends SimpleButton {
		
		
		public function bet50() {
			// constructor code
			addEventListener(MouseEvent.CLICK, addToPot);
		}
		
		// Adds 50 to the pot if the player has enough
		public function addToPot(e:MouseEvent):void{
			if((parent as Document).getGame().human.Money >= 50){
				(parent as Document).getGame().human.bet(50);
			}
		}
	}
	
}
