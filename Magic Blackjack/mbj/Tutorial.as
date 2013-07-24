package mbj {
	import flash.display.MovieClip;
	
	public class Tutorial extends MovieClip{

		private var tutorialScreen:int;
		private var parent_doc:Document

		public function Tutorial(p:Document) {
			// constructor code
			trace("Tutorial made");
			tutorialScreen = 0;
			parent_doc = p;
		}

		// Overlays the tutorial over the main game screen. 
		public function start_tutorial(){
			trace("Tutorial started");
			parent_doc.addChild(this);
			this.x = parent_doc.x;
			this.y = parent_doc.y;
			tutorialScreen = 0;
			gotoAndStop(tutorialScreen);
		}
		
		// Advances the tutorial
		public function progress_tutorial(){
			tutorialScreen++;
			play();
		}
		
		// Removes tutorial from the screen
		public function endTutorial(){
			tutorialScreen = 0;
			parent_doc.removeChild(this);
		}

	}
	
}
