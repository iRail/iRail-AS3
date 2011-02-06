package be.irail.api.data.liveboard {

	import be.irail.api.data.stations.IRStation;

	/**
	 * Station Liveboard information
	 * RemoteClass alias: irail.Liveboard
	 *  @author Joris Timmerman
	 */
	[RemoteClass(alias="irail.Liveboard")]
	public class Liveboard {
		public function Liveboard() {
		}

		// ----------------------------
		// station
		// ----------------------------

		private var _station:IRStation;

		/**
		 * Liveboard station  (station where this liveboard is for)
		 */
		public function get station():IRStation {
			return _station;
		}

		public function set station(value:IRStation):void {
			if (value != _station) {
				_station = value;
			}
		}

		// ----------------------------
		// departures
		// ----------------------------

		private var _departures:Array = [];

		/**
		 * Station departures
		 */
		public function get departures():Array {
			return _departures;
		}

		public function set departures(value:Array):void {
			if (value != _departures) {
				_departures = value;
			}
		}

		// ----------------------------
		// arrivals
		// ----------------------------

		private var _arrivals:Array = [];

		/**
		 * Station arrivals
		 */
		public function get arrivals():Array {
			return _arrivals;
		}

		public function set arrivals(value:Array):void {
			if (value != _arrivals) {
				_arrivals = value;
			}
		}
	}
}