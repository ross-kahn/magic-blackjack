package mbj {
	
	// A Very important class. Does everything related to turn order and dealing cards
	public class Dealer {

		private var game:Game;
		private var allCards:Vector.<Card>;
		private var cardStacks:Vector.<CardStack>;

		public function Dealer(agame:Game) {
			// constructor code
			game = agame;
			allCards = new Vector.<Card>();
			allCards = genCards();
			cardStacks = new Vector.<CardStack>();
			cardStacks.push(game.humanCardstack, game.compCardstack);
		}
		
		// Puts all the dealt cards back into the deck
		public function shuffle():void{
			allCards = genCards();
			for each(var cs:CardStack in cardStacks){
				cs.reset();
			}
		}
		
		// Gives a player a magic card. game.test() is a print statement used for debugging
		public function dealMagicCard(recipient:Player, c:Card){
			game.test();
			recipient.Cardstack.addCard(c);
			game.test();
			game.calcPoints();
		}
		
		// Generates all the card objects in the normal deck
		private function genCards():Vector.<Card>{
			var cards:Vector.<Card> = new Vector.<Card>();
			var spade:Card;
			var heart:Card;
			var diamond:Card;
			var club:Card;
			
			// create cards with starting at 1, because
			// Card takes the exact value of the card for a parameter (starts
			// at 1 for Ace and ends at 13 for King)
			for(var i:int = 1; i <= Card.cardVals.length; i++){
				spade = new Card(i, Card.SPADE)
				heart = new Card(i, Card.HEART);
				diamond = new Card(i, Card.DIAMOND);
				club = new Card(i, Card.CLUB);
				cards.push(spade, heart, diamond, club);
			}
			return cards;
		}
		
		// Deals each player 2 cards, then gives the turn to the human player
		public function deal():void{
			trace("Dealing...");
			game.deal();		// disables dealer button
			shuffle();			// resets allCards so it contains every possible card. Also resets cardstacks
			
			var tempCard:Card;
			
			for each(var cs:CardStack in cardStacks){
				tempCard = chooseRandomCard();
				cs.addCard(tempCard);
				
				tempCard = chooseRandomCard();
				cs.addCard(tempCard);
			}
			
			game.calcPoints();
			game.playHuman();
		}
		
		// the player has requested a card. Deals him one, then switches turns as long as the player didn't bust
		public function hit(player:Player){
			//trace(player + " has hit");
			player.getCard(chooseRandomCard());
			game.test();
			game.calcPoints()
			game.test();
			//trace("Switching players");
			// Switch players if the other player is active
			switchTurns(player, !game.opponentActive(player));
		}
		
		// the player has requested to stay. Switches turns as long as the other player is still active. Otherwise ends the hand
		public function stay(player:Player){
			//trace(player + " has stayed");
			player.setActive(false);
			game.test();
			var normalPlay:Boolean = game.calcPoints();
			
			//trace("normalPlay: " + normalPlay + "; opponentActive: " + game.opponentActive(player) + "; Current player: " + player);
			(game.parent as Document).showDisk(player, Document.STAY);
			// Current player should switch, either due to normal gameplay or
			// because the current player has stayed and the other player is not done
			if(normalPlay){	
				//trace("Switching players");
				switchTurns(player, false);
			}else{
				switchTurns(player, player.Is_Active);
			}
		}
		
		// Gives the turn to the opposite player, as long as the opposite player is active. Otherwise, stays on the current player's turn
		private function switchTurns(currentPlayer:Player, loop:Boolean):void{
			//trace("opponentActive: " + game.opponentActive(currentPlayer) + "; Current player: " + currentPlayer);
			//game.test();
			if(currentPlayer is Human){
				if(loop){
					game.playHuman();
				}else{
					game.playComputer();
				}
			}else if(currentPlayer is Computer){
				if(loop){
					game.playComputer();
				}else{
					game.playHuman();
				}
			}else{
				trace("No switchTurn option for class " + currentPlayer);
			}
		}
		
		// Takes a random card from the deck
		private function chooseRandomCard():Card{
			var card:Card = allCards[getRando()];
			allCards.splice(allCards.indexOf(card), 1);
			return card;
		}
		
		// Generates a random number, used to pick from the deck. While loop inserted to
		// fix infrequent error where the random number calculation returns -1
		private function getRando():int{
			var rando:int = Math.round(Math.random()*allCards.length-1);
			while(rando < 0){
				rando = Math.round(Math.random()*allCards.length-1);
			}
			//trace("Random card: " + rando);
			return rando;
		}

	}
	
}
