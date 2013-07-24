package mbj.btn {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import mbj.Tutorial;
	
	
	public class CloseTutorialBtn extends SimpleButton {
		
		
		public function CloseTutorialBtn() {
			// constructor code
			addEventListener(MouseEvent.CLICK, doClose);
		}
		
		public function doClose(e:MouseEvent){
			(parent as Tutorial).endTutorial();
		}
	}
	
}
