package be.irail.api.data.scheduler.gate {
	import be.irail.api.data.stations.IRStation;
	import be.irail.api.data.stations.IRStationPlatform;
	import be.irail.api.data.vehicle.IRVehicle;

	/**
	 * Contains information about the arrival or departure of a train in a certain station.
	 * RemoteClass alias: irail.IRGate
	 * @author Joris Timmerman
	 */
	[RemoteClass(alias="irail.IRGate")]
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
		// delay
		// ----------------------------

		private var _delay:Number;

		/**
		 * arrival/departure delay in seconds
		 */
		public function get delay():Number {
			return _delay;
		}

		public function set delay(value:Number):void {
			if (value !== _delay) {
				_delay = value;
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
		// vehicle
		// ----------------------------

		private var _vehicle:IRVehicle;

		/**
		 * Vehicle
		 **/
		public function get vehicle():IRVehicle {
			return _vehicle;
		}

		public function set vehicle(value:IRVehicle):void {
			if (value != _vehicle) {
				_vehicle = value;
			}
		}
	}
}