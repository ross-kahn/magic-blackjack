package mbj.powerups {
	import mbj.Player;
	import flash.display.SimpleButton;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import mbj.Game;
	import mbj.Dealer;
	import flash.utils.Dictionary;

	// Superclass for all powerups. Provides some constants that refer to the indices of powerups in an array of all of them.
	public class Powerup extends SimpleButton{

		public static var allPowerups:Vector.<Powerup>;
		public static const DOUBLE_POT:int = 0;
		public static const MAGIC_ACE:int = 1;
		public static const POWER_HIT:int = 2;
		public static const MAGIC_LOWER:int = 3;
		public static const MAGIC_RAISE:int = 4;
		protected static var game:Game;
		private var prob:Number;
		
		public function get Probability():Number { return prob;}

		public function Powerup(probability:Number) {
			// constructor code
			prob = probability;
		}
		
		public static function initAllPowerups(g:Game){
			//allPowerups = new Vector.<Powerup>();
			game = g;
			allPowerups = new Vector.<Powerup>();
			
			// The order these are put in matters, because it is the order they will be unlocked
			allPowerups.push(new DoublePot(), new MagicAce(), new PowerHit(),  new MagicLower(), new MagicBust());
		}
		
		// Provides default functionality for a powerup, but is meant to be
		// overriden by a subclass
		public function activate(player:Player){
			trace("This powerup has no effect.");
		}

	}
	
}
