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

		public function IRailErrorEvent(type:String, originalEvent:ErrorEvent, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "") {
			super(type, bubbles, cancelable, text);
			_originalErrorEvent = originalEvent;
		}
	}
}