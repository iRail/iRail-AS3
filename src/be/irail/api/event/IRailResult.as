package be.irail.api.event {

	/**
	 * Data object containing result of query.
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	public class IRailResult {
		// ----------------------------
		// timestamp
		// ----------------------------

		private var _timestamp:String;

		/**
		 * Timestamp of result
		 */
		public function get timestamp():String {
			return _timestamp;
		}

		public function set timestamp(value:String):void {
			if (value !== _timestamp) {
				_timestamp = value;
			}
		}

		// ----------------------------
		// data
		// ----------------------------

		private var _data:Object;

		/**
		 * Result data
		 */
		public function get data():Object {
			return _data;
		}

		public function set data(value:Object):void {
			if (value !== _data) {
				_data = value;
			}
		}

		public function IRailResult(timestamp:String, data:Object):void {
			this.timestamp = timestamp;
			this.data = data;
		}
	}
}