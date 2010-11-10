package be.irail.api.event {
	import flash.events.ErrorEvent;

	/**
	 * Error event dispatched when fatal error occurs within the API
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	public class IRailErrorEvent extends ErrorEvent {
		public static const IO_ERROR:String = "ioError";
		public static const API_ERROR:String = "apiError";

		// ----------------------------
		// originalErrorEvent
		// ----------------------------

		private var _originalErrorEvent:ErrorEvent;

		/**
		 * Original error event
		 * @see flash.events.ErrorEvent
		 */
		public function get originalErrorEvent():ErrorEvent {
			return _originalErrorEvent;
		}

		public function set originalErrorEvent(value:ErrorEvent):void {
			if (value != _originalErrorEvent) {
				_originalErrorEvent = value;
			}
		}

		public function IRailErrorEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "") {
			super(type, bubbles, cancelable, text);
		}
	}
}