package be.irail.api.event {

	/**
	 * Data object containing result of query.
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	[RemoteClass(alias="irail.IRailResult")]
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
			if (value != _timestamp) {
				_timestamp = value;
			}
		}

		// ----------------------------
		// version
		// ----------------------------

		private var _version:String;

		/**
		 * Data version
		 */
		public function get version():String {
			return _version;
		}

		public function set version(value:String):void {
			if (value != _version) {
				_version = value;
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
			if (value != _data) {
				_data = value;
			}
		}

		public function IRailResult(data:Object = null, timestamp:String = null, version:String = null):void {
			this.data = data;
			this.timestamp = timestamp;
			this.version = version;
		}
	}
}