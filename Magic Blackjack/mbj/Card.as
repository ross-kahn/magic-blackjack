package mbj {
	
	import flash.display.MovieClip;
	
	// Represents the concept of a card
	public class Card extends MovieClip {
		
		public static var cardVals:Array = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"];
		public static var cardSuits:Array = ["SPADE", "HEART", "CLUB", "DIAMOND", "MAGIC"];
		public static const SPADE:int = 0;
		public static const HEART:int = 1;
		public static const CLUB:int = 2;
		public static const DIAMOND:int = 3;
		public static const MAGIC:int = 4;
		
		private var val:String;
		private var pointVal:int;
		public function get PointVal(){return pointVal;}
		
		private var suit:String;
		private var isMagic:Boolean;
		public function get IsMagic(){ return isMagic;}
		
		private var isAce:Boolean;
		public function get IsAce(){return isAce;}
		
		public function Card(cardVal:int = 1, asuit:int = 4, magic:Boolean = false) {
			// constructor code
			
			if(cardVal < 1){
				val = cardVal.toString();
				cardVal_txt.text = val;
				cardVal_txt1.text = val;
				
			}else{
				val = cardVals[cardVal - 1];
				cardVal_txt.text = val;
				cardVal_txt1.text = val;
			}
			suit = cardSuits[asuit];
			isMagic = magic;
			if(cardVal == 1){
				isAce = true;
			}else{
				isAce = false;
			}
			pointVal = findPointVal(cardVal);
		}
		
		// Turns a card into a '1' card instead of an ace, which are automatically set to 11 under certain conditions
		public function makeNonAce():void{
			if(isAce){
				isAce = false;
				pointVal = 1;
				val = "1";
				cardVal_txt.text = val;
				cardVal_txt1.text = val;
			}
		}
		
		// Returns the point value of a card in terms of blackjack (10 and higher are worth 10, aces are worth 1 or 11)
		private function findPointVal(cardVal:int):int{
			if(cardVal > 9){
				return 10;
			}else if(cardVal != 1 && cardVal < 10){
				return cardVal;
			}else if(cardVal == 1){
				if(isAce){
					return 11;
				}else{
					return 1;
				}
			}else if(cardVal < 1){
				return cardVal;
			}else{
				trace("Unexpected card with value " + cardVal);
				return 50;
			}
		}
		
		override public function toString():String{
			return suit + " " + val;
		}
	}
	
}
