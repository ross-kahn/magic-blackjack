package mbj.btn {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import mbj.Document;
	import mbj.Tutorial;
	
	public class Tutorial_Start extends SimpleButton {
		
		
		public function Tutorial_Start() {
			// constructor code
			addEventListener(MouseEvent.CLICK, doStart);
		}
		
		// Makes tutorial window pop up
		public function doStart(e:MouseEvent){
			(parent as Document).Tutorial_main.start_tutorial();
		}
	}
	
}
