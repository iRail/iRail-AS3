package be.irail.api.data.scheduler {
	import be.irail.api.data.stations.IRailStation;

	/**
	 * Contains information about the arrival or departure of a train in a certain station.
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	public class TrainGate {
		// ----------------------------
		// station
		// ----------------------------

		private var _station:IRailStation;

		/**
		 * Station
		 * @see be.irail.api.data.stations.IRailStation
		 */
		public function get station():IRailStation {
			return _station;
		}

		public function set station(value:IRailStation):void {
			if (value != _station) {
				_station = value;
			}
		}

		// ----------------------------
		// dateTime
		// ----------------------------

		private var _dateTime:Date;

		/**
		 * Time of arrival/departure
		 */
		public function get dateTime():Date {
			return _dateTime;
		}

		public function set dateTime(value:Date):void {
			if (value != _dateTime) {
				_dateTime = value;
			}
		}

		// ----------------------------
		// formattedDate
		// ----------------------------

		private var _formattedDate:String;

		/**
		 * Formatted string of the arrival/departure date
		 */
		public function get formattedDate():String {
			return _formattedDate;
		}

		public function set formattedDate(value:String):void {
			if (value !== _formattedDate) {
				_formattedDate = value;
			}
		}

		// ----------------------------
		// formattedTime
		// ----------------------------

		private var _formattedTime:String;

		public function get formattedTime():String {
			return _formattedTime;
		}

		/**
		 * Formatted string of the arrival/departure time
		 */
		public function set formattedTime(value:String):void {
			if (value != _formattedTime) {
				_formattedTime = value;
			}
		}

	}
}