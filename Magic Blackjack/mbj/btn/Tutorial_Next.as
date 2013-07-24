package mbj.btn {
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	import flash.display.MovieClip;
	import mbj.Tutorial;
	
	public class Tutorial_Next extends SimpleButton{

		public function Tutorial_Next() {
			// constructor code
			addEventListener(MouseEvent.CLICK, doNext);
		}
		
		public function doNext(e:MouseEvent){
			(parent as Tutorial).progress_tutorial();
		}

	}
	
}
