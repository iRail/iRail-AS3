package be.irail.api.data.scheduler {
	import be.irail.api.data.stations.IRStation;
	import be.irail.api.data.stations.IRStationPlatform;

	public class ViaIRGate {
		// ----------------------------
		// id
		// ----------------------------

		private var _id:int;

		/**
		 * Via connect gate no.
		 */
		public function get id():int {
			return _id;
		}

		public function set id(value:int):void {
			if (value !== _id) {
				_id = value;
			}
		}

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

		// ----------------------------
		// timeBetween
		// ----------------------------

		private var _timeBetween:Number;

		/**
		 * Time between
		 */
		public function get timeBetween():Number {
			return _timeBetween;
		}

		public function set timeBetween(value:Number):void {
			if (value !== _timeBetween) {
				_timeBetween = value;
			}
		}

		// ----------------------------
		// arrivalTime
		// ----------------------------

		private var _arrivalTime:Date;

		/**
		 * Date &amp; Time of arrival
		 */
		public function get arrivalDate():Date {
			return _arrivalTime;
		}

		public function set arrivalDate(value:Date):void {
			if (value !== _arrivalTime) {
				_arrivalTime = value;
			}
		}

		// ----------------------------
		// arriveAtPlatform
		// ----------------------------

		private var _arriveAtPlatform:IRStationPlatform;

		/**
		 * Arrival platform
		 */
		public function get arriveAtPlatform():IRStationPlatform {
			return _arriveAtPlatform;
		}

		public function set arriveAtPlatform(value:IRStationPlatform):void {
			if (value != _arriveAtPlatform) {
				_arriveAtPlatform = value;
			}
		}
		// ----------------------------
		// departTime
		// ----------------------------

		private var _departTime:Date;

		/**
		 * Date &amp; Time of departure
		 */
		public function get departTime():Date {
			return _departTime;
		}

		public function set departTime(value:Date):void {
			if (value !== _departTime) {
				_departTime = value;
			}
		}

		// ----------------------------
		// departAtPlatform
		// ----------------------------

		private var _departAtPlatform:IRStationPlatform;

		/**
		 * Departure platform
		 */
		public function get departAtPlatform():IRStationPlatform {
			return _departAtPlatform;
		}

		public function set departAtPlatform(value:IRStationPlatform):void {
			if (value != _departAtPlatform) {
				_departAtPlatform = value;
			}
		}
	}
}