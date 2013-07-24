package mbj {
	
	import flash.display.MovieClip;
	
	// Represents a 'hand' of cards
	public class CardStack extends MovieClip {
		
		private var activeCards:Vector.<Card>;
		private var numAces:int;
		
		public function CardStack() {
			// constructor code
			activeCards = new Vector.<Card>();
			numAces = 0;
		}
		
		// Empties the hand
		public function reset():void{
			numAces = 0;
			for each(var c:Card in activeCards){
				removeChild(c);
			}
			activeCards = new Vector.<Card>();
			trace_box.visible = true;
		}
		
		public function addCard(card:Card):void{
			trace_box.visible = false;
			addChild(card);
			card.x += 25 * activeCards.length;
			activeCards.push(card);
			if(card.IsAce){
				trace("Ace Received");
				numAces++;
			}
		}
		
		public function addCards(cards:Vector.<Card>):void{
			for each(var card:Card in cards){
				addCard(card);
			}
		}
		
		/* For each ace, check to see if all set
			to 11 is below 21. If not, cycle through
			each ace, setting it to 1, until all aces
			have been modified
		*/
		public function calcPoints():int{
			var baseScore:int = 0;
			var newScore:int = 0;
			for each(var c:Card in activeCards){
				baseScore += c.PointVal;
			}
			
			// optimize aces
			if(baseScore > 21){
				newScore = baseScore;
				for(var i:int = 0; i<numAces; i++){
					newScore -= 10;
					if(newScore <= 21){
						return newScore;
					}
				}
				
				// bust, despite changes aces to 1s
				return newScore;
			}else{
				return baseScore;
			}
		}

	}
	
}
