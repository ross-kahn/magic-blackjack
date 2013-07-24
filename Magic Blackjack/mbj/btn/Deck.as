package mbj.btn {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import mbj.Document;
	
	
	public class Deck extends SimpleButton {
		
		
		public function Deck() {
			// constructor code
			addEventListener(MouseEvent.CLICK, deal);
		}
		
		public function deal(e:MouseEvent):void{
			trace("dealer pressed");
			(parent as Document).getGame().getDealer().deal();
		}
	}
	
}
