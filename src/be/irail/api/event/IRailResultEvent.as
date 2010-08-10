package be.irail.api.event {
	import flash.events.Event;

	/**
	 * Result event dispatched when requested data has returned succesfully.<br/>
	 * Result data can be found in <code>result</code> property.
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 *
	 * 	@see be.irail.api.event.IRailResult
	 */
	public class IRailResultEvent extends Event {

		public static const ALL_STATIONS_RESULT:String = "allStationsResult";
		public static const SCHEDULER_RESULT:String = "schedulerResult";

		private var _data:IRailResult;

		/**
		 * IRail result object containing result and timestamp
		 */
		public function get result():IRailResult {
			return _data;
		}

		public function IRailResultEvent(type:String, data:IRailResult, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_data = data;
		}
	}
}