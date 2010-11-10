package be.irail.api.data.scheduler {
	import be.irail.api.data.stations.IRStation;
	import be.irail.api.data.stations.IRStationPlatform;

	/**
	 * Contains information about the arrival or departure of a train in a certain station.
	 *<br/><br/>
	 * created 06/08/2010
	 * @author Joris Timmerman
	 */
	public class IRGate {
		// ----------------------------
		// station
		// ----------------------------

		private var _station:IRStation;

		/**
		 * Station
		 * @see be.irail.api.data.stations.IRailStation
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
		// platform
		// ----------------------------

		private var _platform:IRStationPlatform;

		/**
		 * Arrival/departure plaform
		 */
		public function get platform():IRStationPlatform {
			return _platform;
		}

		public function set platform(value:IRStationPlatform):void {
			if (value !== _platform) {
				_platform = value;
			}
		}

		// ----------------------------
		// vehicule
		// ----------------------------

		private var _vehicule:IRVehicle;

		/**
		 * Vehicle
		 **/
		public function get vehicule():IRVehicle {
			return _vehicule;
		}

		public function set vehicule(value:IRVehicle):void {
			if (value != _vehicule) {
				_vehicule = value;
			}
		}
	}
}