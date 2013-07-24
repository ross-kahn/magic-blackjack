package mbj {
	
	import flash.display.MovieClip;
	
	
	public class PointsBar extends MovieClip {
		
		private var win:Boolean;
		public function get Win():Boolean { return win;}
		
		
		public function PointsBar() {
			// constructor code
			win = false;
		}
		
		// Creates effect of the bar going up
		public function addPoints(){
			play();
		}
		
		// goes to a certain points location
		public function goToPoints(i:int){
			trace("GOING TO POINT VALUE: " + i);
			if(i <= 30){
				gotoAndStop("p"+i.toString());
			}else{
				gotoAndStop("win");
				win = true;
			}
		}
	}
	
}
