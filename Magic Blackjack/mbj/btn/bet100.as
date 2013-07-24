package mbj.btn {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import mbj.Document;
	
	
	public class bet100 extends SimpleButton {
		
		
		public function bet100() {
			// constructor code
			addEventListener(MouseEvent.CLICK, addToPot);
		}
		
		// Adds 100 to the pot from the player's money if he has enough
		public function addToPot(e:MouseEvent):void{
			if((parent as Document).getGame().human.Money >= 100){
				(parent as Document).getGame().human.bet(100);
			}
		}
	}
	
}
